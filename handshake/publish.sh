#!/bin/bash

jarname="gnpd_parser_task-jar-with-dependencies.jar"

source /etc/profile
cd /opt/app/gnpd/handshake/gnpd_handshake 
echo "------update source code -------------"

git pull
echo "-------------maven install----------------------------"
mvn clean install -Dmaven.test.skip=true
echo "-------run----"

mv target/$jarname ../$jarname

cd ../

echo "----------lunch jar----------"

sh restart.sh

