class ldapclient::rhel {
        file {
        "/etc/ldap.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["nss_ldap"],
	 content =>template("ldapclient/ldap.conf.erb");
        "/etc/nsswitch.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/nsswitch.conf";
        "/etc/nscd.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/nscd.conf";
	"/etc/ldapca.pem":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/ldapca.pem";
        "/etc/pam.d/sshd":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/sshd";
        "/etc/pam.d/sudo":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/sudo";
        "/etc/pam.d/system-auth":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/system-auth";
        "/etc/pam.d/system-auth-ac":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/system-auth-ac";
             }


	host {
 	'ldap.local
	 ip => $ldap1 ,
	 ensure =>"present" ; 
        'ldap.local
         ip => $ldap2 ,
	 ensure =>"present" ;
	     }

        package {
        "nss_ldap":
         ensure => "installed";
        "nscd":
         ensure => "installed";
	"sudo":
	 ensure => "latest";
	        }
      
        service {
        "nscd":
         require => Package["nscd"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true",
         subscribe => [ File["/etc/nscd.conf"],File["/etc/ldap.conf"]],
	 ensure => "running" ;
                }
        
}
