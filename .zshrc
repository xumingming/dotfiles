# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn autojump)

source $ZSH/oh-my-zsh.sh

source ~/local/self/dotfiles/.functions
source ~/local/self/dotfiles/.exports

export HIVE_HOME=/usr/local/hive-alipay
export HIVE_CONF_DIR=/usr/local/hive-alipay-conf
export HADOOP_HOME=/usr/local/hadoop-alipay
export HADOOP_CONF_DIR=/usr/local/hadoop-alipay-conf
export JAVA_HOME=/usr/local/java
export HADOOP_LOG_DIR=/var/hadoop-alipay/logs
export CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH
export HADOOP_HEAPSIZE=64
export HADOOP_NAMENODE_OPTS="-Dcom.sun.management.jmxremote $HADOOP_NAMENODE_OPTS"
export HADOOP_SECONDARYNAMENODE_OPTS="-Dcom.sun.management.jmxremote $HADOOP_SECONDARYNAMENODE_OPTS"
export HADOOP_DATANODE_OPTS="-Dcom.sun.management.jmxremote $HADOOP_DATANODE_OPTS"
export HADOOP_BALANCER_OPTS="-Dcom.sun.management.jmxremote $HADOOP_BALANCER_OPTS"
export HADOOP_JOBTRACKER_OPTS="-Dcom.sun.management.jmxremote $HADOOP_JOBTRACKER_OPTS"
export HADOOP_SSH_OPTS="-o ConnectTimeout=3  -o StrictHostKeyChecking=no -o SendEnv=HADOOP_CONF_DIR"
export CLASSPATH=$HADOOP_CONF_DIR:$ZOOCFGDIR:$CLASSPATH
#export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:./:$ZOOKEEPER_HOME/*:$ZOOKEEPER_HOME/lib/*:$HBASE_HOME/lib/*:$HBASE_HOME/*:$HBASE_CONF_DIR
export PATH=$HADOOP_HOME/bin/:$PATH
