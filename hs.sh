#!/bin/bash
get_max_msg_cnt() {
	grep  'size:' /home/adc/apache-tomcat-6.0.35/bin/logs/file.log.2013-10-31.log\  | grep -v '结束时间' | cut -d':' -f4,5| sed 's/开始时间：/:/g;s/---->size//g' | cut -d':' -f3 | sort -n | uniq | tail -n 1
}


publish() {
	warpath=$1
	echo "before kill tomcat: "
	$JAVA_HOME/bin/jps
	echo 

	# kill tomcat
	$JAVA_HOME/bin/jps | grep Bootstrap | cut -d' ' -f1 | xargs kill -9

	echo "after kill tomcat: "
	$JAVA_HOME/bin/jps
	echo

	#  delete files
	export CATALINA_HOME=/home/adc/apache-tomcat-6.0.35
	echo "CATALINA_HOME: " $CATALINA_HOME
    rm -rf $CATALINA_HOME/webapps/HiveService*

	# copy file
	cp $warpath $CATALINA_HOME/webapps/HiveService.war

	# start tomcat
	cd $CATALINA_HOME/bin
	./startup.sh
	
	# tail log
	tail -f ../logs/catalina.out
}

