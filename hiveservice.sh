#!/bin/bash
server_ips=(localhost 10.209.22.186 10.209.125.24)
#server_ips=(10.227.16.78 10.227.16.79 10.227.16.80 10.227.14.22 10.227.10.164 10.227.10.138 10.227.10.141)

set_whitelist() {
	whitelist=$1
	for ip in $server_ips
	do
		echo "set whitelist for " $ip
        curl "http://$ip:8080/HiveService/monitor.htm?action=setWhitelist&whitelist="$whitelist
		echo "\n"
	done
}

get_whitelist() {
	for ip in $server_ips
	do
		echo "whitelist of " $ip ":"
        curl "http://$ip:8080/HiveService/monitor.htm?action=getWhitelist"
		echo "\n"
	done
}

set_blacklist() {
	blacklist=$1
	for ip in $server_ips
	do
		echo "set blacklist for " $ip
        curl "http://$ip:8080/HiveService/monitor.htm?action=setBlacklist&blacklist="$blacklist
		echo "\n"
	done
}

get_blacklist() {
	for ip in $server_ips
	do
		echo "blacklist of " $ip ":"
        curl "http://$ip:8080/HiveService/monitor.htm?action=getBlacklist"
		echo "\n"
	done
}


set_threshold() {
	threshold=$1
	for ip in $server_ips
	do
		echo "set threshold for " $ip
        curl "http://$ip:8080/HiveService/monitor.htm?action=setThreshold&t="$threshold
		echo "\n"
	done
}

get_threshold() {
	for ip in $server_ips
	do
		echo "threshold of " $ip ":"
        curl "http://$ip:8080/HiveService/monitor.htm?action=getThreshold"
		echo "\n"
	done
}

get_msg_cnt() {
	for ip in $server_ips
	do
		echo "message count of " $ip ":"
        curl "http://$ip:8080/HiveService/monitor.htm?action=getCnt"
		echo "\n"
	done
}

get_max_msg_cnt() {
	grep  'size:' /home/adc/apache-tomcat-6.0.35/bin/logs/file.log.2013-10-31.log\  | grep -v '结束时间' | cut -d':' -f4,5| sed 's/开始时间：/:/g;s/---->size//g' | cut -d':' -f3 | sort -n | uniq | tail -n 1
}
