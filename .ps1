# Display ps1 with colorful pwd and git status
# Acording to Jimmyxu .bashrc
# Modified by Ranmocy
# --
alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"

if type -P tput &>/dev/null && tput setaf 1 &>/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

function __repo () {
    branch=$(type __git_ps1 &>/dev/null && __git_ps1 | sed -e "s/^(//" -e "s/)$//")
    if [ "$branch" != "" ]; then
        vcs=git
    else
        branch=$(type -P hg &>/dev/null && hg branch 2>/dev/null)
        if [ "$branch" != "" ]; then
            vcs=hg
        elif [ -e .bzr ]; then
            vcs=bzr
        elif [ -e .svn ]; then
            vcs=svn
        else
            vcs=
        fi
    fi
    if [ "$vcs" != "" ]; then
        if [ "$branch" != "" ]; then
            repo=$vcs:$branch
        else
            repo=$vcs
        fi
        echo -n "($repo)"
    fi
    return 0
}

if [ "$color_prompt" = yes ]; then
#    PS1='\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[33;40m\]$(__repo)\[\e[00m\]\$ '
    PS1='\[\e[01;32m\]\u\[\e[00m\]:\[\e[01;34m\]\W\[\e[33m\]$(__repo)\[\e[00m\]\$ '
else
    PS1='\u@\h:\w$(__repo)\$ '
fi
unset color_prompt

case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;\W\a\]$PS1"
  ;;
*)
  ;;
esac
