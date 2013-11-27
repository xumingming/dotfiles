#!/usr/bin/python
import urllib2
import sys
import re
from time import sleep
from os.path import expanduser

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
    except urllib2.URLError:
        return "ERROR"
 
def get_env():
    return read_file_content(expanduser("~") + '/.hsconfig/env').strip()

def get_port():
    return int(read_file_content(expanduser("~") + '/.hsconfig/port').strip())

def get_server_ips():
    server_ips = read_file_content(expanduser("~") + '/.hsconfig/servers').strip()
    server_ips = server_ips.split(",")
    return server_ips
    
def get_real_ip(ip):
    if re.search("^([0-9]+[.]){3}[0-9]+$", ip):
        return ip
    else:
        for server_ip in get_server_ips():
            if server_ip.find(ip) >= 0:
                print " --- using ip: %s ---\n" % (server_ip)
                return server_ip

        return ""

port=get_port()
server_ips=get_server_ips()

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


def add_blackip(ip, black_ip):
    orig_blacklist = get_blacklist(ip)
    if not orig_blacklist:
        orig_blacklist = []
    else:
        orig_blacklist = orig_blacklist.split(",")
    try:
        orig_blacklist.remove(black_ip)
    except ValueError:
        pass

    new_blacklist = orig_blacklist + [black_ip]
    new_blacklist = ",".join(new_blacklist)
    resp = set_blacklist(ip, new_blacklist)
    return resp

def remove_blackip(ip, target_ip):
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
    new_blacklist = ",".join(new_blacklist)
    resp = set_blacklist(ip, new_blacklist)
    return new_blacklist, resp

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

def get_running_tasks(ip):
    tasks_str = get_stat(ip, ["runningTasks"])
    tasks = []
    if len(tasks_str) > 0:
        tasks = tasks_str.split(",")

    return tasks

simple_sql="select++count(*)+from+table_for_auto_test+limit+500"
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
        print test_sql(ip, sql, username)

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
        new_blacklist, resp = remove_blackip(ip, target_ip)

        if ip != target_ip:
            target_blacklist = new_blacklist
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
        resp = add_blackip(ip, target_ip)
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

def help():
    print "hs.py detail_message_count/dmc [ip]                           --- print the detailed message count"
    print "hs.py get_message_count_threshold/gmct [ip]                   --- print message count threshold"
    print "hs.py set_message_count_threshold/smct <threshold> [ip]       --- set message count threshold"
    print "hs.py get_whitelist/gw [ip]                                   --- print the whitelist"
    print "hs.py set_whitelist/sw <whitelist> [ip]                       --- set the whitelist"
    print "hs.py get_blacklist/gb [ip]                                   --- get the blacklist"
    print "hs.py set_blacklist/sb <blacklist> [ip]                       --- set the blacklist"
    print "hs.py add_blackip/ab black_ip [ip]                            --- add an ip to blacklist"
    print "hs.py remove_blackip/rb black_ip [ip]                         --- remove an ip from blacklist"
    print "hs.py get_running_task_count_threshold/grtct [ip]             --- get running task count threshold"
    print "hs.py set_running_task_count_threshold/srtct <threshold> [ip] --- get running task count threshold"
    print "hs.py get_send_log_thread_count/gsltc [ip]                    --- print send log thread count"
    print "hs.py stat <stat_names> [ip]                                  --- get various stat by names"
    print "hs.py tasks [ip]                                              --- print the running tasks"
    print "hs.py monitor [stat_names] [format]                           --- continiously print the system stat"
    print "hs.py put_offline <ip>                                        --- put a machine offline"
    print "hs.py put_online <ip> <message_count_threshold>               --- put a machine online"
    print "hs.py benchmark <sql> <username> <times> <ip>                 --- do a benchmark"
    print "hs.py test <ip>                                               --- a basic test"
    print "hs.py servers                                                 --- list the server ips"

