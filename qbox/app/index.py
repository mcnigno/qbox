
from flask_appbuilder import IndexView
from flask_appbuilder import expose
from .models import Volume, Project, Box, Site, Group, Section, Area
from flask_appbuilder.models.sqla.interface import SQLAInterface
from flask import g
from sqlalchemy.orm import scoped_session, sessionmaker

from sqlalchemy.orm import scoped_session
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from config import SQLALCHEMY_DATABASE_URI
from sqlalchemy import func, or_
 
engine = create_engine(SQLALCHEMY_DATABASE_URI)
session_factory = sessionmaker(engine)
Session = scoped_session(session_factory)



class QboxIndexView(IndexView):
    
    index_template = 'qbox_index.html'
    
    @expose("/")
    def index(self):
        
        session = Session()
        
        all_box = session.query(Box).join(Section,Area,Site).filter(Site.name != 'X - Not Found').count()
        all_doc = session.query(Volume).count()  
        
        # box per Site
        box_site = session.query(Site).filter(Site.name != 'X - Not Found').order_by(Site.name.asc()).all()
        box_site_labels = [x.name for x in box_site]
        box_site_data = [x.box_count() for x in box_site]
        box_site_chart_data = {
          'labels': box_site_labels,
          'datasets': [{
            'label': 'Books by Group',
            'data': box_site_data,
            'hoverOffset': 4
          }]
        }
        
        # doc per group
        doc_group = session.query(Group).all()
        
        #limit to the top 10 by doc_count()
        sorted_doc_group = sorted([(x.name, x.doc_count()) for x in doc_group], key=lambda c: c[1], reverse=True)
        doc_group = sorted_doc_group[:10]
        
        doc_group_labels = [x[0] for x in doc_group]
        doc_group_data = [x[1] for x in doc_group]
        doc_group_chart_data = {
          'labels': doc_group_labels,
          'datasets': [{
            'label': 'Books by Group',
            'data': doc_group_data,
            'hoverOffset': 4
          }]
        }
        
        doc_endlife = session.query(func.year(Volume.endlife_date), func.count(Volume.id), 
            ).group_by(func.year(Volume.endlife_date)
            ).all()
            
        doc_endlife_labels = [x[0] for x in doc_endlife]
        doc_endlife_data = [x[1] for x in doc_endlife]
        doc_endlife_chart_data = {
          'labels': doc_endlife_labels,
          'datasets': [{
            'label': 'Documents by endlife',
            'data': doc_endlife_data,
            'hoverOffset': 4
          }]
        }
        
        last_entries = session.query(Volume).order_by(Volume.created_on.desc()
                                            ).limit(100).all()
        ie_tabledata = [{'Project': v.project.code,'Type': v.type.name, 'Name': v.name, 'Group': v.group.name, 'id': v.id, 'due_date': str(v.endlife_date) } for v in last_entries]
        
        self.update_redirect()
        return self.render_template(self.index_template, 
                                    appbuilder=self.appbuilder, 
                                    all_box=all_box,
                                    all_doc=all_doc,
                                    box_site_chart_data = box_site_chart_data,
                                    box_site_list = zip(box_site_labels, box_site_data), 
                                    doc_group_chart_data = doc_group_chart_data,
                                    doc_group_list = zip(doc_group_labels, doc_group_data),
                                    doc_endlife_chart_data=doc_endlife_chart_data,
                                    ie_tabledata=ie_tabledata
                                    )
    
    
    
    