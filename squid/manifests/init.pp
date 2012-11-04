class squid {
        file {
        "/etc/squid/squid.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["squid"],
         source  => "puppet:///modules/squid/squid.conf-$hostname";
             }

        package {
	"squid":
         ensure => "installed";
	        }
      
        service {
        "squid":
         require => Package["squid"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true", 
	 ensure => "running",
	 subscribe => File["/etc/squid/squid.conf"] ;
                }
}
