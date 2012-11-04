class httpd::phpmyadmin inherits httpd {
	file {
	"/var/www/html/phpmyadmin":
	 ensure =>"link",
	 target =>"/var/www/html/phpMyAdmin-$phpmyadmin-all-languages";
	"/var/www/html/phpMyAdmin-$phpmyadmin-all-languages":
	 ensure => "directory",
	 recurse => "true",
	 owner => "apache",
	 group => "apache";
        "/var/www/html/phpmyadmin/config.inc.php":
         owner => "apache",
         group => "apache",
         mode => "600",
         source  => "puppet:///modules/httpd/config.inc.php";
	     }
	package {
	"phpmyadmin":
	 ensure => "$phpmyadmin-0";
        "php-mysql":
         ensure => "installed";
        "php-gd":
         ensure => "installed";
	         }
}
