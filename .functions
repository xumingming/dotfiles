
femacs() {
    filename=`find . -name $1`
    emacs $filename
}

switch-m2-settings() {
  cp ~/local/svn/dotfiles/.m2settings/settings-$1.xml ~/.m2/settings.xml
}

jkill() {
  jps -v | grep $1 | awk '{print $1}' | xargs kill -9
}

. ~/local/svn/dotfiles/.functions-storm.sh
. ~/local/svn/dotfiles/.functions-alibaba.sh