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
    $ sudo apt-get update -y && apt-get install -y alien

Depois utilizar o alien para "traduzir" os pacotes rpm para .deb

    $ sudo alien oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.rpm
    $ sudo alien oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.rpm

E agora podemos instalar os pacotes

    $ sudo dpkg -i oracle-instantclient19.6-basic-19.6.0.0.0-1.x86_64.deb
    $ sudo dpkg -i oracle-instantclient19.6-sqlplus-19.6.0.0.0-1.x86_64.deb





### Configurando a Wallet do Autonomous Database

 * Faça o download da Wallet
 * Desconpact a Wallet para 