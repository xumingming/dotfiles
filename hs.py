#!/usr/bin/python
import urllib2
import sys
from time import sleep
from os.path import expanduser

#test_server_ips = ["localhost"]
test_server_ips = ["localhost", "10.209.125.24", "10.209.22.186"]
prod_server_ips=["10.227.16.78", "10.227.16.79", "10.227.16.80", "10.227.14.22", "10.227.10.164", "10.227.10.138", "10.227.10.141"]
server_ips=test_server_ips
port=8080

def get_detail_message_count(ip):
    url = "http://%s:%s/HiveService/monitor.htm?action=getDetailMessageCount" % (ip, port)
    return read_url_content(url)

def set_message_count_threshold(ip, threshold):
    url = "http://%s:%s/HiveService/monitor.htm?action=setMessageCountThreshold&t=%s" % (ip, port, threshold)
    return read_url_content(url)

def get_message_count_threshold(ip):
    url = "http://%s:%s/HiveService/monitor.htm?action=getMessageCountThreshold" % (ip, port)
    return read_url_content(url)

def get_running_task_count_threshold(ip):
    url = "http://%s:%s/HiveService/monitor.htm?action=getRunningTaskCountThreshold" % (ip, port)
    return read_url_content(url)

def set_running_task_count_threshold(ip, t):
    url = "http://%s:%s/HiveService/monitor.htm?action=setRunningTaskCountThreshold&t=%s" % (ip, port, t)
    return read_url_content(url)

def set_whitelist(ip, whitelist):
    url = "http://%s:%s/HiveService/monitor.htm?action=setWhitelist&whitelist=%s" % (ip, port, whitelist)
    return read_url_content(url)

def get_whitelist(ip):
    url = "http://%s:%s/HiveService/monitor.htm?action=getWhitelist" % (ip, port)
    return read_url_content(url)

def set_blacklist(ip, blacklist):
    url = "http://%s:%s/HiveService/monitor.htm?action=setBlacklist&blacklist=%s" % (ip, port, blacklist)
    return read_url_content(url)

def get_blacklist(ip):
    url = "http://%s:%s/HiveService/monitor.htm?action=getBlacklist" % (ip, port)
    return read_url_content(url)

def get_send_log_thread_count(ip):
    url = "http://%s:%s/HiveService/monitor.htm?action=getSendLogThreadCount" % (ip, port)
    return read_url_content(url)

def get_stat(ip, stats):
    stats = ",".join(stats)
    url = "http://%s:%s/HiveService/monitor.htm?action=getStat&stats=%s" % (ip, port, stats)
    return read_url_content(url)

simple_sql="select++*+from+auto_test+limit+100"
complex_sql="select+*+from+REL_LOG_TRACKER+where+dt%3D20131029+and+hour%3E%3D10+and++query+like+'%254AA49E0460028BE6B521929661889EF62D3ED9E53B5B0EDE%25'+limit+10%0A"
def test_sql(ip, sql, username):
    if not username:
        username = "mingming.xumm"

    if not sql:
        sql = simple_sql
    url = "http://%s:%s/HiveService/monitor.htm?action=testSql&sql=%s&username=%s" % (ip, port, sql, username)
    return read_url_content(url)

def benchmark(ip, sql, username, num):
    if not sql:
        sql = simple_sql

    print "sql: ", sql, ", username:", username
    for i in range(0, num):
        test_sql(ip, sql, username)

def multi_do(fn, params):
    for ip in get_server_ips():
        new_params = [ip]
        if params != None and len(params) > 0:
            new_params += params

        resp = apply(fn, new_params)
        print "%s: %s" % (ip, resp)

def put_online(target_ip, message_count_threshold):
    print "[before]Blacklist of the cluster:"
    multi_do(get_blacklist, None)

    print "Remove %s from blacklist in the cluster" % (target_ip)
    target_blacklist = ""
    for ip in get_server_ips():
        orig_blacklist = get_blacklist(ip)
        if not orig_blacklist:
            orig_blacklist = []
        else:
            orig_blacklist = orig_blacklist.split(",")

        try:
            orig_blacklist.remove(target_ip)
        except ValueError:
            pass

        new_blacklist = orig_blacklist
        print "new: ", new_blacklist
        new_blacklist = ",".join(new_blacklist)
        if ip != target_ip:
            target_blacklist = new_blacklist
        resp = set_blacklist(ip, new_blacklist)
        print "%s: %s" % (ip, resp)

    print "[after]Blacklist of the cluster:"
    multi_do(get_blacklist, None)

    print "set message count of %s to %s" % (ip, message_count_threshold)
    set_message_count_threshold(ip, message_count_threshold)

    print "set blacklist of %s to %s " % (target_ip, target_blacklist)
    set_blacklist(target_ip, target_blacklist)


def put_offline(target_ip):
    print "[before]Blacklist of the cluster:"
    multi_do(get_blacklist, None)

    print "Add %s to blacklist in the cluster" % (target_ip)
    for ip in get_server_ips():
        orig_blacklist = get_blacklist(ip)
        if not orig_blacklist:
            orig_blacklist = []
        else:
            orig_blacklist = orig_blacklist.split(",")
            
        try:
            orig_blacklist.remove(target_ip)
        except ValueError:
            pass

        new_blacklist = orig_blacklist + [target_ip]
        print "new: ", new_blacklist
        new_blacklist = ",".join(new_blacklist)
        resp = set_blacklist(ip, new_blacklist)
        print "%s: %s" % (ip, resp)

    print "[after]Blacklist of the cluster:"
    multi_do(get_blacklist, None)

    print "set message count of %s to -1" % (target_ip)
    set_message_count_threshold(target_ip, -1)

