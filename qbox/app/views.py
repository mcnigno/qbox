from flask import render_template, redirect, flash
from flask_appbuilder.models.sqla.interface import SQLAInterface
from flask_appbuilder import ModelView, ModelRestApi, BaseView, expose, has_access
from flask_appbuilder.actions import action


from . import appbuilder, db

from .models import Account, Project, Site, Area, Section, Box, Type, Group, Volume, Move
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
class Dashboard(BaseView):
    route_base = '/dashboard'
    allow_browser_login = True
    @expose('/index/', methods=('GET','POST'))
    @has_access
    def index(self):
        search_str = '%%'
        book_search = '%%'
        if request.method == 'POST':
            if request.form['project']:
                search_str = '%'+request.form['project']+'%'
        if request.method == 'POST':
            book_search = '%'+request.form['name']+'%'
            
        
        
        last_entries = db.session.query(Volume).join(Project
                                            ).order_by(Volume.created_on.desc()
                                            ).filter(Project.name.like(search_str), Volume.name.like(book_search)
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
                                            ).filter(Project.name.like(search_str), Volume.name.like(book_search)
                                            ).limit(10).all()
        last_entries = db.session.query(Volume).join(Project
                                            ).order_by(Volume.created_on.desc()
                                            ).filter(Project.name.like(search_str), Volume.name.like(book_search)
                                            ).limit(10).all()
        print('step1')
        le_tabledata = [{'Project': v.project.code,'Type': v.type.name, 'Name': v.name, 'Group': v.group.name, 'id': v.id, 'due_date': str(v.endlife_date) } for v in last_entries]
        #   print(last_entries)
        print('step2')
        volume_group = db.session.query(func.count(Volume.id), Group.name
                                            ).join(Group, Project
                                            ).group_by(Group.name
                                            ).filter(Project.name.like(search_str), Volume.name.like(book_search)
                                            ).limit(100
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
            Project.name.like(search_str), Volume.name.like(book_search)
        ).limit(100
        ).all()
        print('step5')
        vs_labels = [x[1] for x in volume_site]
        vs_data = [x[0] for x in volume_site]
        
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
            Project.name,
            func.count(Volume.id)
        ).join(Type, Project).group_by(
            Type.id,
            Project.id
        ).filter(
            Project.name.like(search_str), Volume.name.like(book_search) 
        ).limit(100
        ).all()
        print('step6')
        e = {}
        prj_list = set()
        prj_list2 = db.session.query(Project
                                    ).join(Volume
                                    ).filter(Project.name.like(search_str), Volume.name.like(book_search)
                                    ).limit(100
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
                    data.append(e[type][project.name][0])
                except:
                    data.append(0)
            
            volume_serie_data.append({"label": project.name, "data": data, "color": project.color})
            #volume_serie_label.append(project.name)
        
        #print()
        #print(volume_serie_data)
        print('step8')

        
        volumes_endlife = db.session.query(func.year(Volume.endlife_date), Project.name, func.count(Volume.id), Project.color 
            ).join(Project
            ).group_by(func.year(Volume.endlife_date), Project.id
            ).filter(Project.name.like(search_str), Volume.name.like(book_search)
                     ).limit(100
                    ).all()
        
        e = {}
        prj_list = set()
        prj_list2 = db.session.query(Project
                                    ).join(Volume
                                    ).filter(Project.name.like(search_str), Volume.name.like(book_search)
                                    ).limit(100
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
                    data.append(e[year][project.name][0])
                except:
                    data.append(0)
            volume_endlife_data.append({"label": project.name, "data": data, "color": project.color}) 
        
        print('step10')
        #print()
        #print(volume_endlife_data)
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
                or_(Type.name.like('%'+request.form['project']+'%'),
                    Project.name.like('%'+request.form['project']+'%') )).all()
            #volumes = db.session.query(Type.name ,func.count(Volume.id)).join(Volume, Project).group_by(
            #Type.id).filter(Project.name.like(request.form['project'])).all()
            #print('++++++ààà+++++àà  POST +à+à+à +à+à --- FOR: ', request.form['project'])
            #print('++++++ààà+++++àà  LEN VOLUMES +à+à --- FOR: ', len(volumes))
            #print(volumes)
            volume_labels = [ x[0] for x in volumes]
            volume_data = [x[1] for x in volumes]
            
            volumes_endlife = db.session.query(func.year(Volume.endlife_date), func.count(Volume.id)).join(Project, Type).group_by(
                                                func.year(Volume.endlife_date)).filter(Project.name.like('%'+ request.form['project']+'%')).all()
            
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
    list_columns = ['id', 'name']
    add_columns = ['account','name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
    
    list_title = 'Group / Department'

class TypeView(ModelView):
    datamodel = SQLAInterface(Type)
    list_columns = ['id', 'name', 'retention_code','description']
    add_columns = ['account','name']
    show_columns = ['id', 'name', 'retention_code', 'retention_days','description']
    edit_columns = ['name', 'retention_code', 'retention_days','description']
    
    list_title = 'Document Type'


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

from .helpers import write_csv
from flask import Response, send_file
from io import BytesIO
from werkzeug.wsgi import FileWrapper
 
class VolumeView(ModelView):
    datamodel = SQLAInterface(Volume)
    list_columns = ['project.code','project.name', 'type.name','name', 'endlife_date', 'days_left']
    add_columns = ['box','project','type','group', 'name',]
    show_columns = ['box','box.section.area.site','box.section.area','box.section','project.account','project', 'type', 'group', 'name','request_by','site.country']
    edit_columns = ['box','project','type','group', 'name','endlife_date'] 
    
    
    label_columns = {
        'project.account': 'Account',
        'box.section.area.site': 'Site',
        'box.section.area': 'Area',
        'box.section': 'Section'
    }
    
    search_columns = ['project', 'type', 'group', 'name', 'date_start', 'date_end', 'endlife_date']
    related_views = [MoveView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    
    
    @action("muldelete", "Delete", "Delete all Really?", "fa-rocket", single=False)
    def muldelete(self, items):
        self.datamodel.delete_all(items)
        self.update_redirect()
        return redirect(self.get_redirect())
    
    @action("export", "Export", "Export all Really?", "fa-rocket", single=False,)
    def export(self, items):
        lst = self.datamodel.query(self._filters)
        #lst2= self.datamodel.get_values(items, self.list_columns)
        
        b = write_csv(self, lst)
        return send_file(b, as_attachment=True, mimetype='text/csv', download_name='test.csv')
        
        #b = BytesIO(open(csv_file.read()))
        #w = FileWrapper(b)
        
        
        
        #self.update_redirect()
        return b
class BoxView(ModelView):
    datamodel = SQLAInterface(Box)
    list_columns = ['id', 'name']
    add_columns = ['section','name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
    
    related_views = [VolumeView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    
class SectionView(ModelView):
    datamodel = SQLAInterface(Section)
    list_columns = ['id', 'name']
    add_columns = ['area','name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
    
    related_views = [BoxView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
 

class AreaView(ModelView):
    datamodel = SQLAInterface(Area)
    list_columns = ['id', 'name']
    add_columns = ['site','name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
    
    related_views = [SectionView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    

class SiteView(ModelView):
    datamodel = SQLAInterface(Site)
    list_columns = ['id', 'name']
    add_columns = ['account','name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
    
    related_views = [AreaView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'
    


class ProjectView(ModelView):
    datamodel = SQLAInterface(Project)
    list_columns = ['code','name'] 
    add_columns = ['account','code','name']
    show_columns = ['id', 'name', 'color']
    edit_columns = ['name', 'color']


class AccountView(ModelView):
    datamodel = SQLAInterface(Account)
    list_columns = ['id', 'name']
    add_columns = ['name']
    show_columns = ['id', 'name']
    edit_columns = ['name']
   
    related_views = [ProjectView, SiteView, GroupView, TypeView]
     
    show_template = 'appbuilder/general/model/show_cascade.html'
    edit_template = 'appbuilder/general/model/edit_cascade.html'


class VolumeApi(ModelRestApi):
    datamodel = SQLAInterface(Volume)
    resource_name = 'volume'
    allow_browser_login = True

from flask_appbuilder.api import protect

class MyView(BaseView):
    route_base = "/myview"
    

    @expose('/method1/<string:param1>')
    def method1(self, param1):
        # do something with param1
        # and return it
        return param1 

    
    @expose('/method2/<string:param1>')
    def method2(self, param1):
        # do something with param1
        # and render it
        param1 = 'Hello %s' % (param1)
        return render_template('portal.html', 
                               param1 = param1,
                               appbuilder=appbuilder)

appbuilder.add_view_no_menu(MyView())
        
appbuilder.add_api(VolumeApi)

appbuilder.add_view(AccountView, name="Account", icon="fa fa-edit", category_icon='fa fa-edit', category='Settings')
appbuilder.add_view(VolumeView, name="Volume", icon="fa fa-edit", category_icon='fa fa-edit', category='Settings') 

appbuilder.add_link('Dashboard','/dashboard/home','fa fa-edit')

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
#project_mass_color()
db.create_all() 
#load_master_3A() 
#load_master_30K() 
#update_endlife()  
#update_date2()
