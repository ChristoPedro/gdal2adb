# Download GDAL

O link para o download está [aqui] (https://objectstorage.sa-saopaulo-1.oraclecloud.com/p/30NLO1KPkpHF9DsmkCs3ZA7ZeewadlxFq08HqXkjKWhes8Cd3PKYVJ7rg2DMo4JV/n/idrocd00mlxh/b/gdal/o/gdal_oracle18.zip)

Pelo terminal podemos utilizar os seguites comando para baixar:

$ wget https://bit.ly/3jZMGbW

Depois descompactamos o arquivo

$ unzip gdal_oracle18.zip -d [destination folder]
$ tar -xvf gdal_oracle18.tar

Vamos aproveitar e já dar as permissões de execução aos arquivos da pasta bin do gdal

$ chamod -R +x gdal/bin