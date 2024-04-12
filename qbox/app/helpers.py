import csv
from flask import send_file, Response
def read_csv():    
    with open('qbox/app/xlsx/master.csv', mode='r') as infile:
        infile = csv.reader(infile)
        for line in infile:
            box, archivio, scaffale, progetto, dipartimento, codice, volume_da, volume_a = line[0].split(';')
            print(box, progetto, codice, volume_a)

from io import BytesIO
from werkzeug.wsgi import FileWrapper

def write_csv(self, query):
    with BytesIO() as outfile:
        outcsv = csv.writer(outfile)
        print(query)
        for el in query[1]:
            print(el)
            outcsv.writerow([el.box.id, 
                  el.box.section.area.site.city,
                  el.box.section.area.site.country,
                  el.group.name,
                  el.type.name,
                  el.type.retention_code,
                  el.type.description,
                  el.date_start,
                  el.date_end,
                  el.project.code,
                  el.project.name,
                  el.name,
                  el.type.activation_on, 
                  el.activation_date,
                  el.type.retention_days,
                  el.endlife_date,
                  el.type.security_class,
                  el.account_number,
                  el.order_number,
                  el.box.section.area.site.name,
                  el.box.section.area.name,
                  el.request_by,
                  el.request_on,
                  el.box.section.name
                  
                  ])
        #b = BytesIO(open(outfile,'rb'))
        outfile.seek(0)
           
    return outfile
    

from random import choice
def random_color():
    return 'rgb('+ str(choice(range(0,255))) + ', ' + str(choice(range(0,255)))  + ', ' + str(choice(range(0,255))) + ', 0.5)'
        
from openpyxl import load_workbook
from .models import Account, Project, Site, Area, Section, Group, Box, Volume, Type, Move
from app import db


from datetime import datetime
def to_date(date):
    if date:
        return datetime.strptime(date, "%d/%m/%Y")
    return None
    


def load_master():
    wb = load_workbook('app/xlsx/master.xlsx')
    ws = wb.active
    count = 0
    

    for row in ws.iter_rows():
        count += 1
        box_id = row[0].value
        city = row[1].value
        country = row[2].value
        archivio = row[1].value
        scaffale = row[2].value
        progetto = row[3].value
        dipartimento = row[4].value
        codice = row[5].value
        volume_da = row[6].value
        volume_a = row[7].value
        
        account = db.session.query(Account).filter(Account.name == 'TPIT').first()
        if not account:
            account = Account(name = 'TPIT', created_by_fk = 1, changed_by_fk = 1)
        db.session.add(account)
        
        project = db.session.query(Project).filter(Project.name == progetto).first()
        if not project:
            project = Project(name = progetto, account= account, created_by_fk = 1, changed_by_fk = 1)
        db.session.add(project)
        
        site = db.session.query(Site).filter(Site.name == archivio).first()
        if not site:
            site = Site(name = archivio, country='Italy', city='Rome', address='Address', account= account, created_by_fk = 1, changed_by_fk = 1)
        db.session.add(site)
            
        area = db.session.query(Area).filter(Area.name == site.name).first()
        if not area:
            area = Area(name = site.name, site= site, created_by_fk = 1, changed_by_fk = 1)
        db.session.add(area)    
        
        section = db.session.query(Section).filter(Section.name == scaffale).first()
        if not section:
            section = Section(name = scaffale, area= area, created_by_fk = 1, changed_by_fk = 1)
        db.session.add(section)
        
        box = db.session.query(Box).filter(Box.name == box_id).first()
        if not box:
            box = Box(name = box_id, section= section, created_by_fk = 1, changed_by_fk = 1)
        db.session.add(box)
            
        group = db.session.query(Group).filter(Group.name == dipartimento).first()
        if not group:
            group = Group(name = dipartimento, account= account, created_by_fk = 1, changed_by_fk = 1)
        db.session.add(group)
        
        type = db.session.query(Type).filter(Type.name == codice).first()
        if not type:
            type = Type(name = codice, account= account, created_by_fk = 1, changed_by_fk = 1)
        db.session.add(type)
        
        volume = db.session.query(Volume).filter(
            Volume.v_from == volume_da,
            Volume.v_to == volume_a,
            Volume.box == box
            ).first()
        if not volume:
            volume = Volume(v_from = volume_da,
                            v_to = volume_a,
                            project = project,
                            box = box,
                            group = group,
                            type = type,
                            name = str(str(volume_da) + " " + str(volume_a)),
                            created_by_fk = 1, 
                            changed_by_fk = 1
                            )
        print(count, str(volume.name))
        db.session.add(volume)
        
    
        db.session.commit()
        

