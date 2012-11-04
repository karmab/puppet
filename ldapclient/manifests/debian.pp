class ldapclient::debian {
        file {
        "/etc/ldap.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["libnss-ldap"],
	 content =>template("ldapclient/ldap.conf.erb");
        "/etc/ldap/ldap.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["libnss-ldap"],
	 content =>template("ldapclient/ldap.conf.erb");
        "/etc/pam_ldap.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["libpam-ldap"],
	 content =>template("ldapclient/pam_ldap.conf.erb");
        "/etc/nsswitch.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/nsswitch.conf_debian";
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
        "/etc/pam.d/common-account":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/common-account";
        "/etc/pam.d/common-auth":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/common-auth";
        "/etc/pam.d/common-password":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet://puppet/ldapclient/common-password";
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
        "libnss-ldap":
	 ensure => "installed";
        "libpam-ldap":
	 ensure => "installed";
        "nscd":
	 ensure => "installed";
	"sudo-ldap":
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
