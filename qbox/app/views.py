from flask import render_template, redirect, flash
from flask_appbuilder.models.sqla.interface import SQLAInterface
from flask_appbuilder import ModelView, ModelRestApi, BaseView, expose, has_access
from flask_appbuilder.actions import action


from . import appbuilder, db

from .models import Account, Project, Site, Area, Section, Box, Type, Group, Volume, Move, AdmFiles
import calendar
from datetime import datetime
from sqlalchemy import func, or_
import json
from flask import request

def month_last_day(d):
    return datetime.date(d.year, d.month, calendar.monthrange(d.year, d.month)[-1])



"""
    Create your Model based REST API::

    class MyModelApi(ModelRestApi):
        datamodel = SQLAInterface(MyModel)

    appbuilder.add_api(MyModelApi)


    Create your Views::


    class MyModelView(ModelView):
        datamodel = SQLAInterface(MyModel)


    Next, register your Views::


    appbuilder.add_view(
        MyModelView,
        "My View",
        icon="fa-folder-open-o",
        category="My Category",
        category_icon='fa-envelope'
    )

"""
# Endpoint per gestire la richiesta con parametro dalla URL
from .helpers import chart_to_csv, to_destroy_export, exportexcel, export_db
from flask import url_for

class AdmFilesModelView(ModelView):
    datamodel = SQLAInterface(AdmFiles)

    label_columns = {"file_name": "File Name", "download": "Download"}
    add_columns = ["file", "description"]
    edit_columns = ["file", "description"]
    list_columns = ["file_name", "description", "download"]
    show_columns = ["file_name", "description", "download"]
    
    list_title = "GPS-GTF File List"

class Export(BaseView):
    route_base = '/export'
    allow_browser_login = True
    
    @expose('/endlife/approval') 
    @has_access
    def approval(self):
        return to_destroy_export() 
    
    @expose('/endlife/docs') 
    @has_access
    def endlife(self):
        query = db.session.query(Volume).filter(Volume.endlife_date < datetime.today()).all()
        return exportexcel(query)
    
    @expose('/db/docs') 
    @has_access
    def db_docs(self):
        return export_db()
        



