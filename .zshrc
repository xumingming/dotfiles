# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#ZSH_THEME="frisk"
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

#source ~/local/self/dotfiles/.functions
source ~/local/self/dotfiles/.exports
#export CLOUDENGINE_HOME=/usr/local/cloudengine
export GOROOT=/usr/local/Cellar/go/1.3/libexec
export BTRACE_HOME=/usr/local/btrace
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export KIBOU_HOME=/Users/xumingmingv/local/alipay/kibou
export NODE_PATH=/usr/local/lib/node_modules
export PATH=$HADOOP_HOME/bin/:/Users/xumingmingv/Desktop/ssh/:/Users/xumingmingv/bin:$BTRACE_HOME/bin:$KIBOU_HOME/bin:$KIBOU_HOME/bin/sofa:$PATH

#export PROMPT="%{$fg[blue]%}%/%{$reset_color%} $(git_prompt_info)$(bzr_prompt_info)%{$fg[white]%}%{$reset_color%} %{$fg[white]%}
#%{$reset_color%}%{$fg_bold[black]%}>%{$reset_color%}"
alias scheduler='/Users/xumingmingv/local/self/pyscheduler/scheduler.py -s'
alias dms='/usr/bin/python /Users/xumingmingv/local/alipay/dms/dms-tools/dms.py'
alias yash='sudo ~/local/self/yash/yash.py'
alias yashpub='~/markdown/scripts/yashpub.sh ~/local/alipay/dpc $1'
# The function
cd() {
	builtin cd $@
	if [ "$?" = "0" ]; then
        if [[ $PWD == /Users/xumingmingv/local/alipay/* ]] ; then
            if [ -n .git ]; then
				echo "alipay"
				git config --local user.name "护城"
				git config --local user.email "mingming.xumm@alibaba-inc.com"
            fi
        fi
        
        if [[ $PWD == /Users/xumingmingv/local/self/* ]] ; then
			echo "self"
        fi

		echo "Git UserName: $(git config --get user.name)"
		echo "Git Email: $(git config --get user.email)"				
	fi
}
export PATH="/Users/xumingmingv/sofa:$PATH"
export SOFA_HOME="/Users/xumingmingv/sofa"

export CONFOPS_HOME=/Users/xumingmingv/local/alipay/confops
export PATH=$CONFOPS_HOME:$PATH

export PATH="/Users/xumingmingv/AliDrive/software/sofa:$PATH"
fpath=(/Users/xumingmingv/AliDrive/software/sofa/resources/completion $fpath)
autoload -U compinit && compinit -u
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export PATH=/usr/local/bin:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
export OPS_HOME=/Users/xumingmingv/ops
export PATH=/Users/xumingmingv/ops:$PATH
