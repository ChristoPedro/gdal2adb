wget https://bit.ly/3jZMGbW

unzip gdal_oracle18.zip

tar -xvf gdal_oracle18.tar

chmod -R +x gdal/bin

rm gdal_oracle18.zip
rm gdal_oracle18.tar

export GDAL_HOME=${PWD}/gdal
export ORACLE_HOME=/usr/lib/oracle/19.6/client64
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export GDAL_DATA=${GDAL_HOME}/data
export GDAL_DRIVER_PATH=${GDAL_HOME}/lib/gdalplugins
export PATH=${GDAL_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${GDAL_HOME}/lib:${LD_LIBRARY_PATH}
export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1

echo export GDAL_HOME=$GDAL_HOME >> /etc/profile
echo export ORACLE_HOME=/usr/lib/oracle/19.6/client64 >> /etc/profile
echo export LD_LIBRARY_PATH=$ORACLE_HOME/lib >> /etc/profile
echo export GDAL_DATA=${GDAL_HOME}/data >> /etc/profile
echo export GDAL_DRIVER_PATH=${GDAL_HOME}/lib/gdalplugins >> /etc/profile
echo export PATH=${GDAL_HOME}/bin:${PATH} >> /etc/profile
echo export LD_LIBRARY_PATH=${GDAL_HOME}/lib:${LD_LIBRARY_PATH} >> /etc/profile
echo export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1 >> /etc/profile