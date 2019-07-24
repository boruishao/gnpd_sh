#!/bin/sh
projectName="fetch-1.0-SNAPSHOT-jar-with-dependencies.jar"


echo "Start process program"

java -cp $(hadoop classpath):$projectName  com.earlydata.net.service.FetchService
