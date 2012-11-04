class ldapclient::suse {
        file {
        "/etc/ldap.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => [Package["nss_ldap"],Package["pam_ldap"]],
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
         source  => "puppet://puppet/ldapclient/nscd.conf_suse";
	"/etc/ldapca.pem":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/ldapca.pem";
        "/etc/pam.d/sshd":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/sshd_suse";
        "/etc/pam.d/sudo":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/sudo_suse";
        "/etc/sudoers":
         owner  => "root",
         group  => "root",
         mode   =>  "440";
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
        "pam_ldap":
         ensure => "installed";
	"sudo":
	 ensure => "installed";
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
