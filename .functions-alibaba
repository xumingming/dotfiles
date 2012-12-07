elog() {
    emacs ~/output/`appname`/logs/sys/webx/webx.log
}

tlog() {
    tail -f ~/output/`appname`/logs/sys/webx/webx.log
}

appname() {
    curpath=`pwd`
    curname=`basename $curpath | sed 's/_.*$//g'`
    echo $curname
}

jmvn () {
    echo "app name is `appname`"
    mvn clean install -DuserProp=../antx_`appname`.properties -Dmaven.test.skip=true -DskipValidation=true
}

jmvno() {
    echo "app name is `appname`"
    mvn clean install -DuserProp=../antx_`appname`.properties -Dmaven.test.skip=true -DskipValidation=true -o
}

jrun() {
    ./deploy/target/web-deploy/bin/jettyctl.sh run
}

jrun_center() {
    ./deploy/target/web-deploy/bin/start-service.sh
}

jrun_tc() {
    ./tradecenter.deploy/target/web-deploy/bin/start-service.sh
}

jstart() {
    jmvn `appname` && jrun
}

jstart_center() {
    jmvn `appname` && jrun_center
}

jstart_tc() {
    jmvn `appname` && jrun_tc
}

hosts() {
    hostsdir=~/.hosts

    if [ -z $1 ]; then
	echo "hosts [ls|edit|hostsname]";
    else
        case $1 in
            ls)
               /bin/ls $hostsdir;;
            edit)
               emacs $hostsdir/$2
               hosts $2;;
            cat)
               cat $hostsdir/$2;;
            *)
               cp $hostsdir/$1 /etc/hosts
               # show the first two lines of the
               # the hosts -- to check everything is right
               head -n 2 /etc/hosts;;
        esac
    fi
}

ssh_to_main() {
    ssh james@$MAIN_HOST
}
alias stm=ssh_to_main

gen_antx() {
    echo "app name is $appname"
    appname="`appname`"
    fullpath=`pwd`
    dir=`dirname $fullpath`
    echo "Generating antx file to $dir/antx_$appname.properties"
    cat ~/.antx/antx_$appname.properties | sed "s/USER_NAME/$LOGNAME/g;s@USER_HOME@$HOME@g;s@PROJECT_HOME@`pwd`@g" > $dir/antx_$appname.properties
}

get_newest_branch_name() {
    appname=$1
    crid=$2
    svn ls http://svn.alibaba-inc.com/repos/ali_china/olps/${appname}/branches/ | grep _${crid}_ | tail -n 1
}

get_newest_branch_path() {
    appname=$1
    crid=$2
    branch_name=`get_newest_branch_name $appname $crid`
    echo http://svn.alibaba-inc.com/repos/ali_china/olps/${appname}/branches/${branch_name}
}

get_branch_idx() {
    branch_name=$1
    branch_idx=`echo $branch_name | cut -d "_" -f3 | sed 's@/@@'`
    echo $branch_idx
}

checkout_newest_code() {
    appname=$1
    crid=`get_crid`
    branch_path=`get_newest_branch_path $appname $crid`
    branch_name=`get_newest_branch_name $appname $crid`
    branch_idx=`get_branch_idx $branch_name`
    local_branch_name=${appname}_${branch_idx}
    echo "Checking out code from: " $branch_path " to " $local_branch_name
    svn co $branch_path $local_branch_name
}

# Init the project information, currently mainly the crid
init_project() {
    crid=$1
    echo $crid > .crid
}

get_crid() {
    cat .crid
}

