import os

def load_data():

    dbuser = 'admin'
    dbpassword = 'Oracle123456'
    conection_string = 'adwtest_high'

    filepath = '/home/ubuntu/geofile'
    filename = '10-11.shp'

    code = 'ogr2ogr -append --config OCI_FID objectid -nln Nuevo2 -f OCI OCI:'+ dbuser +'/'+ dbpassword + ':NUEVO2  ' + filepath + '/' + filename 

    os.system(code)

if __name__ == "__main__":
    load_data()