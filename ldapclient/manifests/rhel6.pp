class ldapclient::rhel6 {
        file {
        "/etc/nss_ldap.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["nss-pam-ldapd"],
	 content =>template("ldapclient/nss_ldap.conf.erb");
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
        "/etc/ldap.conf":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
	 content =>template("ldapclient/ldap.conf.erb");
        "/etc/pam_ldap.conf":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
         require => Package["nss-pam-ldapd"],
	 content =>template("ldapclient/pam_ldap.conf.erb");
        "/etc/nslcd.conf":
         owner  => "root",
         group  => "root",
         mode   =>  "600",
         source  => "puppet:///modules/ldapclient/nslcd.conf";
        "/etc/pam.d/sshd":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
         source  => "puppet:///modules/ldapclient/sshd_rh6";
        "/etc/pam.d/sudo":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/ldapclient/sudo";
	     }

	host {
 	'ldap.local
	 ip => $ldap1,
	 ensure =>"present" ; 
        'ldap.local
         ip => $ldap2,
	 ensure =>"present" ;
	     }

        package {
        "nss-pam-ldapd":
         ensure => "installed";
        "nscd":
         ensure => "installed";
        "sudo":
         ensure => "latest";
		}

        service {
        "nslcd":
         require => Package["nss-pam-ldapd"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true",
         subscribe => [ File["/etc/nslcd.conf"],File["/etc/pam_ldap.conf"]],
	 ensure => "running" ;
        "nscd":
         require => Package["nscd"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true",
         subscribe => [ File["/etc/nscd.conf"],File["/etc/ldap.conf"]],
	 ensure => "running" ;
	       }
}
