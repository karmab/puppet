##############################################################################
# customisation configuration file
##############################################################################
# NOTE: This file is automatically generated by puppet
# Changes to this file will be overwritten periodically by puppet!
##############################################################################

if [ "`id -u`" -eq 0 ]; then
export PS1='\[\e[0;31m\][\u@\H \W]# \[\e[m\]'
export HISTTIMEFORMAT='[%F %R] '
alias puppetd='puppetd --logdest=/var/log/puppet.log'
fi
if [ "`id -u`" -ge 8000 ]; then
export EDITOR=vim
export PS1='\[\e[0;32m\][\u@\H \W]$ \[\e[m\]'
export HISTTIMEFORMAT='[%F %R] '
export PATH=/sbin:$PATH
alias vi='vim'
fi