#!/bin/sh
DT=`date +%Y%m%d%H`
tmpFile="/opt/app/gnpd/parse/offset/offset-process-"$DT
group="group-goodsprocess-gnpd"
zk="d0:5181,d1:5181,d2:5181,d3:5181,d4:5181"
projectName="gnpd_parser-jar-with-dependencies.jar"
kafkaHome="/opt/kafka_2.11-0.10.0.1"

echo "..Begin restart process program........"

echo "Export consumer offset"
$kafkaHome/bin/kafka-run-class.sh kafka.tools.ExportZkOffsets --zkconnect $zk --group $group --output-file $tmpFile
sleep 1s
echo "Print offset before stop"
$kafkaHome/bin/kafka-consumer-groups.sh kafka.admin.ConsumerGroupCommand  --zookeeper $zk --describe --group $group | awk '$6!="0"{print}'
sleep 10s

echo "Import consumer offset"
$kafkaHome/bin/kafka-run-class.sh kafka.tools.ImportZkOffsets --input-file $tmpFile --zkconnect $zk
sleep 1s

echo "Start process program"

# nohup java  -cp `hbase classpath`:$projectName com.earlydata.gnpd.service.GoodsService > parse_gnpd.log &

java -Xms20480m -Xmx20480m -Xss512k -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9097  -Dcom.sun.management.jmxremote.rmi.port=9097 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Djava.rmi.server.hostname=101.231.74.138 -cp `hbase classpath`:$projectName com.earlydata.gnpd.service.GnpdParseService


