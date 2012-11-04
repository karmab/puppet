class vsftpd {
        file {
        "/etc/vsftpd/vsftpd.conf":
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
	 subscribe => File["/etc/vsftpd/vsftpd.conf"] ;
                }
}
