
from flask_appbuilder import IndexView
from flask_appbuilder import expose
from .models import Volume, Project
from flask_appbuilder.models.sqla.interface import SQLAInterface




class QboxIndexView(IndexView):
    
    index_template = 'qbox_index.html'
    
    
    
    