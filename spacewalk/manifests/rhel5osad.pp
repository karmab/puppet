#Class spacewalk::rhel5osad
class spacewalk::rhel5osad inherits spacewalk::rhel5client {
	file {
	"/etc/sysconfig/rhn/osad.conf":
         ensure => "present";
	"/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/spacewalk/spacewalk.crt"
	     }
        package {
	"osad":
	 ensure => "installed"; 
	"python-hashlib":
	 ensure => "installed"; 
	        }
        service {
        "osad":
         require => [ Package["osad"], Package["python-hashlib"] ],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true",
         subscribe => [ File["/etc/sysconfig/rhn/osad.conf"],File["/usr/share/rhn/RHN-ORG-TRUSTED-SSL-CERT"]],
	 ensure => "running" ;
                }

}