def loop_get_stat(stat_names,format):
    i = 0
    use_default = False
    if not stat_names:
        use_default = True
        stat_names = ["totalMessageCount", "runningTaskCount"]

    if not format:
        format = "1,2"

    formats = [int(x) for x in format.split(",")]
    if len(formats) != 2:
        print "Error format %s" % format
        return

    header_template = "%s" + "".join(["\t" for x in range(formats[0])])
    result_template = "%s" + "".join(["\t" for x in range(formats[1])])
    while True:
        if i % 20 == 0:
            print
            for ip in get_server_ips():
                sys.stdout.write(header_template % (ip))
            print

        for ip in get_server_ips():
            stats = get_stat(ip, stat_names)
            sys.stdout.write(result_template % (stats))
        
        print
        sleep(1)
        i += 1

def read_file_content(path):
    file = open(path, 'r')
    ret = file.read().strip()
    file.close()
    
    return ret

def read_url_content(url):
    try:
        resp = urllib2.urlopen(url).read()
        return resp
    except urllib2.HTTPError:
        return "ERROR"
 
def get_env():
    return read_file_content(expanduser("~") + '/.hsconfig/env').strip()

def get_port():
    return int(read_file_content(expanduser("~") + '/.hsconfig/port').strip())

def get_server_ips():
    env = get_env()
    if env == "test":
        return test_server_ips
    elif env == "prod":
        return prod_server_ips

if __name__ == "__main__":
    action=sys.argv[1]

    if action == "get_detail_message_count":
        if len(sys.argv) < 3:
            multi_do(get_detail_message_count, None)
        else:
            ip=sys.argv[2]
            resp = get_detail_message_count(ip)
            print resp
    elif action == "get_message_count_threshold":
        if len(sys.argv) < 3:
            multi_do(get_message_count_threshold, None)
        else:
            ip=sys.argv[2]
            resp = get_message_count_threshold(ip)
            print resp
        
    elif action == "set_message_count_threshold":
        message_count_threshold=sys.argv[2]
        if len(sys.argv) < 4:
            multi_do(set_message_count_threshold, [message_count_threshold])
        else:
            ip=sys.argv[3]
            resp = set_message_count_threshold(ip, message_count_threshold)
            print resp
    elif action == "get_whitelist":
        if len(sys.argv) < 3:
            multi_do(get_whitelist, None)
        else:
            ip=sys.argv[2]
            resp = get_whitelist(ip)
            print resp
    elif action == "set_whitelist":
        if len(sys.argv) < 4:
            whitelist=sys.argv[2]
            multi_do(set_whitelist, [whitelist])
        else:
            ip=sys.argv[2]
            whitelist=sys.argv[3]
            resp = set_whitelist(ip, whitelist)
            print resp
    elif action == "get_blacklist":
        if len(sys.argv) < 3:
            multi_do(get_blacklist, None)
        else:
            ip=sys.argv[2]
            resp = get_blacklist(ip)
            print resp
    elif action == "set_blacklist":
        blacklist=sys.argv[2]
        if len(sys.argv) < 4:
            multi_do(set_blacklist, [blacklist])
        else:
            ip=sys.argv[3]
            resp = set_blacklist(ip, blacklist)
            print resp
    elif action == "get_running_task_count_threshold":
        if len(sys.argv) < 3:
            multi_do(get_running_task_count_threshold, None)
        else:
            ip=sys.argv[2]
            resp = get_running_task_count_threshold(ip)
            print resp
    elif action == "set_running_task_count_threshold":
        running_task_count_threshold=sys.argv[2]
        if len(sys.argv) < 4:
            multi_do(set_running_task_count_threshold, [running_task_count_threshold])
        else:
            ip=sys.argv[3]
            resp = set_running_task_count_threshold(ip, running_task_count_threshold)
            print resp
    elif action == "get_send_log_thread_count":
        if len(sys.argv) < 3:
            multi_do(get_send_log_thread_count, None)
        else:
            ip=sys.argv[2]
            resp = get_send_log_thread_count(ip)
            print resp
    elif action == "get_stat":
        stats = sys.argv[2].split(",")
        if len(sys.argv) < 4:
            multi_do(get_stat, [stats])
        else:
            ip=sys.argv[3]
            resp = get_stat(ip, stats)
            print resp
    elif action == "loop_stat":
        stat_names = None
        if len(sys.argv) > 2:
            stat_names = sys.argv[2].split(",")
        format = None
        if len(sys.argv) > 3:
            format = sys.argv[3]
        loop_get_stat(stat_names, format)
    elif action == "put_offline":
        ip = sys.argv[2]
        put_offline(ip)
    elif action == "put_online":
        ip = sys.argv[2]
        message_count_threshold=sys.argv[3]
        put_online(ip, message_count_threshold)
    elif action == "benchmark":
        sql = sys.argv[2]
        username = sys.argv[3]
        num = sys.argv[4]

        if len(sys.argv) < 6:
            multi_do(benchmark, [sql, username, int(num)])
        else:
            ip = sys.argv[5]
            benchmark(ip, sql, username, int(num))


