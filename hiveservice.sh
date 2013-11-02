#!/bin/bash
server_ips=(localhost 10.209.22.186 10.209.125.24)
#server_ips=(10.227.16.78 10.227.16.79 10.227.16.80 10.227.14.22 10.227.10.164 10.227.10.138 10.227.10.141)
port=8080

set_whitelist_one() {
	ip=$1
	whitelist=$2
    echo "set whitelist for " $ip
    curl "http://$ip:$port/HiveService/monitor.htm?action=setWhitelist&whitelist="$whitelist
    echo "\n"
}

set_whitelist() {
	whitelist=$1
	for ip in $server_ips
	do
		set_whitelist_one $ip $whitelist
	done
}

get_whitelist_one() {
	ip=$1
	echo "whitelist of " $ip ":"
    curl "http://$ip:$port/HiveService/monitor.htm?action=getWhitelist"
    echo "\n"

}

get_whitelist() {
	for ip in $server_ips
	do
		get_whitelist_one $ip
	done
}

set_blacklist_one() {
	ip=$1
	blacklist=$2
	echo "set blacklist for " $ip
    curl "http://$ip:$port/HiveService/monitor.htm?action=setBlacklist&blacklist="$blacklist
    echo "\n"
	
}

set_blacklist() {
	blacklist=$1
	for ip in $server_ips
	do
		set_blacklist_one $ip $blacklist
	done
}

get_blacklist_one() {
	ip=$1
	echo "blacklist of " $ip ":"
    curl "http://$ip:$port/HiveService/monitor.htm?action=getBlacklist"
	echo "\n"

}

get_blacklist() {
	for ip in $server_ips
	do
		get_blacklist_one $ip
	done
}

set_threshold_one() {
	ip=$1
	threshold=$2
	echo "set threshold for " $ip
    curl "http://$ip:$port/HiveService/monitor.htm?action=setThreshold&t="$threshold
	echo "\n"
	
}

set_threshold() {
	threshold=$1
	for ip in $server_ips
	do
		set_threshold_one $ip $threshold
	done
}

get_threshold_one() {
	ip=$1
    echo "threshold of " $ip ":"
    curl "http://$ip:$port/HiveService/monitor.htm?action=getThreshold"
	echo "\n"

}

get_threshold() {
	for ip in $server_ips
	do
		get_threshold_one $ip
	done
}

simple_sql="select++*+from+xumm1+limit+100"
complex_sql="select+*+from+REL_LOG_TRACKER+where+dt%3D20131029+and+hour%3E%3D10+and++query+like+'%254AA49E0460028BE6B521929661889EF62D3ED9E53B5B0EDE%25'+limit+10%0A"
test_sql_one() {
	ip=$1
	userName=$2
	if [ -z $3 ]; then
		sql=$simple_sql
	else
		sql=$3
	fi

	echo "sql is: " $sql
    echo "jobId returned from" $ip ":"
    curl "http://$ip:$port/HiveService/monitor.htm?action=testSql&sql="$sql"&userName="$userName
	echo "\n"
}

test_sql() {
	for ip in $server_ips
	do
		test_sql_one $ip
	done
}

get_msg_cnt_one_quite() {
	ip=$1
	curl "http://$ip:$port/HiveService/monitor.htm?action=getCnt" 2>/dev/null
}

get_msg_cnt_one() {
	ip=$1
    echo "message count of " $ip ":"
    curl "http://$ip:$port/HiveService/monitor.htm?action=getCnt"
	echo "\n"
}

get_msg_cnt() {
	for ip in $server_ips
	do
		get_msg_cnt_one $ip
	done
}


loop_get_msg_cnt() {
	for ip in $server_ips
	do
		printf $ip"\t"
	done
	printf "\n"

    while [ 1 ]
    do
		for ip in $server_ips
		do
			cnt=`get_msg_cnt_one_quite $ip`
			printf $cnt"\t\t"
		done
		printf "\n"

        sleep 1
    done
}

get_max_msg_cnt() {
	grep  'size:' /home/adc/apache-tomcat-6.0.35/bin/logs/file.log.2013-10-31.log\  | grep -v '结束时间' | cut -d':' -f4,5| sed 's/开始时间：/:/g;s/---->size//g' | cut -d':' -f3 | sort -n | uniq | tail -n 1
}

benchmark_one() {
	ip=$1
	cnt=$2
    i=0
	while [ 1 ]
	do
		if [ "$i" -lt $cnt ]; then
     		i=`expr $i + 1`
			test_sql_one $ip mingming.xumm $complex_sql
		else
			break
		fi
	done
}
