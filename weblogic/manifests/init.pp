class weblogic {
	$weblogicpkg=["elfutils-libelf-devel","gcc","gcc-c++","glibc-devel","glibc-devel.i386","sysstat","libaio-devel","libstdc++","libstdc++-devel","compat-libstdc++-296","compat-db","control-center","glibc-common","binutils","make"]
	exec {
	"weblogic_limits_requirements":
	command => "/bin/echo \#Parametros agregados para weblogic >> /etc/security/limits.conf ; /bin/echo was$client soft nofile 4096 >> /etc/security/limits.conf ; /bin/echo was$client hard nofile 4096 >> /etc/security/limits.conf",	    
	unless => "/bin/grep -q  was$client /etc/security/limits.conf";
	     }

        file { 
	"/home/was$client":
	 ensure =>"directory",
	 owner =>"was$client",
	 group => "oracle";
             }
	group {
        "oracle":
         ensure => "present";
	     }
	user {
	"was$client":
	 comment => "weblogic $client user",
	 gid => "oracle",
	 groups => ["oracle"],
	 home => "/home/was$client",
	 shell => "/bin/bash";
	     }

	package {
	$weblogicpkg:
	 ensure => "installed";
	}
}
