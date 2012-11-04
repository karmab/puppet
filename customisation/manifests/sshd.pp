class customisation:sshd {
	augeas{ 
	"ssh":
	 context => "/files/etc/ssh/sshd_config",
	 changes => [
		"set UseDns no"
	],
	 notify => Service["sshd"]
	      }
    service { 
	"sshd":
	 ensure => "true",
	 enable => "true", 
	 hasstatus => "true" ,
	 hasrestart => "true";
	        }
}