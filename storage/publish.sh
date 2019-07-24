#!/bin/bash

jarname="storage-1.0-SNAPSHOT-jar-with-dependencies.jar"
source /etc/profile
cd /opt/app/gnpd/storage/storage
echo "------update source code -------------"
git pull
echo "-------------maven install----------------------------"
mvn clean install -Dmaven.test.skip=true
echo "-------run----"

mv target/$jarname ../$jarname

cd ../

echo "----------lunch jar----------"

sh restart.sh

