class httpd::php inherits httpd {
	file {
	'/etc/php.ini':
    ensure =>'present',
    source => "puppet:///modules/httpd/php.ini-$hostname";
	     }
}
