class httpd {
    file {
    "/etc/httpd/conf.d/welcome.conf":	
     ensure => "absent";
     "/var/www/html":	
     require => Package["httpd"],
     owner => "apache",
     group => "apache",
     mode  => "660";
	}
    package {
    "httpd":
     ensure => "installed";
    "php":	 
     ensure => "installed";
	    }
    service {
    "httpd":
     require => Package["httpd"],
     enable => "true" ,
     ensure => "running" ;
            }
    define createwebusers {
    user {
    "$name":
     comment => "Web User $name",
     gid   => "apache",
     home => "/var/www/html",
     require => Package["httpd"];
             }
			      }
    if ($webusers ) { createwebusers{ $webusers: }
                        }
}
