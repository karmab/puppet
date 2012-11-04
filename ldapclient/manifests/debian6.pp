class ldapclient::debian6 {
        file {
        "/etc/ldap.conf":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         require => Package["libnss-ldap"],
	 content =>template("ldapclient/ldap.conf.erb");
        "/etc/ldap/ldap.conf":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         require => Package["libnss-ldap"],
	 content =>template("ldapclient/ldap.conf.erb");
	"/etc/libnss-ldap.conf":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         require => Package["libnss-ldap"],
	 content =>template("ldapclient/ldap.conf.erb");
        "/etc/nsswitch.conf":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         source  => "puppet://puppet/ldapclient/nsswitch.conf_debian6";
        "/etc/nscd.conf":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         source  => "puppet://puppet/ldapclient/nscd.conf_debian6";
        "/etc/pam_ldap.conf":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         require => Package["libnss-ldap"],
	 content =>template("ldapclient/ldap.conf.erb");
        "/etc/sudo-ldap.conf":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         require => Package["libnss-ldap"],
	 content =>template("ldapclient/ldap.conf.erb");
	"/etc/ldapca.pem":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         source  => "puppet://puppet/ldapclient/ldapca.pem";
        "/etc/pam.d/common-account":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         source  => "puppet://puppet/ldapclient/common-account";
        "/etc/pam.d/common-auth":
         owner   => "root",
         group   => "root",
         mode    =>  644,
         source  => "puppet://puppet/ldapclient/common-auth";
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
	 ensure => "installed";
	        }
      
        service {
        "nscd":
         require    => Package["nscd"],
         enable     => "true" ,
         hasrestart => "true",
         hasstatus  => "true",
         subscribe  => [ File["/etc/nscd.conf"],File["/etc/ldap.conf"],File["/etc/libnss-ldap.conf"] , File["/etc/pam_ldap.conf"],File["/etc/sudo-ldap.conf"]],
	 ensure     => "running" ;
                }
        
}
