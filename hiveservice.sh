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

get_msg_cnt() {
	for ip in $server_ips
	do
		echo "message count of " $ip ":"
        curl "http://$ip:$port/HiveService/monitor.htm?action=getCnt"
		echo "\n"
	done
}

get_max_msg_cnt() {
	grep  'size:' /home/adc/apache-tomcat-6.0.35/bin/logs/file.log.2013-10-31.log\  | grep -v '结束时间' | cut -d':' -f4,5| sed 's/开始时间：/:/g;s/---->size//g' | cut -d':' -f3 | sort -n | uniq | tail -n 1
}
