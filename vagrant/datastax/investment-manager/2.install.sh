#!/usr/bin/env bash
set -x # echo on

bash /cornerstone/vagrant/general/apt/install/jdk7_v2.sh
bash /cornerstone/vagrant/general/apt/install/maven2_v1.sh
bash /cornerstone/vagrant/general/file/install/tomcat_v2.sh

cd /cornerstone/web/datastax/investment-manager/StockData
mvn clean package
mvn install:install-file -DgroupId=StockData -DartifactId=StockData \
    -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar \
    -Dfile=/cornerstone/web/datastax/investment-manager/StockData/target/StockData-0.0.1-SNAPSHOT.jar

cd /cornerstone/web/datastax/investment-manager/Portfolio
mvn clean package

rm -rf /cache/installed/apache-tomcat-8.0.20/webapps/Portfolio
cp /cornerstone/web/datastax/investment-manager/Portfolio/target/Portfolio-0.0.1-SNAPSHOT.war /cache/installed/apache-tomcat-8.0.20/webapps/Portfolio.war