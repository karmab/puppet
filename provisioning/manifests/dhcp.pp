class provisioning::dhcp {
        exec {
        "dhcp-restart-on-file-changed":
         command => "/sbin/service dhcpd restart",
         require => Package["dhcp"],
         refreshonly => 'true',
         subscribe => file["/etc/dhcpd.conf"] ;
            }

        file {
        "/etc/dhcpd.conf":
         owner  => "root",
         group  => "root",
         mode   =>  664,
         source  => "puppet:///modules/provisioning/dhcpd.conf-$hostname";
            }

        package {
        "dhcp":
         ensure => "installed";
                }

        service {
        "dhcpd":
         require => Package["dhcp"],
         enable => "true" ,
         ensure => "running" ;
                }
}
