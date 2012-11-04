class customisation::solaris {
    exec {
    "setcorrectpath":
     command => "/bin/echo 'PATH=\$PATH:/usr/local/sudo/bin:/opt/csw/bin:/opt/csw/sbin && export PATH'>>/etc/profile",
     unless => '/usr/xpg4/bin/grep -q sudo /etc/profile';
    "setfunnyprompt":
     command => '/bin/echo "[ \"\$0\" = \"-bash\" ] && [ \"\$(/usr/xpg4/bin/id -u)\" -ge 8000 ] && PS1=\'\[\e[0;32m\][\u@\H \W]\$ \[\e[m\]\' && export PS1" >> /etc/profile',
     unless => '/usr/xpg4/bin/grep -q PS1 /etc/profile';
	 }
    file {
    "/root/.bashrc":
     ensure => "present",
     owner => "root",
     mode => "644",
     content => "export PS1='\[\e[0;31m\][\u@\H \W]#\[\e[m\]';export EDITOR=vi";
    "/usr/bin/sudo":
     ensure => "link",
     target => "/usr/local/sudo/bin/sudo";
             }                  
}
