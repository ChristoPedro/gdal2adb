import os

def load_data():

    dbuser = 'user'
    dbpassword = 'password'
    conection_string = 'db_high'

    filepath = '/home/ubuntu/geofile'
    filename = '10-11.shp'

    code = 'ogr2ogr -append --config OCI_FID objectid -nln Nuevo2 -f OCI OCI:'+ dbuser +'/'+ dbpassword + '@' + conection_string + ':NUEVO2  ' + filepath + '/' + filename 

    os.system(code)

if __name__ == "__main__":
    load_data()