def load_master_2():
    wb = load_workbook('app/xlsx/master_2.xlsx', data_only=True)
    ws = wb.active
    count = 0
    errors = []
    

    for row in ws.iter_rows(min_row=3):
        try:
            count += 1
            box_id = row[0].value
            city = row[1].value
            country = row[2].value
            dipartimento = row[3].value or 'ToBeDefined'
            codice = row[4].value or 'ToBeDefined'
            periodo_cons = row[5].value
            descrizione_code = row[6].value or 'ToBeDefined'
            date_start = row[7].value or None
            date_end = row[8].value or None
            progetto = row[9].value or 'ToBeDefined'
            nome_progetto = row[10].value or 'ToBeDefined'
            description = row[11].value or 'ToBeDefined'
            rif_attivazione = row[12].value or None
            data_attivazione = row[13].value  or None# date_end + 1 gg
            gg_conservazione = row[14].value or None
            data_distruzione = row[15].value or None# data_attivazione + gg_conservazione
            livello_sicurezza = row[16].value or 'ToBeDefined'
            
            numero_conto = row[17].value or None
            commessa = None
            
            archivio = row[19].value or "ND"
            stanza = row[20].value or "ND"
            
            richiedente = row[21].value or "ND"
            data_ritiro = row[22].value or None
            
            scaffale = row[23].value or "ND"
            
            move_to = None
            move_date = None
            
            
            
            
            
            #volume_a = row[7].value
            
            account = db.session.query(Account).filter(Account.name == 'TPIT').first()
            if not account:
                account = Account(name = 'TPIT', created_by_fk = 1, changed_by_fk = 1)
            db.session.add(account)
            
            project = db.session.query(Project).filter(Project.code == progetto).first()
            if not project:
                project = Project(name = nome_progetto, code = progetto, account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(project)
            
            site = db.session.query(Site).filter(Site.name == archivio).first()
            if not site:
                site = Site(name = archivio, country=country, city=city, address='ND', account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(site)
                
            area = db.session.query(Area).filter(Area.name == stanza).first()
            if not area:
                area = Area(name = stanza, site= site, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(area)    
            
            section = db.session.query(Section).filter(Section.name == scaffale).first()
            if not section:
                section = Section(name = scaffale, area= area, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(section)
            
            box = db.session.query(Box).filter(Box.name == box_id).first()
            if not box:
                box = Box(name = box_id, section= section, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(box)
                
            group = db.session.query(Group).filter(Group.name == dipartimento).first()
            if not group:
                group = Group(name = dipartimento, account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(group)
            
            type = db.session.query(Type).filter(Type.name == codice).first()
            if not type:
                type = Type(name = codice, 
                            account= account,
                            retention_code = periodo_cons,
                            description = descrizione_code,
                            activation_on = rif_attivazione,
                            retention_days = gg_conservazione,
                            security_class = livello_sicurezza,
                            created_by_fk = 1, 
                            changed_by_fk = 1)
            db.session.add(type)
            
            volume = db.session.query(Volume).filter(
                Volume.name == description,
                Volume.box == box
                ).first()
            if not volume:
                volume = Volume(name = description,
                                project = project,
                                box = box,
                                group = group,
                                type = type,
                                date_start =date_start,
                                date_end = date_end,
                                activation_date = data_attivazione,
                                endlife_date = data_distruzione,
                                account_number = numero_conto,
                                order_number = commessa,
                                request_by = richiedente,
                                request_on = data_ritiro,
                                created_by_fk = 1, 
                                changed_by_fk = 1
                                )
            print(count, str(volume.name))
            db.session.add(volume)
            
            
            print(project.color)
            db.session.flush()
            print(project.color)
            db.session.commit()
        except Exception as e:
            #row[30] = str(e)
            db.session.rollback() 
            print(e,'         *-*-*-*-*-*-*-*-  ERROR *-*-*-*-*-*-')
            #errors.append((count+2,e))
            #pass
            break
           
    print('')
    print('         *-*-*-*-*-*-*-*-  LIST ERRORS *-*-*-*-*-*-')               
    for e in errors:
        print(e)    
                   

def load_master_3A():
    wb = load_workbook('app/xlsx/master_5.xlsx', data_only=True)
    ws = wb.active
    count = 0
    errors = []
    

    for row in ws.iter_rows(min_row=3):
        try:
            count += 1
            box_id = row[0].value
            city = row[3].value
            country = row[4].value
            dipartimento = row[5].value or 'ToBeDefined'
            codice = row[6].value or 'ToBeDefined'
            periodo_cons = row[7].value
            descrizione_code = row[8].value or 'ToBeDefined'
            date_start = row[9].value or None
            date_end = row[10].value or None
            progetto = row[11].value or 'ToBeDefined'
            nome_progetto = row[12].value or 'ToBeDefined'
            description = row[13].value or 'ToBeDefined'
            rif_attivazione = row[14].value or None
            data_attivazione = row[15].value  or None# date_end + 1 gg
            gg_conservazione = row[16].value or None
            data_distruzione = row[17].value or None# data_attivazione + gg_conservazione
            livello_sicurezza = row[18].value or 'ToBeDefined'
            
            numero_conto = row[19].value or None
            commessa = None
            
            #add calculated column to the table
            archivio = row[20].value or "ND"
            
            stanza = row[1].value or "ND"
            
            richiedente = None
            data_ritiro = None
            
            scaffale = row[2].value or "ND"
            
            move_to = None
            move_date = None
            
            
            
            
            
            #volume_a = row[7].value
            
            account = db.session.query(Account).filter(Account.name == 'TPIT').first()
            if not account:
                account = Account(name = 'TPIT', created_by_fk = 1, changed_by_fk = 1)
            db.session.add(account)
            
            project = db.session.query(Project).filter(Project.code == progetto).first()
            if not project:
                project = Project(name = nome_progetto, code = progetto, account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(project)
            
            site = db.session.query(Site).filter(Site.name == archivio).first()
            if not site:
                site = Site(name = archivio, country=country, city=city, address='ND', account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(site)
                
            area = db.session.query(Area).filter(Area.name == stanza).first()
            if not area:
                area = Area(name = stanza, site= site, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(area)    
            
            section = db.session.query(Section).filter(Section.name == scaffale).first()
            if not section:
                section = Section(name = scaffale, area= area, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(section)
            
            box = db.session.query(Box).filter(Box.name == box_id).first()
            if not box:
                box = Box(name = box_id, section= section, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(box)
                
            group = db.session.query(Group).filter(Group.name == dipartimento).first()
            if not group:
                group = Group(name = dipartimento, account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(group)
            
            type = db.session.query(Type).filter(Type.name == codice).first()
            if not type:
                type = Type(name = codice, 
                            account= account,
                            retention_code = periodo_cons,
                            description = descrizione_code,
                            activation_on = rif_attivazione,
                            retention_days = gg_conservazione,
                            security_class = livello_sicurezza,
                            created_by_fk = 1, 
                            changed_by_fk = 1)
            db.session.add(type)
            
            volume = db.session.query(Volume).filter(
                Volume.name == description,
                Volume.box == box
                ).first()
            if not volume:
                volume = Volume(name = description,
                                project = project,
                                box = box,
                                group = group,
                                type = type,
                                date_start =date_start,
                                date_end = date_end,
                                activation_date = data_attivazione,
                                endlife_date = data_distruzione,
                                account_number = numero_conto,
                                order_number = commessa,
                                request_by = richiedente,
                                request_on = data_ritiro,
                                created_by_fk = 1, 
                                changed_by_fk = 1
                                )
            print(count, str(volume.name))
            db.session.add(volume)
            
            
        
            db.session.commit()
        except Exception as e:
            #row[30] = str(e)
            db.session.rollback() 
            print(e,'         *-*-*-*-*-*-*-*-  ERROR *-*-*-*-*-*-')
            #errors.append((count+2,e))
            #pass
            break
           
    print('')
    print('         *-*-*-*-*-*-*-*-  LIST ERRORS *-*-*-*-*-*-')               
    for e in errors:
        print(e)    

def load_master_3():
    wb = load_workbook('app/xlsx/LAST .xlsx', data_only=True)
    ws = wb.active
    count = 0
    errors = []
    

    for row in ws.iter_rows(min_row=3):
        try:
            count += 1
            box_id = row[0].value
            city = "Rome"
            country = "Italy"
            dipartimento = row[4].value or 'ToBeDefined'
            codice = row[6].value or 'ToBeDefined'
            periodo_cons = 'ToBeDefined'
            descrizione_code = row[5].value or 'ToBeDefined'
            date_start = None
            date_end = None
            progetto = row[3].value or 'ToBeDefined'
            nome_progetto = 'ToBeDefined'
            description = row[8].value or "ND " + ' Vol: ' + row[9].value or "ND " + " " + row[10].value or 'ToBeDefined'
            rif_attivazione = 'ToBeDefined'
            data_attivazione = None # date_end + 1 gg
            gg_conservazione = 0
            data_distruzione = None # data_attivazione + gg_conservazione
            livello_sicurezza = 'ToBeDefined'
            
            numero_conto = None
            commessa = 'ToBeDefined'
            
            archivio = row[11].value or 'ToBeDefined'
            stanza = row[2].value or 'ToBeDefined'
            
            richiedente = 'ToBeDefined'
            data_ritiro = None
            
            scaffale = row[1].value or 'ToBeDefined'
            
            move_to = 'ToBeDefined'
            move_date = None
            
            
            
            
            
            #volume_a = row[7].value
            
            account = db.session.query(Account).filter(Account.name == 'TPIT').first()
            if not account:
                account = Account(name = 'TPIT', created_by_fk = 1, changed_by_fk = 1)
            db.session.add(account)
            
            project = db.session.query(Project).filter(Project.code == progetto).first()
            if not project:
                project = Project(name = nome_progetto, code = progetto, account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(project)
            
            site = db.session.query(Site).filter(Site.name == archivio).first()
            if not site:
                site = Site(name = archivio, country=country, city=city, address='ND', account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(site)
                
            area = db.session.query(Area).filter(Area.name == stanza).first()
            if not area:
                area = Area(name = stanza, site= site, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(area)    
            
            section = db.session.query(Section).filter(Section.name == scaffale).first()
            if not section:
                section = Section(name = scaffale, area= area, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(section)
            
            box = db.session.query(Box).filter(Box.name == box_id).first()
            if not box:
                box = Box(name = box_id, section= section, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(box)
                
            group = db.session.query(Group).filter(Group.name == dipartimento).first()
            if not group:
                group = Group(name = dipartimento, account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(group)
            
            type = db.session.query(Type).filter(Type.name == codice).first()
            if not type:
                type = Type(name = codice, 
                            account= account,
                            retention_code = periodo_cons,
                            description = descrizione_code,
                            activation_on = rif_attivazione,
                            retention_days = gg_conservazione,
                            security_class = livello_sicurezza,
                            created_by_fk = 1, 
                            changed_by_fk = 1)
            db.session.add(type)
            
            volume = db.session.query(Volume).filter(
                Volume.name == description,
                Volume.box == box
                ).first()
            if not volume:
                volume = Volume(name = description,
                                project = project,
                                box = box,
                                group = group,
                                type = type,
                                date_start =date_start,
                                date_end = date_end,
                                activation_date = data_attivazione,
                                endlife_date = data_distruzione,
                                account_number = numero_conto,
                                order_number = commessa,
                                request_by = richiedente,
                                request_on = data_ritiro,
                                created_by_fk = 1, 
                                changed_by_fk = 1
                                )
            print(count, str(volume.name))
            db.session.add(volume)
            
            
        
            db.session.commit()
        except Exception as e:
            row[13].value = str(e)
            db.session.rollback() 
            print('         *-*-*-*-*-*-*-*-  ERROR *-*-*-*-*-*-', count, e)
            errors.append((count+2,e))
            pass
    
    wb.save('LAST .xlsx')
    print('')
    print('         *-*-*-*-*-*-*-*-  LIST ERRORS *-*-*-*-*-*-')               
    for e in errors:
        print(e)    
                   
 
def load_master_30K():
    wb = load_workbook('app/xlsx/30K_Da normalizzare 1.xlsx', data_only=True)
    ws = wb.active
    count = 0
    errors = []
    print('LOAD MASTER 30K - 1')

    for row in ws.iter_rows(min_row=3):
        try:
            print('LOAD MASTER 30K - 2')
            count += 1
            box_id = row[0].value
            city = "Rome"
            country = "Italy"
            dipartimento = row[4].value or 'ToBeDefined'
            codice = row[11].value or 'ToBeDefined'
            periodo_cons = row[12].value or 'ToBeDefined'
            descrizione_code = row[13].value or 'ToBeDefined'
            date_start = None
            date_end = None
            progetto = row[3].value or 'ToBeDefined'
            nome_progetto = 'ToBeDefined'
            description = row[8].value or "ND " + ' Vol: ' + row[9].value or "ND " + " " + row[10].value or 'ToBeDefined'
            rif_attivazione = 'ToBeDefined'
            data_attivazione = None # date_end + 1 gg
            gg_conservazione = 0
            data_distruzione = None # data_attivazione + gg_conservazione
            livello_sicurezza = 'ToBeDefined'
            
            numero_conto = None
            commessa = 'ToBeDefined'
            
            archivio = row[26].value or 'ToBeDefined'
            stanza = row[1].value or 'ToBeDefined'
            
            richiedente = 'ToBeDefined'
            data_ritiro = None
            
            scaffale = row[2].value or 'ToBeDefined'
            
            move_to = 'ToBeDefined'
            move_date = None
            
            
            
            
            
            #volume_a = row[7].value
            
            account = db.session.query(Account).filter(Account.name == 'TPIT').first()
            if not account:
                account = Account(name = 'TPIT', created_by_fk = 1, changed_by_fk = 1)
            db.session.add(account)
            
            project = db.session.query(Project).filter(Project.code == progetto).first()
            if not project:
                project = Project(name = nome_progetto, code = progetto, account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(project)
            
            site = db.session.query(Site).filter(Site.name == archivio).first()
            if not site:
                site = Site(name = archivio, country=country, city=city, address='ND', account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(site)
                
            area = db.session.query(Area).filter(Area.name == stanza).first()
            if not area:
                area = Area(name = stanza, site= site, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(area)    
            
            section = db.session.query(Section).filter(Section.name == scaffale).first()
            if not section:
                section = Section(name = scaffale, area= area, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(section)
            
            box = db.session.query(Box).filter(Box.name == box_id).first()
            if not box:
                box = Box(name = box_id, section= section, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(box)
                
            group = db.session.query(Group).filter(Group.name == dipartimento).first()
            if not group:
                group = Group(name = dipartimento, account= account, created_by_fk = 1, changed_by_fk = 1)
            db.session.add(group)
            
            type = db.session.query(Type).filter(Type.name == codice).first()
            if not type:
                type = Type(name = codice, 
                            account= account,
                            retention_code = periodo_cons,
                            description = descrizione_code,
                            activation_on = rif_attivazione,
                            retention_days = gg_conservazione,
                            security_class = livello_sicurezza,
                            created_by_fk = 1, 
                            changed_by_fk = 1)
            db.session.add(type)
            
            volume = db.session.query(Volume).filter(
                Volume.name == description,
                Volume.box == box
                ).first()
            if not volume:
                volume = Volume(name = description,
                                project = project,
                                box = box,
                                group = group,
                                type = type,
                                date_start =date_start,
                                date_end = date_end,
                                activation_date = data_attivazione,
                                endlife_date = data_distruzione,
                                account_number = numero_conto,
                                order_number = commessa,
                                request_by = richiedente,
                                request_on = data_ritiro,
                                created_by_fk = 1, 
                                changed_by_fk = 1
                                )
            print(count, str(volume.name))
            db.session.add(volume)
            
            
        
            db.session.commit()
        except Exception as e:
            print('LOAD MASTER 30K - 3')
            db.session.rollback()
            row[13].value = str(e)
            db.session.rollback() 
            print('         *-*-*-*-*-*-*-*-  ERROR *-*-*-*-*-*-', count, e)
            errors.append((count+2,e))
            pass
    
    wb.save('30K_Da normalizzare 1.xlsx')
    print('')
    print('         *-*-*-*-*-*-*-*-  LIST ERRORS *-*-*-*-*-*-')               
    for e in errors:
        print(e)    
                   


def project_mass_color():
    projects = db.session.query(Project).all()
    for project in projects:
        project.changed_by_fk = '1'
        project.color = random_color()
    
    db.session.commit()

from datetime import timedelta
def update_endlife():
    
    # update activation date
    dates = [
        [2500,2554,datetime(2000,12,31)],
        [2001,2499,datetime(2008,12,31)],
        [1760,2000,datetime(2000,12,31)],
        [1436,1759,datetime(1990,12,31)],
        [1401,1435,datetime(1990,12,31)]
    ] 

    for s in dates:    
        volumes = db.session.query(Volume).join(Project).filter(
            Project.code >= s[0],
            Project.code <= s[1],
            Volume.activation_date == None
        ).all()
        if volumes:
            for v in volumes:
                print(v.id, v.project, v.activation_date, v.changed_by_fk)
                v.activation_date = s[2]
                v.changed_by_fk = '1'
                print(v.id, v.project, v.activation_date, v.changed_by_fk)
            try:
                db.session.commit()
            except Exception as e:
                print(e)
                db.session.rollback()
                break
    
    # update activation date for all other empty date with 29 feb 2024
    print('-* -*- *- *- *- * -* - *- * -* - * -* UPDATE NULL ACTIVATION DATE')
    volumes = db.session.query(Volume).filter(
        Volume.activation_date == None
    ).all()
    print('len of volumes:', len(volumes))
    if volumes:
            for v in volumes:
                print(v.id, v.project, v.activation_date, v.changed_by_fk)
                v.activation_date = datetime(2024,2,29)
                v.changed_by_fk = '1'
                print(v.id, v.project, v.activation_date, v.changed_by_fk)
            try:
                db.session.commit()
            except Exception as e:
                print(e)
                db.session.rollback()
                
                
    # update endlife date
    print('**** * * * * * * update endlife date')
    volumes = db.session.query(Volume).filter(
        Volume.endlife_date == None
    ).all()
    print('len volumes:', len(volumes))
    count = 0
    if volumes:
        for v in volumes:
            count += 1
            days = v.type.retention_days
            v.endlife_date = v.activation_date + timedelta(days=days)
            v.changed_by_fk = '1'
        try:
            db.session.commit()
            print(count,v.id, v.activation_date, v.endlife_date)
        except Exception as e:
                print(e)
                db.session.rollback()
                
            

def update_date2():
    volumes = db.session.query(Volume).filter(
        Volume.endlife_date == None
    ).all()
    print('**********************************')
    print('len volumes:', len(volumes))
    print('')
    print('')
    count = 0
    for v in volumes:
        count += 1
        days = v.type.retention_days
        v.endlife_date = v.activation_date + timedelta(days=days)
        v.changed_by_fk = '1'
        print(count,v.id, v.activation_date, v.endlife_date)
        
    db.session.commit()
     
        
            
