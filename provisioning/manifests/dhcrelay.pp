class provisioning::dhcrelay {
        exec {
        "dhcrelay-restart-on-file-changed":
         command => "/sbin/service dhcrelay restart",
         require => Package["dhcp"],
         refreshonly => 'true',
         subscribe => file["/etc/sysconfig/dhcrelay"] ;
            }

        file {
        "/etc/sysconfig/dhcrelay":
         owner  => "root",
         group  => "root",
         mode   =>  664,
         source  => "puppet:///modules/provisioning/dhcrelay-$hostname";
            }

        package {
        "dhcp":
         ensure => "installed";
                }

        service {
        "dhcrelay":
         require => Package["dhcp"],
         enable => "true" ,
         ensure => "running" ;
                }
}
