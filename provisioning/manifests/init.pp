class provisioning {
	case $lsbmajdistrelease {
	"5": { $provisioningpackages=["cobbler","cobbler-web","dhcp","python-hashlib","syslinux","xinetd"]}
	"6": { $provisioningpackages=["cobbler","cobbler-web","dhcp","syslinux","xinetd"] }
	}
        file {
        "/etc/cobbler/settings":
         owner  => "root",
         group  => "root",
         mode   =>  664,
	 content => template("provisioning/settings.erb") ;
        "/etc/cobbler/dhcp.template":
         owner  => "root",
         group  => "root",
         mode   =>  664,
	 content => template("provisioning/dhcp.template.erb") ;
        "/etc/cobbler/modules.conf":
         owner  => "root",
         group  => "root",
         mode   =>  664,
	 content => template("provisioning/modules.conf.erb") ;
        "/etc/cobbler/users.digest":
         owner  => "root",
         group  => "root",
         mode   =>  664,
         source  => "puppet:///modules/provisioning/users.digest";
        "/etc/xinetd.d/rsync":
         owner  => "root",
         group  => "root",
         mode   =>  664,
         source  => "puppet:///modules/provisioning/rsync";
        "/etc/xinetd.d/tftp":
         owner  => "root",
         group  => "root",
         mode   =>  664,
         source  => "puppet:///modules/provisioning/tftp";
        "/root/scripts":
         owner  => "root",
         group  => "root",
         mode   =>  700,
         recurse => true,
	 ignore => ".svn" ,
         source  => "puppet:///modules/provisioning/scripts";
	     }
        package { $provisioningpackages: ensure => "installed"; }
        if ( $new ) {
	package {
	"mod_python":
         ensure => "absent";
	"mod_wsgi":
         ensure => "installed";
	 }}
        service {
        "cobblerd":
         require => Package["cobbler"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true", 
	 ensure => "running",
	 subscribe => [ File["/etc/cobbler/settings"], File["/etc/cobbler/dhcp.template"], File["/etc/cobbler/users.digest"], File["/etc/xinetd.d/tftp"], File["/etc/xinetd.d/rsync"]];
        "dhcpd":
         require => Package["dhcp"],
         enable => "true" ,
         ensure => "running" ;
	"xinetd":
         enable => "true" ,
         ensure => "running" ;
	 #"httpd":
         #enable => "true" ,
         #ensure => "running" ;
                }
}
