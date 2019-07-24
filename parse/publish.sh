#!/bin/bash

source /etc/profile
cd /opt/app/gnpd/parse/gnpd_parse
echo "------update source code -------------"
git pull
echo "-------------maven install----------------------------"
mvn clean install -Dmaven.test.skip=true
echo "-------run----"

mv target/gnpd_parser-jar-with-dependencies.jar ../gnpd_parser-jar-with-dependencies.jar

cd ../

echo "----------lunch jar----------"

sh restart.sh

# nohup java  -cp `hbase classpath`:/opt/app/GNPD/process_mintel/gnpd_parse/target/parse-1.0-SNAPSHOT-jar-with-dependencies.jar com.earlydata.gnpd.service.GoodsService > parse_gnpd.log & 
