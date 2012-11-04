class ohs {
	exec {
	"ohs_limits_requirements":
	command => "/bin/echo \#Parametros agregados para ohs >> /etc/security/limits.conf ; /bin/echo oracle soft nofile 4096 >> /etc/security/limits.conf ; /bin/echo oracle hard nofile 4096 >> /etc/security/limits.conf",	    
	unless => "/bin/grep -q  ohs /etc/security/limits.conf";
	     }

        file { 
	"/home/oracle":
	 ensure =>"directory",
	 owner =>"oracle",
	 group => "oracle";
             }
	group {
        "oracle":
         ensure => "present";
	     }
	user {
	"oracle":
	 comment => "OHS user",
	 gid => "oracle",
	 groups => ["oracle"],
	 home => "/home/oracle",
	 shell => "/bin/bash";
	     }

	package {
	"elfutils-libelf-devel":
	ensure => "installed";
	"glibc-devel.i386":
        ensure => "installed";
	"gcc":
	ensure => "installed";
	"gcc-c++":
	ensure => "installed";
	"sysstat":
	ensure => "installed";
	"libaio":
	ensure => "installed";
	"libaio-devel":
	ensure => "installed";
	"libstdc++":
	ensure => "installed";
	"libstdc++-devel":
	ensure => "installed";
	"compat-libstdc++-296":
	ensure => "installed";
	"compat-db":
	ensure => "installed";
	"control-center":
	ensure => "installed";
	"glibc-common":
	ensure => "installed";
	"binutils":
	ensure => "installed";
	"make":
	ensure => "installed";
	}
}