class Dashboard(BaseView):
    route_base = '/dashboard'
    allow_browser_login = True
    
    
    @expose('/chart/<string:title>/<string:param>')
    @has_access
    def chart(self,title,param):
        if title and param:
            csv = chart_to_csv(title,param)
            if csv:
                return csv   
        return redirect(self.get_redirect())
        
    
    @expose('/index/', methods=('GET','POST'))
    @has_access
    def index(self):
        search_str = '%%'
        book_search = '%%'
        if request.method == 'POST':
            if request.form['project']:
                search_str = request.form['project']+'%'
        if request.method == 'POST':
            book_search = '%'+request.form['name']+'%'
            
        
        
        last_entries = db.session.query(Volume).join(Project
                                            ).order_by(Volume.created_on.desc()
                                            ).filter(Project.code.like(search_str), Volume.name.like(book_search)
                                            ).limit(100).all()
        ie_tabledata = [{'Project': v.project.code,'Type': v.type.name, 'Name': v.name, 'Group': v.group.name, 'id': v.id, 'due_date': str(v.endlife_date) } for v in last_entries]
        #print(ie_tabledata)
        return self.render_template('index_table.html', ie_tabledata=ie_tabledata)
        
    @expose('/home/', methods=('GET','POST'))
    @has_access
    def home(self):
        search_str = '%%'
        book_search = '%%'
        if request.method == 'POST':
            if request.form['project']:
                search_str = '%'+request.form['project']+'%'
        if request.method == 'POST':
            book_search = '%'+request.form['name']+'%'
            
        
        last_moves = db.session.query(Move).join(Volume, Project
                                            ).order_by(Move.created_on.desc()
                                            ).filter(Project.code.like(search_str), Volume.name.like(book_search)
                                            ).limit(1000).all()
        last_entries = db.session.query(Volume).join(Project
                                            ).order_by(Volume.created_on.desc()
                                            ).filter(Project.code.like(search_str), Volume.name.like(book_search)
                                            ).limit(1000).all()
        print('step1')
        le_tabledata = [{'Project': v.project.code,'Type': v.type.name, 'Name': v.name, 'Group': v.group.name, 'id': v.id, 'due_date': str(v.endlife_date) } for v in last_entries]
        #   print(last_entries)
        print('step2')
        volume_group = db.session.query(func.count(Volume.id), Group.name
                                            ).join(Group, Project
                                            ).group_by(Group.name
                                            ).filter(Project.code.like(search_str), Volume.name.like(book_search)
                                            ).limit(1000
                                            ).all()
        print('step3')
        vg_labels = [x[1] for x in volume_group] 
        vg_data = [x[0] for x in volume_group]
        print('step4')
        vg_data = {
          'labels': vg_labels,
          'datasets': [{
            'label': 'Books by Group',
            'data': vg_data,
            'hoverOffset': 4
          }]
        }
        
        volume_site = db.session.query(func.count(Volume.id), Site.name
        ).join(
            Box, Section, Area, Site, Project
        ).group_by(
            Site.name
        ).filter(
            Project.code.like(search_str), Volume.name.like(book_search)
        ).limit(1000
        ).all()
        print('step5')
        vs_labels = [x[1] for x in volume_site]
        vs_data = [x[0] for x in volume_site]
        print('vs_label')
        print(vs_labels)
        print('vs_data')
        print(vs_data)
        
        vs_data = {
          'labels': vs_labels,
          'datasets': [{
            'label': 'My First Dataset',
            'data': vs_data,
            'backgroundColor': [
              'rgb(255, 99, 132)',
              'rgb(54, 162, 235)',
              'rgb(255, 205, 86)'
            ],
            'hoverOffset': 4
          }]
        }
        print('step6')
        volume_serie = db.session.query(
            Type.name,
            Project.code,
            func.count(Volume.id)
        ).join(Type, Project).group_by(
            Type.id,
            Project.id
        ).filter(
            Project.code.like(search_str), Volume.name.like(book_search) 
        ).limit(1000
        ).all()
        print('step6')
        e = {}
        prj_list = set()
        prj_list2 = db.session.query(Project
                                    ).join(Volume
                                    ).filter(Project.code.like(search_str), Volume.name.like(book_search)
                                    ).limit(1000
                                    ).all()
        
        for i in volume_serie:
            prj_list.add(i[1])
            #print(i[0],i[1],i[2])
            if i[0] in e:
                if i[1] in e[i[0]]:
                    e[i[0]][i[1]].append(i[2])
                else:
                    e[i[0]][i[1]] = [i[2]]
            else:
                e[i[0]] = {i[1]:[i[2]]}
        
        #print(e)    
        print('step7')        
        volume_serie_label = [ x for x in e]
        volume_serie_data = []
        #volume_serie_colors = [c.color for c in prj_list2]
        
        for project in prj_list2:
            data = []
            for type in e:
                try:
                    data.append(e[type][project.code][0])
                except:
                    data.append(0) 
            
            volume_serie_data.append({"label": project.code, "data": data, "color": project.color})
            #volume_serie_label.append(project.name)
        
        #print()
        #print(volume_serie_data)
        print('step8')

        
        volumes_endlife = db.session.query(func.year(Volume.endlife_date), Project.code, func.count(Volume.id), Project.color 
            ).join(Project
            ).group_by(func.year(Volume.endlife_date), Project.id
            ).filter(Project.code.like(search_str), Volume.name.like(book_search)
                     ).limit(1000
                    ).all()
        
        e = {}
        prj_list = set()
        prj_list2 = db.session.query(Project
                                    ).join(Volume
                                    ).filter(Project.code.like(search_str), Volume.name.like(book_search)
                                    ).limit(1000
                                    ).all()
        
        for i in volumes_endlife:
            prj_list.add(i[1])
            #print(i[0],i[1],i[2])
            if i[0] in e:
                if i[1] in e[i[0]]:
                    e[i[0]][i[1]].append(i[2])
                else:
                    e[i[0]][i[1]] = [i[2]]
            else:
                e[i[0]] = {i[1]:[i[2]]}
        print('step9')
        #print(e)    
                
        volume_endlife_labels = [ x for x in e]
        volume_endlife_data = []
        #volume_endlife_colors = [c.color for c in prj_list2]
        
        for project in prj_list2:
            data = []
            for year in e:
                try:
                    data.append(e[year][project.code][0])
                except:
                    data.append(0)
            volume_endlife_data.append({"label": project.code, "data": data, "color": project.color}) 
        
        print('step10')
        #print()
        print(volume_endlife_labels,volume_endlife_data)
        if request.method == 'POST':
            return self.render_template('dash2.html', 
                                    labels=volume_serie_label, 
                                    data=volume_serie_data,
                                    volume_endlife_labels=volume_endlife_labels,
                                    volume_endlife_data=volume_endlife_data,
                                    vs_data = vs_data,
                                    vs_labels=vs_labels,
                                    vg_data=vg_data,
                                    last_entries=last_entries,
                                    last_moves=last_moves,
                                    le_tabledata=le_tabledata
                                    )
            
        return self.render_template('qbox_dashboard.html', 
                                    labels=volume_serie_label, 
                                    data=volume_serie_data,
                                    volume_endlife_labels=volume_endlife_labels,
                                    volume_endlife_data=volume_endlife_data,
                                    vs_data=vs_data,
                                    vs_labels=vs_labels,
                                    vg_data=vg_data,
                                    last_entries=last_entries,
                                    last_moves=last_moves,
                                    le_tabledata=le_tabledata
                                    )
    
    
    
    @expose('/search/', methods=('GET','POST'))
    @has_access
    def search(self):
        if request.method == 'POST':
            volumes = db.session.query(Type.name ,func.count(Volume.id)).join(Volume, Project).group_by(Type.name).filter(
                or_(Volume.name.like('%'+request.form['project']+'%'),
                    Project.code.like('%'+request.form['project']+'%') )).limit(100).all()
            #volumes = db.session.query(Type.name ,func.count(Volume.id)).join(Volume, Project).group_by(
            #Type.id).filter(Project.name.like(request.form['project'])).all()
            #print('++++++ààà+++++àà  POST +à+à+à +à+à --- FOR: ', request.form['project'])
            #print('++++++ààà+++++àà  LEN VOLUMES +à+à --- FOR: ', len(volumes))
            #print(volumes)
            volume_labels = [ x[0] for x in volumes]
            volume_data = [x[1] for x in volumes]
            
            volumes_endlife = db.session.query(func.year(Volume.endlife_date), func.count(Volume.id)).join(Project, Type).group_by(
                                                func.year(Volume.endlife_date)).filter(Project.code.like('%'+ request.form['project']+'%')).all()
            
            #print('++++++ààà+++++àà  POST +à+à+à +à+à --- FOR: ', request.form['project'])
            #print('++++++ààà+++++àà  LEN VOLUMES ENDLIFE +à+à --- FOR: ', len(volumes_endlife))
                                                
            volume_endlife_labels = [ x[0] for x in volumes_endlife]
            volume_endlife_data = [x[1] for x in volumes_endlife]
            #print(volumes_endlife, volume_endlife_labels, volume_endlife_data)
            return self.render_template('dash2.html', 
                                    labels=volume_labels, 
                                    data=volume_data,
                                    volume_endlife_labels=volume_endlife_labels,
                                    volume_endlife_data=volume_endlife_data)
        
        
    @expose('/dash1/')
    @has_access
    def dash1(self):
        
        return str(db.session.query(Type.name ,func.count(Volume.id)).join(Volume).group_by(
            Type.id
        ).all())
    
    @expose('/volumes/')
    @has_access
    def dash1(self):
        
        return str(db.session.query(Type.name ,func.count(Volume.id)).join(Volume).group_by(
            Type.id
        ).all())

    
