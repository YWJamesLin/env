if [ -z "$PS1" ]; then
	return
fi

# Environment Variables

# 	System
PS1='\[\e[1;34m\][\[\e[1;32m\] \u \[\e[2;37m\]@\[\e[1;36m\] \h \[\e[1;34m\]]\[\e[1;37m\] - \[\e[1;34m\][\[\e[1;37m\] \w \[\e[1;34m\]]\[\e[1;37m\] - \[\e[1;34m\][\[\e[1;33m\] \D{%Y年%m月%d日 週%a %H:%M} \[\e[1;34m\]]\n\[\e[1;34m\][\[\e[1;35m\] \$ \[\e[1;34m\]]\[\e[0;37m\]'
LC_ALL="zh_TW.UTF-8"
export PS1 LC_ALL

# bogus
if [ -f /unix ] ; then	
	alias ls='/bin/ls -CF --color=always'
else
	alias ls='/bin/ls -F --color=always'
fi

# Aliases

# 	System
alias ll='ls -l'
alias dir='ls -ba'
alias l='ls -al'

alias ss="ps -aux"
alias dot='ls .[a-zA-Z0-9_]*'
alias news="xterm -g 80x45 -e trn -e -S1 -N &"

alias c="clear"
alias m="more"
alias j="jobs"

alias poweroff="sync;sync;poweroff"
alias reboot="sync;sync;reboot"
alias grep="grep --color=always"
alias less="less -r"

# common misspellings
alias mroe=more
alias pdw=pwd

hash -p /usr/bin/mail mail

if [ -z "$HOST" ] ; then
	export HOST=${HOSTNAME}
fi

HISTIGNORE="[   ]*:&:bg:fg"

psgrep()
{
	ps -aux | grep $1 | grep -v grep
}

#
# This is a little like `zap' from Kernighan and Pike
#

pskill()
{
	local pid

	pid=$(ps -ax | grep $1 | grep -v grep | awk '{ print $1 }')
	echo -n "killing $1 (process $pid)..."
	kill -9 $pid
	echo "slaughtered."
}

term()
{
        TERM=$1
	export TERM
	tset
}

xtitle () 
{ 
	echo -n -e "\033]0;$*\007"
}

cd()
{
	builtin cd "$@" && xtitle $HOST: $PWD
}

bold()
{
	tput smso
}

unbold()
{
	tput rmso
}

if [ -f /unix ] ; then
clear()
{
	tput clear
}
fi

rot13()
{
	if [ $# = 0 ] ; then
		tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]"
	else
		tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" < $1
	fi
}

watch()
{
        if [ $# -ne 1 ] ; then
                tail -f nohup.out
        else
                tail -f $1
        fi
}

#
#       Remote login passing all 8 bits (so meta key will work)
#
rl()
{
        rlogin $* -8
}

function setenv()
{
	if [ $# -ne 2 ] ; then
		echo "setenv: Too few arguments"
	else
		export $1="$2"
	fi
}

function chmog()
{
	if [ $# -ne 4 ] ; then
		echo "usage: chmog mode owner group file"
		return 1
	else
		chmod $1 $4
		chown $2 $4
		chgrp $3 $4
	fi
}
