#!/bin/bash

if [ "$TERM" != "dumb" ]; then
    if [ -f /usr/bin/keychain ]; then
        keychain --nogui id_rsa id_dsa
        . ~/.keychain/$HOSTNAME-sh
    fi
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Load RVM, if you are using it
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# Set Lang to UTF-8
export LANG='en_US.UTF-8'

# Set our autoproxy url
export auto_proxy='http://wwwqds.qg.com/qdsproxy.pac'

# Set initial path
export PATH=$HOME/bin:$HOME/apps/firefox:$PATH

# Path to the bash it configuration
export BASH=$HOME/.bash_it

# Lock and Load a custom theme file
# location /.bash_it/themes/
#export BASH_THEME='standard'
#export BASH_THEME='zitron'
#export BASH_THEME='n0qorg'
#export BASH_THEME='bobby'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='jbrekke@qdsscm.qg.com'
export GIT_SSL_NO_VERIFY=true 

# Set my editor and git editor
export EDITOR="emacs -nw"
export GIT_EDITOR='emacs -nw'

# Set the path nginx
export NGINX_PATH='/opt/nginx'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to the path of your local jekyll root to use the jekyll aliases

export JEKYLL_LOCAL_ROOT="$HOME/Sites/jekyllsite"

# And change this to the remote server and root

export JEKYLL_REMOTE_ROOT="user@server:/path/to/jekyll/root"

# And, for the last of the jekyll variables, this is the formatting you use, eg: markdown,
# textile, etc. Basically whatever you use as the extension for posts, without the preceding dot

export JEKYLL_FORMATTING="markdown"

# Change this to your console based IRC client of choice.

export IRC_CLIENT='BitchX -ssl -p 6695'

# Set this to the command you use for todo.txt-cli

export TODO="t"

# Set store directory for handmade commandline history tool 
export hchtstoredir="$HOME/.hcht"

# Load Bash It
source $BASH/bash_it.sh

# .bash_profile

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
