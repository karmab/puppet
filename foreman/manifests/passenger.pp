class foreman::passenger {
  exec {
	'install_passenger_modules':
    command => '/usr/bin/passenger-install-apache2-module -a',
    require => Package['rubygem-passenger'],
    creates  => '/usr/lib/ruby/gems/1.8/gems/passenger-2.2.2/ext/apache2/mod_passenger.so';
       }
  file {	
  '/etc/httpd/conf.d/passenger.conf':
    owner   => 'root',
    group   => 'root',
    mode    =>  0644,
    require => Package['rubygem-passenger'],
    source  => 'puppet://puppet/foreman/passenger.conf';
  '/etc/httpd/conf.d/foreman.conf':
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    source  => "puppet://puppet/foreman/foreman.conf_$fqdn";
       }
	package {
  'rubygem-passenger':
    ensure => 'installed';
          }
}