#appbuilder.add_view(Stats, "Method1", category='My View')
appbuilder.add_view_no_menu(Dashboard())


class GroupView(ModelView):
    datamodel = SQLAInterface(Group)
    list_columns = ['id', 'name','doc_count']
    add_columns = ['account','name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
    
    list_title = 'Group / Department'
    
    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())

class TypeView(ModelView):
    datamodel = SQLAInterface(Type)
    list_columns = ['id', 'name', 'retention_code','description', 'retention_days','doc_count']
    add_columns = ['account','name']
    show_columns = ['id', 'name', 'retention_code', 'retention_days','description','activation_on', 'security_class']
    edit_columns = ['name', 'retention_code', 'retention_days','description']
    
    list_title = 'Document Type'
    
    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())


class MoveView(ModelView):
    datamodel = SQLAInterface(Move)
    list_columns = ['last_change', 'name','volume']
    add_columns = ['volume','name']
    show_columns = ['id','last_change', 'name', 'volume', 'status']
    edit_columns = ['name', 'status']
    
    def pre_add(self, item):
        print()
        #item.name = 'XXXXXXXXXX'
        print('')
        print('------- POST ADD --  MOVE ---')
        session = self.appbuilder.get_session
        db.session.flush()
        print('item',item.id, 'volume', item.volume_id, 'created_on', item.created_on)
        last_move = db.session.query(Move).filter(
            Move.volume_id == item.volume_id,
            Move.id != item.id
        ).order_by(Move.created_on.desc()).first()
        
        print('item',item.id, 'volume', item.volume_id, 'created_on', item.created_on)

        last_status = False
        print('')
        if last_move:
            print('--- *-*-  Last MOVE status',last_move.id, last_move.status)
            last_status = last_move.status
        
        item.status = not last_status
        #db.session.flush(item)
        print('------*************-----------******')
        print(item.status)
        
        return super().pre_add(item)

