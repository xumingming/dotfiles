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

