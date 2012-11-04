class vsftpd::chroot {
        file {
        "/etc/vsftpd/vsftpd.conf":
         owner  => "root",
         group  => "root",
         mode   =>  600,
         require => Package["vsftpd"],
         source  => "puppet:///modules/vsftpd/vsftpd.conf-$hostname";
             }
	
        file {
        "/etc/vsftpd/ftpusers":
         owner  => "root",
         group  => "root",
         mode   =>  600,
         require => Package["vsftpd"],
         source  => "puppet:///modules/vsftpd/ftpusers-$hostname";
             }

        file {
        "/etc/vsftpd/user_list":
         owner  => "root",
         group  => "root",
         mode   =>  600,
         require => Package["vsftpd"],
         source  => "puppet:///modules/vsftpd/user_list-$hostname";
             }

        file {
        "/etc/vsftpd/vsftpd.chroot_list":
         owner  => "root",
         group  => "root",
         mode   =>  600,
         require => Package["vsftpd"],
         source  => "puppet:///modules/vsftpd/vsftpd.chroot_list-$hostname";
             }

        file {
        "/etc/vsftpd/vsftpd.pem":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["vsftpd"],
         source  => "puppet:///modules/vsftpd/vsftpd.conf-$hostname";
             }


        package {
	"vsftpd":
         ensure => "installed";
	        }
      
        service {
        "vsftpd":
         require => Package["vsftpd"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true", 
	 ensure => "running",
	 subscribe => File["/etc/vsftpd/vsftpd.conf","/etc/vsftpd/vsftpd.pem","/etc/vsftpd/ftpusers","/etc/vsftpd/user_list","/etc/vsftpd/vsftpd.chroot_list"] ;
                }
}
