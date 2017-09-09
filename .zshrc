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

source ~/local/self/dotfiles/.exports
export GOROOT=/usr/local/Cellar/go/1.3/libexec
export BTRACE_HOME=/usr/local/btrace
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export NODE_PATH=/usr/local/lib/node_modules
export PATH=$HOME/bin:$BTRACE_HOME/bin:$PATH:/usr/texbin
alias yash='sudo ~/local/self/yash/yash.py'
# The function
export PATH="$HOME/sofa:$PATH"
export SOFA_HOME="$HOME/sofa"

export PATH="$HOME/AliDrive/software/sofa:$PATH"
fpath=($HOME/AliDrive/software/sofa/resources/completion $fpath)
autoload -U compinit && compinit -u
export OPS_HOME=$HOME/ops
export PATH=$HOME/ops:$PATH
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

# The next line updates PATH for the Google Cloud SDK.
source '/Users/xumingmingv/local/alipay/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/xumingmingv/local/alipay/google-cloud-sdk/completion.zsh.inc'
export PATH="/Users/xumingmingv/sofa:$PATH"
fpath=(/Users/xumingmingv/sofa/resources/completion $fpath)
autoload -U compinit && compinit -u
