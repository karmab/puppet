class spacewalk::oracle-xe {
#	exec {
#	"oracle_sysctl_requirements":
#	 command => "/bin/echo \#Parametros agregados para oracle >>/etc/sysctl.conf ; /bin/echo kernel.sem = 250     32000   100      128 >>/etc/sysctl.conf ; /bin/echo fs.file-max= 6815744 >>/etc/sysctl.conf ; /bin/echo net.ipv4.ip_local_port_range = 9000 65500 >>/etc/sysctl.conf ; /bin/echo net.core.rmem_default = 262144 >>/etc/sysctl.conf ; /bin/echo net.core.rmem_max = 4194304 >>/etc/sysctl.conf ; /bin/echo net.core.wmem_default = 262144 >>/etc/sysctl.conf ; /bin/echo net.core.wmem_max = 1048576 >>/etc/sysctl.conf ; /bin/echo fs.aio-max-nr = 1048576 >>/etc/sysctl.conf ; /sbin/sysctl -p ",
#	unless => "/bin/grep -iq 'oracle' /etc/sysctl.conf";
#	"oracle_limits_requirements":
#	command => "/bin/echo \#Parametros agregados para oracle >> /etc/security/limits.conf ; /bin/echo oracle soft nproc 2047 >> /etc/security/limits.conf ; /bin/echo oracle hard nproc 16384 >> /etc/security/limits.conf ; /bin/echo oracle soft nofile 1024 >> /etc/security/limits.conf ; /bin/echo oracle hard nofile 65536 >> /etc/security/limits.conf ; /bin/echo oracle soft stack 10240 >> /etc/security/limits.conf",	    
#	unless => "/bin/grep -iq  oracle /etc/security/limits.conf";
#	     }
        file { 
	"/home/oracle":
	 ensure =>"directory",
	 owner =>"oracle",
	 group => "dba";
	"/home/oracle/.bashrc":
	 ensure =>"present",
	 owner =>"oracle",
	 group => "dba",
	 require => File["/home/oracle"],
	 source  => "puppet://puppet/spacewalk/bashrc_oracle";

             }
	group {
        "dba":
         ensure => "present";
	     }
        package {
        "bc":
         ensure => "installed";
        "compat-libstdc++-33":
         ensure => "installed";
        "elfutils-libelf-devel":
         ensure => "installed";
        "gcc":
         ensure => "installed";
	"gcc-c++":
	 ensure => "installed";
	"glibc-devel":
	 ensure => "installed";
	"glibc-headers":
	 ensure => "installed";
	"libaio":
	 ensure => "installed";
        "libaio-devel":
         ensure => "installed";
	"oracle-xe":
	 ensure => "installed"; 
	"oracle-instantclient11.2-basic":
	 ensure => "installed"; 
	"oracle-instantclient11.2-sqlplus":
	 ensure => "installed"; 
	"unixODBC":
	 ensure => "installed"; 
        "unixODBC-devel":
         ensure => "installed";
	        }
	user {
	"oracle":
	 comment => "Oracle user",
	 gid => "dba",
	 home => "/home/oracle",
	 shell => "/bin/bash";
	     }
      
}
