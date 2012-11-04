class iptables {

	exec {
	"iptables-restart-on-file-changed":
	 command => "/sbin/service iptables restart",
 	 refreshonly => 'true',
  	 subscribe => file["/etc/sysconfig/iptables"];
      	     }

        file {
        "/etc/sysconfig/iptables":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["iptables"],
         content => template("iptables/iptables.erb");
             }

        package {
        "iptables":
         ensure => "installed";
	        }
      
        service {
        "iptables":
         require => Package["iptables"],
         enable => "true" ,
	 ensure => "running" ;
                }
}
