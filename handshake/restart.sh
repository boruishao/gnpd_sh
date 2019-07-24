#!/bin/sh
projectName="gnpd_parser_task-jar-with-dependencies.jar"
echo "Start process program"
cd /opt/app/gnpd/handshake/
java -cp $projectName com.earlydata.gnpd.service.SyncCounter