def main():
    if len(sys.argv) == 1:
        help()
        return

    action=sys.argv[1]
    if action == "help":
        help()
    if action in ["detail_message_count", "dmc"]:
        if len(sys.argv) < 3:
            multi_do(get_detail_message_count, None)
        else:
            ip=get_real_ip(sys.argv[2])
            resp = get_detail_message_count(ip)
            print resp
    elif action in ["get_message_count_threshold", "gmct"]:
        if len(sys.argv) < 3:
            multi_do(get_message_count_threshold, None)
        else:
            ip=get_real_ip(sys.argv[2])
            resp = get_message_count_threshold(ip)
            print resp
    elif action in ["set_message_count_threshold", "smct"]:
        message_count_threshold=sys.argv[2]
        if len(sys.argv) < 4:
            multi_do(set_message_count_threshold, [message_count_threshold])
        else:
            ip=get_real_ip(sys.argv[3])
            resp = set_message_count_threshold(ip, message_count_threshold)
            print resp
    elif action in ["get_whitelist", "gw"]:
        if len(sys.argv) < 3:
            multi_do(get_whitelist, None)
        else:
            ip=get_real_ip(sys.argv[2])
            resp = get_whitelist(ip)
            print resp
    elif action in ["set_whitelist", "sw"]:
        if len(sys.argv) < 4:
            whitelist=sys.argv[2]
            multi_do(set_whitelist, [whitelist])
        else:
            ip=get_real_ip(sys.argv[2])
            whitelist=sys.argv[3]
            resp = set_whitelist(ip, whitelist)
            print resp
    elif action in ["get_blacklist", "gb"]:
        if len(sys.argv) < 3:
            multi_do(get_blacklist, None)
        else:
            ip=get_real_ip(sys.argv[2])
            resp = get_blacklist(ip)
            print resp
    elif action in ["set_blacklist", "sb"]:
        blacklist=sys.argv[2]
        if len(sys.argv) < 4:
            multi_do(set_blacklist, [blacklist])
        else:
            ip=sys.argv[3]
            resp = set_blacklist(ip, blacklist)
            print resp
    elif action in ["add_blackip", "ab"]:
        black_ip=sys.argv[2]
        if len(sys.argv) < 4:
            multi_do(add_blackip, [black_ip])
        else:
            ip=sys.argv[3]
            resp = add_blackip(ip, black_ip)
            print resp
    elif action in ["remove_blackip", "rb"]:
        black_ip=sys.argv[2]
        if len(sys.argv) < 4:
            multi_do(remove_blackip, [black_ip])
        else:
            ip=sys.argv[3]
            resp = remove_blackip(ip, black_ip)
            print resp
    elif action in ["get_running_task_count_threshold", "grtct"]:
        if len(sys.argv) < 3:
            multi_do(get_running_task_count_threshold, None)
        else:
            ip=get_real_ip(sys.argv[2])
            resp = get_running_task_count_threshold(ip)
            print resp
    elif action in ["set_running_task_count_threshold", "srtct"]:
        running_task_count_threshold=sys.argv[2]
        if len(sys.argv) < 4:
            multi_do(set_running_task_count_threshold, [running_task_count_threshold])
        else:
            ip=get_real_ip(sys.argv[3])
            resp = set_running_task_count_threshold(ip, running_task_count_threshold)
            print resp
    elif action in ["get_send_log_thread_count", "gsltc"]:
        if len(sys.argv) < 3:
            multi_do(get_send_log_thread_count, None)
        else:
            ip=get_real_ip(sys.argv[2])
            resp = get_send_log_thread_count(ip)
            print resp
    elif action == "tasks":
        if len(sys.argv) < 3:
            multi_do(get_running_tasks, None)
        else:
            ip=get_real_ip(sys.argv[2])
            resp = get_running_tasks(ip)
            print resp
    elif action == "stat":
        stats = sys.argv[2].split(",")
        if len(sys.argv) < 4:
            multi_do(get_stat, [stats])
        else:
            ip=get_real_ip(sys.argv[3])
            resp = get_stat(ip, stats)
            print resp
    elif action == "monitor":
        stat_names = None
        if len(sys.argv) > 2:
            stat_names = sys.argv[2].split(",")
        format = None
        if len(sys.argv) > 3:
            format = sys.argv[3]
        loop_get_stat(stat_names, format)
    elif action == "put_offline":
        ip = get_real_ip(sys.argv[2])
        put_offline(ip)
    elif action == "put_online":
        ip = get_real_ip(sys.argv[2])
        message_count_threshold=sys.argv[3]
        put_online(ip, message_count_threshold)
    elif action == "benchmark":
        sql = sys.argv[2]
        username = sys.argv[3]
        num = sys.argv[4]

        if len(sys.argv) < 6:
            multi_do(benchmark, [sql, username, int(num)])
        else:
            ip = get_real_ip(sys.argv[5])
            benchmark(ip, sql, username, int(num))
    elif action == "test":
        sql = "select+*+from+table_for_auto_test+limit+5"
        username = "nanjie.hu"
        if get_env() == "prod":
            username = "mingming.xumm"
        num = 1

        if len(sys.argv) < 3:
            multi_do(benchmark, [sql, username, int(num)])
        else:
            ip = get_real_ip(sys.argv[2])
            benchmark(ip, sql, username, int(num))
    elif action == "servers":
        for ip in get_server_ips():
            print ip


if __name__ == "__main__":
    main()
