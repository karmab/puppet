class ldapclient::sssd {
	file {
        "/etc/sssd/sssd.conf":
         owner  => "root",
         group  => "root",
         mode   => "600",
         source  => "puppet:///modules/ldapclient/sssd.conf";
	"/etc/ldapca.pem":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
         source  => "puppet:///modules/ldapclient/ldapca.pem";
             }

	host {
 	'ldap.local
	 ip =>"$ldap1",
	 ensure =>"present" ; 
        'ldap.local
	 ip =>"$ldap2",
	 ensure =>"present" ;
	     }

        package {
        "libpam-sss":
         ensure => "installed";
        "libnss-sss":
         ensure => "installed";
        "sssd":
         ensure => "installed";
		}

        service {
        "sssd":
         require => Package["sssd"],
         enable => "true" ,
         ensure => "running",
         subscribe => File["/etc/sssd/sssd.conf"];
                }
}
