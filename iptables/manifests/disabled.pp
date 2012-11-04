class iptables::disabled {
        service {
        "iptables":
         enable => "false" ,
	 ensure => "stopped" ;
                }
}
