class multipath {
  	exec {
	"multipathd-restart-on-file-changed":
	 command => "/sbin/service multipathd restart",
	 refreshonly => 'true',
	 require => Package["device-mapper-multipath"],
  	 subscribe => file["/etc/multipath.conf"] ; 
	     }

        file {
        "/etc/multipath.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["device-mapper-multipath"],
         source  => "puppet:///modules/multipath/multipath.conf-$hostname";
             }

        package {
        "device-mapper-multipath":
         ensure => "installed";
	        }

        service {
        "multipathd":
        enable => "true",
        ensure => "running" ;
        }

}
