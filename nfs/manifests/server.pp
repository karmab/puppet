class nfs::server  {
        file {
        "/etc/exports":
         owner  => "root",
         group  => "root",
         mode   => "644",
         require => Package["nfs-utils"],
	 source => "puppet:///modules/nfs/exports-$hostname";
             }

        service {
        "nfs":
         require => Package["nfs-utils"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true", 
	 ensure => "running",
	 subscribe => File["/etc/exports"];
                }
	if !defined(Package['nfs-utils']) {
        package {
        "nfs-utils":
         ensure => "installed";
	}}
	  }

