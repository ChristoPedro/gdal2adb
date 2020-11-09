wget https://bit.ly/3jZMGbW

unzip gdal_oracle18.zip

tar -xvf gdal_oracle18.tar

chamod -R +x gdal/bin

export GDAL_HOME={pwd}/gdal
export ORACLE_HOME=/usr/lib/oracle/19.6/client64
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export GDAL_DATA=${GDAL_HOME}/data
export GDAL_DRIVER_PATH=${GDAL_HOME}/lib/gdalplugins
export PATH=${GDAL_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${GDAL_HOME}/lib:${LD_LIBRARY_PATH}
export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1