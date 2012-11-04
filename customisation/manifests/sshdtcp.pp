class customisation::sshdtcp    {	
	case $operatingsystem {
	"Solaris": { $sshdservice = "ssh" }
	default:   { $sshdservice = "ssh" }
	}
	augeas{ 
	"sshtcp":
	 context => "/files/etc/ssh/sshd_config",
	 changes => [
		"set AllowTcpForwarding $sshdtcp"
	],
	 notify => Service["sshd"]
	      }
    service { 
	"$sshdservice":
	 ensure => "true",
	 enable => "true", 
	 hasstatus => "true" ,
	 hasrestart => "true";
	        }
}