from .helpers import write_csv, db_to_csv, exportexcel
from flask import Response, send_file
from io import BytesIO
from werkzeug.wsgi import FileWrapper
from datetime import timedelta
from flask_appbuilder.models.filters import Filters, BaseFilter, FilterRelation, BaseFilterConverter, Optional
from flask_appbuilder.models.sqla.filters import FilterNotEqual, FilterNotStartsWith

class VolumeProView(ModelView):
    datamodel = SQLAInterface(Volume)
    
    add_title = 'Add Document'
    show_title = 'Show Document'
    edit_title = 'Edit Document'
    list_title = 'List Documents'
    
    list_columns = ['project.code', 'name','group']
    add_columns = ['box','project','type','group', 'name','date_start','date_end','available','active']
    show_columns = ['box','box.section.area.site','box.section.area','box.section','project.account','project', 'type', 'group', 'name','request_by','date_start','date_end','activation_date','endlife_date','available','active']
    edit_columns = ['box','project','type','group', 'name','activation_date','available','active'] 
    
    
    label_columns = {
        'project.account': 'Account',
        'project.code': 'Project',
        'box.section.area.site': 'Site',
        'box.section.area': 'Area',
        'box.section': 'Section',
        'name': 'Document'
        
    }
     
    search_columns = ['project', 'type', 'group', 'name', 'date_start', 'date_end', 'endlife_date','box'] 
    related_views = [MoveView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    
    base_order = ('id','desc')
    
    
    #base_permissions = ['can_show','can_list']

class VolumeView(ModelView):
    datamodel = SQLAInterface(Volume)
    
    add_title = 'Add Document'
    show_title = 'Show Document'
    edit_title = 'Edit Document'
    list_title = 'List Documents'
    
    list_columns = ['project.code', 'name','group']
    add_columns = ['box','project','type','group', 'name','date_start','date_end','available','active']
    show_columns = ['box','box.section.area.site','box.section.area','box.section','project.account','project', 'type', 'group', 'name','request_by','date_start','date_end','activation_date','endlife_date','available','active']
    edit_columns = ['box','project','type','group', 'name','activation_date','available','active'] 
    
    
    label_columns = {
        'project.account': 'Account',
        'project.code': 'Project',
        'box.section.area.site': 'Site',
        'box.section.area': 'Area',
        'box.section': 'Section',
        'name': 'Document'
        
    }
     
    search_columns = ['project', 'type', 'group', 'name', 'date_start', 'date_end', 'endlife_date','box'] 
    related_views = [MoveView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    
    base_order = ('id','desc')
    base_permissions = ['can_show','can_list']
    #base_filters = [['box.section.area.site', FilterNotStartsWith, 'X']]
    
    
    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())
    
    '''
    @action("db_to_csv","Export All DB", icon= "fa-rocket", single=False)
    def db_to_csv(self, items):
        self.update_redirect()
        csv_file = db_to_csv()
        #return send_file('./static/downloads/output.csv', as_attachment=True, download_name='sal.csv')
        return csv_file
    '''
    @action(name="test",text= "Export Search", icon=  "fa-rocket" , single=False)
    def test(self, items):
        print(self._filters, type(self._filters)) 
        self.update_redirect()
        lst = self.datamodel.query(self._filters)
        resp = exportexcel(lst[1]) 
        if resp:
            return resp
        return redirect(self.get_redirect())
    
    def pre_add(self, item):
        item.activation_date = item.date_end + timedelta(days=1)
        item.endlife_date = item.activation_date + timedelta(days=item.type.retention_days)
        return super().pre_add(item)
    
    
from flask_appbuilder.forms import BooleanField, StringField,BS3TextAreaFieldWidget, TextAreaField, BS3TextFieldWidget 
from flask_appbuilder.models.sqla.filters import FilterStartsWith
from flask_appbuilder.utils.base import gettext
from flask_appbuilder.views import redirect, abort
from flask_appbuilder.base import url_for
from sqlalchemy import cast, Numeric

extra_fields = {'bnotes': TextAreaField('bnotes', widget=BS3TextAreaFieldWidget())} 

class BoxViewPro(ModelView):
    datamodel = SQLAInterface(Box)
    list_columns = ['name','section.area.site','section.area' ,'active']
    add_columns = ['section','name','note']
    show_columns = ['id', 'name','section.area.site','section.area' , 'section','active']
    edit_columns = ['name', 'section','active','note']
    
    related_views = [VolumeProView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    
    base_order = ('name','desc')
    
    
    label_columns = {
        'name': 'Code', 
        'section.area': 'Area',
        'section.area.site': 'Site'
    }
    
    search_exclude_columns = ['box.id','box.name']
    def pre_add(self, item):
        print()
        print()
        print('*********** PRE ADD ON BOX PRO VIEW')
        box = db.session.query(Box).filter(Box.name == item.name).first()
        if box:
                next_box = db.session.query(Box).order_by(cast(Box.name,Numeric).desc()).first()
                next_box = int(next_box.name) + 1 
                raise Exception(f'The box {item.name} already exist. Next Box: {next_box}')
                #return abort(404, description="This Box Already Exist.")
                print(url_for('BoxView.show', pk=str(box.id)))
                #flash('This BOX already Exist','info')
                #return super().show(box.id)
                    
        #return redirect(url_for('BoxView.show', pk=str(box.id)))
        #return super().pre_add(item)




class BoxView(ModelView):
    datamodel = SQLAInterface(Box)
    list_columns = ['name','section.area.site','section.area' ,'active']
    add_columns = ['section','name','note']
    show_columns = ['id', 'name','section.area.site','section.area' , 'section','active']
    edit_columns = ['name', 'section','active','note']
    
    related_views = [VolumeProView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    
    base_order = ('name','desc')
    
    base_permissions = ['can_show','can_list']
    label_columns = {
        'name': 'Code', 
        'section.area': 'Area',
        'section.area.site': 'Site'
    }
    
    search_exclude_columns = ['box.id','box.name']
    base_permissions = ['can_show','can_list']
    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())
    
   
    
    
    
class SectionView(ModelView):
    datamodel = SQLAInterface(Section)
    list_columns = ['id', 'name', 'area', ] 
    add_columns = ['area','name']
    show_columns = ['id', 'name', 'area','area.site','area.site.id']
    edit_columns = ['name']
    
    related_views = [BoxViewPro]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
 
    label_columns = {
        'name': 'Scaffale', 
        'area.site': 'Site' 
    }
    
    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())
    
class AreaView(ModelView):
    datamodel = SQLAInterface(Area)
    list_columns = ['id', 'name','site' , 'box_count']
    add_columns = ['site','name']
    show_columns = ['id', 'name','site','site.id']
    edit_columns = ['name']
    
    related_views = [SectionView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    
    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())

class SiteView(ModelView):
    datamodel = SQLAInterface(Site)
    list_columns = ['id', 'name', 'box_count']
    add_columns = ['account','name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
    
    related_views = [AreaView]
    base_order = ('name','desc')
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    
    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
    
        
        return redirect(self.get_redirect())
    

class ProjectView(ModelView):
    datamodel = SQLAInterface(Project)
    list_columns = ['code','name'] 
    add_columns = ['account','code','name']
    show_columns = ['id', 'name', 'color','note']
    edit_columns = ['name', 'color','code']
    
    search_columns = ['id','code','name','note']

    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())
    
class AccountView(ModelView):
    datamodel = SQLAInterface(Account)
    list_columns = ['id', 'name']
    
    search_form_extra_fields = extra_fields
    add_form_extra_fields = extra_fields 
    edit_form_extra_fields = extra_fields
    
    add_columns = ['name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
   
    related_views = [ProjectView, SiteView, GroupView, TypeView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'

    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())
    
class VolumeApi(ModelRestApi):
    datamodel = SQLAInterface(Volume)
    resource_name = 'volume'
    allow_browser_login = True

from flask_appbuilder.api import protect


        
appbuilder.add_api(VolumeApi)

appbuilder.add_view(AccountView, name="Account", icon="fa fa-edit", category_icon='fa fa-edit', category='Settings')
appbuilder.add_view(VolumeView, name="Documents", icon="fa fa-edit", category_icon='fa fa-edit', category='Storage') 
appbuilder.add_view_no_menu(VolumeProView) 
appbuilder.add_view_no_menu(BoxViewPro) 
appbuilder.add_view(BoxView, name="Box", icon="fa fa-edit", category_icon='fa fa-edit', category='Storage') 
appbuilder.add_view(SiteView, name="Site", icon="fa fa-edit", category_icon='fa fa-edit', category='Logistic') 
appbuilder.add_view(AreaView, name="Area", icon="fa fa-edit", category_icon='fa fa-edit', category='Logistic') 
appbuilder.add_view(SectionView, name="Section", icon="fa fa-edit", category_icon='fa fa-edit', category='Logistic') 
appbuilder.add_view(TypeView, name="Type", icon="fa fa-edit", category_icon='fa fa-edit', category='Settings') 
appbuilder.add_view(GroupView, name="Group", icon="fa fa-edit", category_icon='fa fa-edit', category='Settings') 
appbuilder.add_view(ProjectView, name="Project", icon="fa fa-edit", category_icon='fa fa-edit', category='Settings') 

appbuilder.add_view(
    AdmFilesModelView, "File List", icon="fa-table", category_icon='fa fa-edit', category="GPS-GTF"
) 

appbuilder.add_view_no_menu(Export)
appbuilder.add_link('Export','/export/endlife/approval','fa fa-edit','GTF-GPS-COR-24036-01 Records Destruction Form','Export','fa fa-edit')
appbuilder.add_link('Export','/export/db/docs','fa fa-edit','GTF-GPS-COR-24034-01 Archival Records Storage Form','Export','fa fa-edit')
appbuilder.add_link('Export','/export/endlife/docs','fa fa-edit','WorkBook Endlife Records','Export','fa fa-edit')

appbuilder.add_view_no_menu(GroupView)
appbuilder.add_view_no_menu(TypeView)
appbuilder.add_view_no_menu(ProjectView)
appbuilder.add_view_no_menu(SiteView)
appbuilder.add_view_no_menu(AreaView)
appbuilder.add_view_no_menu(SectionView)
appbuilder.add_view_no_menu(BoxView)
appbuilder.add_view_no_menu(VolumeView)
appbuilder.add_view_no_menu(MoveView)


"""
    Application wide 404 error handler
"""


@appbuilder.app.errorhandler(404)
def page_not_found(e):
    return (
        render_template(
            "404.html", base_template=appbuilder.base_template, appbuilder=appbuilder
        ),
        404,
    )

from .helpers import load_master_3A, project_mass_color, load_master_30K, update_endlife, update_date2
from .helpers import active_box, notfound_box, load_notfound, update_position, update_desc, load_volumes
from .helpers import update_request_by,import_new_documents,strip_box_code, project_detail, to_destroy_export
from .helpers import client_from_prj_note
#project_mass_color()
db.create_all() 
#
# load_master_3A() 
#load_master_30K() 
#update_endlife()  
#update_date2()
#active_box()  
#notfound_box()
#load_notfound()
#update_position() 
#update_desc()
#load_volumes()
#update_request_by()
#import_new_documents()
#strip_box_code()   
#project_detail() 
#to_destroy_export()
#client_from_prj_note()
