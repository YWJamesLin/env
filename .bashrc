source /etc/profile

# Prompting

#   Set which to show
mod_time="1"

#   Colored ASCII Escape Character Array
for color in {0..255}; do
  FG[${color}]="\[[38;5;${color}m\]"
done

#   Other Variables
bold="\[\e[1m\]"
reset="\[\e[0m\]"
date="\D{%Y年%m月%d日　星期%a　%H:%M}"

#   Prompting
function promptGen () {
  EXIT="$?"

  PS1="${FG[12]}${bold}[${reset} ${FG[10]}\u${reset} @ ${FG[14]}\h${reset} ${FG[12]}${bold}]${reset} ${FG[15]}-${reset} ${FG[12]}${bold}[${reset} ${FG[15]}\w${reset} ${FG[12]}${bold}]${reset}"

  if [ "${mod_time}" == "1" ]; then
    PS1="$PS1 ${FG[15]}-${reset} ${FG[12]}${bold}[${reset} ${FG[11]}${date}${reset} ${FG[12]}${bold}]${reset}"
  fi

  PS1="$PS1\n"

  if [ "$EXIT" == "0" ]; then
    PS1="$PS1${FG[14]}^_^${reset} ${FG[10]}"
  else
    PS1="$PS1${FG[13]}Q_Q${reset} ${FG[9]}"
  fi

  if [ "$USER" == "root" ]; then
    PS1="$PS1#${reset} "
  else
    PS1="$PS1\$${reset} "
  fi
}

export PROMPT_COMMAND="promptGen"

# Environment Variables

#   System
export LC_ALL="zh_TW.UTF-8"

# Aliases

#   Commands
alias ll="ls -l"
alias dir="ls -ba"
alias l="ls -al"
alias ss="ps -aux"
alias dot="ls .[a-zA-Z0-011_]*"
alias news="xterm -g 80x45 -e trn -e -S1 -N &"
alias c="clear"
alias m="more"
alias j="jobs"
alias pwd="pwd -P"
alias rmdir="rmdir -p"
alias cp="cp -ai"
alias rm="rm -ri"
alias mv="mv -i"
alias grep="grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn}"
alias egrep="egrep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn}"
alias less="less -r"

#   Common Misspellings
alias mroe="more"
alias pdw="pwd"
