# Guide GDAL + ADW

Guide para realizar carga de arquivos georeferenciados para o Banco Autonomous através do GDAL.

## Passos:

### Download do arquivo compactado do GDAL 

O link para o download está [aqui](https://objectstorage.sa-saopaulo-1.oraclecloud.com/p/30NLO1KPkpHF9DsmkCs3ZA7ZeewadlxFq08HqXkjKWhes8Cd3PKYVJ7rg2DMo4JV/n/idrocd00mlxh/b/gdal/o/gdal_oracle18.zip)

Pelo terminal podemos utilizar os seguites comando para baixar:

    $ wget https://bit.ly/3jZMGbW

### Descompactando o arquivo

Depois descompactamos o arquivo

    $ unzip gdal_oracle18.zip -d [destination folder]
    $ tar -xvf gdal_oracle18.tar

Vamos aproveitar e já dar as permissões de execução aos arquivos da pasta bin do gdal

    $ chamod -R +x gdal/bin

### Download Oracle Client e o SQLPlus (Linux CentOS)

Faça o Download do Oracle CLient

    $ wget https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm

Faça do Download do SQLPlus

    $ wget https://download.oracle.com/otn_software/linux/instantclient/19600/oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm

### Instalando o Oracle Client e o SQLPlus (CentOS)

Para linux na distribuição CentOS precisamos executar os seguintes comandos:

    $ sudo rpm -i oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm
    $ sudo rpm -i oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm

### Instalando o Oracle Client e o SQLPlus (Debian)

Para linux na distribuição Debian devemos primero baixar o pacote alien:

    $ sudo add-apt-repository universe
    $ sudo apt-get update -y && sudo apt-get install -y alien

Depois utilizar o alien para "traduzir" os pacotes rpm para .deb

    $ sudo alien oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm
    $ sudo alien oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm

E agora podemos instalar os pacotes

    $ sudo dpkg -i oracle-instantclient19.6-basic_19.6.0.0.0-2_amd64.deb
    $ sudo dpkg -i oracle-instantclient19.6-sqlplus_19.6.0.0.0-2_amd64.deb

Para o Debian, também preciamos baixar e instalar o libssl1

    $ wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb
    $ sudo dpkg -i libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb
    $ sudo ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /usr/lib/libcrypto.so.10
    $ sudo ln -s /usr/lib/x86_64-linux-gnu/libcrypto.so.1.0.0 /lib/libcrypto.so.10

### Configurando a Wallet de Conexão do Autonomous Database

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

    $ sudo vi /etc/profile

E adiciona o comando do export no final do arquivo

### Testado a conexão com o Autonomous Database

Vamos executar o sqlplus para verificar a conexão com o banco

    $ sqlplus
    Enter user-name: [usuari]@[string_de_conexão]
    Password: 

Se a conexão foi um sucesso podemos prosseguir para a configuração do gdal

### Configurando o Gdal

Primero vamos criar a variave GDAL_HOME

    $ export GDAL_HOME=[path_gdal]

Faça o Download do arquivo de configuração

    $ wget https://raw.githubusercontent.com/ChristoPedro/gdal2adb/master/setup_gdal.conf

Copie o arquivo para a pasta do gdal

    $ cp setup_gdal.conf [path_do_gdal]/gdal

Va para a pasta do gdal e execute o arquivo

    $ . setup_gdal.conf

Para não ser necessário executar o arquivo toda vez que se logar na máquina vamos editar novamente o arquivo /etc/profile

   $ sudo vi /etc/profile

Vamos adicionar ao final do arquivo
    
    export GDAL_HOME=[path_gdal]
    . /[path_gdal]/setup_gdal.conf

### Testando o upload de dados para o Autonomous Database