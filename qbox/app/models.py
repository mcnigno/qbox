from flask_appbuilder import Model
from flask_appbuilder.models.mixins import AuditMixin, FileColumn
from sqlalchemy import Column, Integer, String, ForeignKey, Boolean, DateTime, Date, Text
from sqlalchemy.orm import relationship
from flask_appbuilder.models.decorators import renders 
from datetime import datetime
from sqlalchemy.orm.session import object_session
from flask_appbuilder.models.decorators import renders
from flask_appbuilder.filemanager import get_file_original_name
from flask import url_for
from markupsafe import Markup


"""

You can use the extra Flask-AppBuilder fields and Mixin's

AuditMixin will add automatic timestamp of created and modified by who


"""
from random import choice
def date_csm(date):
    return date.strftime('%d-%m-%Y %H:%M:%S')
def random_color():
    return 'rgb('+ str(choice(range(0,255))) + ', ' + str(choice(range(0,255)))  + ', ' + str(choice(range(0,255))) + ', 0.5)'

class AdmFiles(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    file = Column(FileColumn, nullable = False)
    description = Column(Text)
    active = Column(Boolean, default=True)
    
    def download(self):
        return Markup(
            '<a href="'
            + url_for("AdmFilesModelView.download", filename=str(self.file))
            + '">Download</a>'
        )

    def file_name(self):
        return get_file_original_name(str(self.file))


class Account(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable = False)
    active = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.name
    
class Site(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable = False)
    country = Column(String(100), nullable = False)
    city = Column(String(100), nullable = False)
    address = Column(String(100), nullable = False)
    account_id = Column(Integer, ForeignKey('account.id'))
    account = relationship(Account, backref='Sites')
    active = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.name
    
    def box_count(self):
        session = object_session(self)
        return session.query(Box).join(Section, Area, Site).filter(Site.id == self.id).count()

class Area(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable = False)
    site_id = Column(Integer, ForeignKey('site.id'))
    site = relationship(Site, backref='Areas')
    active = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.name + " | " + self.site.name
    def box_count(self):
        session = object_session(self)
        return session.query(Box).join(Section, Area).filter(Area.id == self.id).count()
    
class Section(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable = False)
    area_id = Column(Integer, ForeignKey('area.id'))
    area = relationship(Area, backref='Sections')
    active = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.name
    
    def box_count(self):
        session = object_session(self)
        return session.query(Box).filter(Box.section_id == self.id).count()
   
        
    
    
class Box(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable = False, )
    section_id = Column(Integer, ForeignKey('section.id'))
    section = relationship(Section, backref='Boxes')
    active = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.name
    
    
    
    
    
class Group(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable = False)
    account_id = Column(Integer, ForeignKey('account.id'))
    account = relationship(Account, backref='Groups')
    active = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.name
    def doc_count(self):
        session = object_session(self)
        return session.query(Volume).join(Group).filter(Group.id == self.id).count()

class Type(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable = False)
    description = Column(String(200), nullable = False)
    activation_on = Column(String(100), nullable = False)
    retention_code = Column(String(20), nullable = False)
    retention_days = Column(Integer, nullable=False)
    security_class = Column(String(100), nullable = False)
    
    account_id = Column(Integer, ForeignKey('account.id'))
    account = relationship(Account, backref='Types')
    active = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.name
    def doc_count(self):
        session = object_session(self)
        return session.query(Volume).join(Type).filter(Type.id == self.id).count()
    
class Project(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    code = Column(String(200), nullable = False)
    color = Column(String(36), default = random_color(), nullable = False)
    name = Column(String(200), nullable = False)
    account_id = Column(Integer, ForeignKey('account.id'))
    account = relationship(Account, backref='Projects') 
    active = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.code + " | " + self.name


    
class Volume(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(400), nullable = False)
    box_id = Column(Integer, ForeignKey('box.id'), nullable = False)
    box = relationship(Box, backref='Volumes')
    group_id = Column(Integer, ForeignKey('group.id'), nullable = False)
    group = relationship(Group, backref='Volumes')
    type_id = Column(Integer, ForeignKey('type.id'), nullable = False)
    type = relationship(Type, backref='Volumes')
    project_id = Column(Integer, ForeignKey('project.id'), nullable = False)
    project = relationship(Project, backref='Volumes')
    date_start = Column(Date, nullable = False)
    date_end = Column(Date, nullable = False) 
    activation_date = Column(Date, nullable = False)
    endlife_date = Column(Date)
    account_number = Column(Integer)
    order_number = Column(String(20))
    request_by = Column(String(100))
    request_on = Column(Date)
    active = Column(Boolean, default=True)
    available = Column(Boolean, default=True)
    note = Column(Text)
    
    def __repr__(self) -> str:
        return self.name 
    
    @renders('position')
    def position(self) -> str:
        return self.box.section.area.site.name  
    def days_left(self):
        if self.endlife_date:
            days = self.endlife_date - datetime.today().date()
            return days.days
        return 0
    
    def progress(self): 
        return 100 - int(self.days_left(self)) 
    
    
    
        
        
   
class Move(AuditMixin, Model):
    id = Column(Integer, primary_key=True)
    name = Column(String(100), nullable = False)
    volume_id = Column(Integer, ForeignKey('volume.id'))
    volume = relationship(Volume, backref='Moves') 
    status = Column(Boolean, default=True)
    active = Column(Boolean, default=True)
    note = Column(Text)

    def __repr__(self) -> str:
        return self.name
    
    def last_change(self) -> str:
        return date_csm(self.changed_on)