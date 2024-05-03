def not_found():
    info = []
    count = 0
    with open('qbox/app/xlsx/nada_notfound.csv') as csv:
        for code in csv:
            count += 1
            code = code.strip()
            
            
            archivio, scaffale, progetto, tipo, descrizione = get_boxinfo(code)
            print(code)
            with open('qbox/app/xlsx/archivio23-04.csv') as archivio:
                for line in archivio:
                    if line.split(';')[0] == code:
                        print(line)
            
#not_found()

def get_boxinfo(code):
    with open('qbox/app/xlsx/archivio23-04.csv') as archivio:
        archivio = ''
        sezione = ''
        scaffale = ''
        progetto = ''
        servizio = ''
        settore = ''
        responsabile = ''
        documento = ''
        da = ''
        a = ''
        
        for line in archivio:
            line_list = line.split(';')
            if line_list[0] == code:
                if line_list[3]:
                    
