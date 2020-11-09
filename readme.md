# Guide GDAL + ADB

Guide para realizar carga de arquivos georeferenciados para o Banco Autonomous através do GDAL, em sistemas operacionais linux baseados em CentOS ou Debian.

## Passos:

- Download do Oracle Client e SQL*PLus
- Configuração do Oracle CLient e SQL*Plus
- Configuração libssl1 para distribuições Debian
- Download e configuração da Wallet de Conexão do Banco ADW
- Teste de conexão ao ADB através do SQL*Plus
- Download e configuração do GDAL
- Teste do GDAL

## Download Oracle Client e SQL*Plus (Linux e CentOS)

Faça o Download do Oracle CLient

    $ wget https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm

Faça do Download do SQL*Plus

    $ wget https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm

## Configuração o Oracle Client o SQLPlus

### CentOS

Para linux na distribuição CentOS precisamos executar os seguintes comandos:

    $ sudo rpm -i oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm
    $ sudo rpm -i oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm

### Debian

Para linux na distribuição Debian devemos primero baixar o pacote alien:

    $ sudo add-apt-repository universe
    $ sudo apt-get update -y && sudo apt-get install -y alien

Depois utilizar o alien para "traduzir" os pacotes rpm para .deb

    $ sudo alien oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm
    $ sudo alien oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm

E agora podemos instalar os pacotes

    $ sudo dpkg -i oracle-instantclient19.6-basic_19.6.0.0.0-2_amd64.deb
    $ sudo dpkg -i oracle-instantclient19.6-sqlplus_19.6.0.0.0-2_amd64.deb

## Configuração libssl1

Para o Debian, também preciamos baixar e instalar o libssl1. É possivel encontrar o pacote libssl1 no https://pkgs.org/, lá você pode procurar pela versão que atenda melhor seu SO. Vamos utilizar o Ubuntu como exemplo de configuração.

    $ wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb
    $ sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb
    $ sudo ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.10
    $ sudo ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /lib/libcrypto.so.10

## Configurando a Wallet de Conexão do Autonomous Database

Transfira a wallet para a máquina.

Descompact a wallet para o diretório que vamos associar ao TNS_ADMIN.

    $ unzip [wallet_name].zip -d [path_da_wallet]

Pegue o path completo da pasta onde a wallet foi descompactada

    $ pwd

Edite o arquivo sqlnet.ora

    $ vi sqlnet.ora

Vamos trocar a parte do "?/network/admin", pelo path atual da wallet

### Cnfigurando o TNS_ADMIN

Agora vamos executar

    $ export TNS_ADMIN=[path onde sua wallet foi descompactada]

Para não precisar confirar essa variável toda vez que for realizado o login no linux podemos editar o arquivo /etc/profile para sempre criar a variável

    $ sudo echo export TNS_ADMIN=$TNS_ADMIN >> /etc/profile

## Testado a conexão com o Autonomous Database

Vamos executar o sqlplus para verificar a conexão com o banco

    $ sqlplus
    Enter user-name: [usuario]@[string_de_conexão]
    Password: 

Se a conexão foi um sucesso podemos prosseguir para a configuração do gdal

## Configurando o Gdal

Vamos fazer o download e executar o bash script que já vem com todos os comando necessários para realizar o download e configurar o Gdal.

    $ wget https://raw.githubusercontent.com/ChristoPedro/gdal2adb/master/gdal_setup.sh
    $ sudo bash gdal_setup.sh

Para testar a configuração, podemos executar o seguinte comando:

    $ ogr2ogr

E devemos ter uma resposta parecida com essa:

    Usage: ogr2ogr [--help-general] [-skipfailures] [-append] [-update]
               [-select field_list] [-where restricted_where|@filename]
               [-progress] [-sql <sql statement>|@filename] [-dialect dialect]
               [-preserve_fid] [-fid FID]
               [-spat xmin ymin xmax ymax] [-spat_srs srs_def] [-geomfield field]
               [-a_srs srs_def] [-t_srs srs_def] [-s_srs srs_def]
               [-f format_name] [-overwrite] [[-dsco NAME=VALUE] ...]
               dst_datasource_name src_datasource_name
               [-lco NAME=VALUE] [-nln name]
               [-nlt type|PROMOTE_TO_MULTI|CONVERT_TO_LINEAR]
               [-dim 2|3|layer_dim] [layer [layer ...]]

    Advanced options :
               [-gt n] [-ds_transaction]
               [[-oo NAME=VALUE] ...] [[-doo NAME=VALUE] ...]
               [-clipsrc [xmin ymin xmax ymax]|WKT|datasource|spat_extent]
               [-clipsrcsql sql_statement] [-clipsrclayer layer]
               [-clipsrcwhere expression]
               [-clipdst [xmin ymin xmax ymax]|WKT|datasource]
               [-clipdstsql sql_statement] [-clipdstlayer layer]
               [-clipdstwhere expression]
               [-wrapdateline][-datelineoffset val]
               [[-simplify tolerance] | [-segmentize max_dist]]
               [-addfields] [-unsetFid]
               [-relaxedFieldNameMatch] [-forceNullable] [-unsetDefault]
               [-fieldTypeToString All|(type1[,type2]*)] [-unsetFieldWidth]
               [-mapFieldType srctype|All=dsttype[,srctype2=dsttype2]*]
               [-fieldmap identity | index1[,index2]*]
               [-splitlistfields] [-maxsubfields val]
               [-explodecollections] [-zfield field_name]
               [-gcp pixel line easting northing [elevation]]* [-order n | -tps]
               [-nomd] [-mo "META-TAG=VALUE"]* [-noNativeData]

    Note: ogr2ogr --long-usage for full help.

    FAILURE: no target datasource provided

## Testando o upload de dados para o Autonomous Database

Na pasta onde temos os arquivos .shx, .shp e .dbf, vamos executar o seguinte comando substituindo os campos entre []:

    ogr2ogr --config OCI_FID objectid \
    -lco GEOMETRY_NAME=geom \
    -lco spatial_index="false" \
    -lco SRID=4326 \
    -lco DIMINFO_X="-180,180,.005"  -lco DIMINFO_Y="-90,90,.005" \
    -nln [Nome da tabela] -f OCI OCI:[usuario]/[senha]@[string de conexão]:  [nome do arquivo].shp

Esse código cria uma nova tabela no banco de dados com as informações dos arquivos em questão.

Se quisermos apenas fazer um update de dados em uma tabela já existente, usitlizamos o seguinte código:

OBS: temos que tomar cuidado pois o nome da tabela nesse caso é Case Sensitive.

    ogr2ogr -append --config OCI_FID objectid \
    -nln [Nome da tabela] -f OCI OCI:[usuario]/[senha]@[string de conexão]:[Nome da tabela]  [nome do arquivo].shp