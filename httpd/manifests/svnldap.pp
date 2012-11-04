class httpd::svnldap {
        exec {
        "httpd-restart-on-svn-changed":
         command => "/sbin/service httpd restart",
         require =>  [ Package["mod_dav_svn"],Package["mod_authz_ldap"]],
         refreshonly => 'true',
         subscribe => File["/etc/httpd/conf.d/svn.conf"] ;
            }

        file {
        "/etc/httpd/conf.d/svn.conf":
         owner  => "root",
         group  => "root",
         mode   =>  664,
	 #content => template("httpd/svn.conf.erb") ;
	 source  => "puppet:///modules/httpd/svn.conf-$hostname";
        "/var/www/html/svn":
         recurse => "true",
         require => Package["mod_dav_svn"],
         owner => "apache";
        "/var/www/html/svn/svn.authz":
         owner  => "root",
         group  => "root",
         mode   =>  664,
         source  => "puppet:///modules/httpd/svnauthz-$hostname";
            }
        package {
        "mod_dav_svn":
         ensure => "installed";
	    "mod_authz_ldap":
         ensure => "installed";
                }
}
