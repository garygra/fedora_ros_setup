#!/bin/bash
set -e

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cat >> /etc/bashrc <<EOL
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
# colors!
green="\[\033[0;91m\]"
blue="\[\033[38;5;166;1m\]"
purple="\[\033[0;1;36m\]"
reset="\[\033[0m\]"
#Change command prompt
source /usr/share/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="\$purple\\u:\$green\$(__git_ps1)\$blue \\W $ \$reset"
EOL
