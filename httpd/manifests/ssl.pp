class httpd::ssl inherits httpd {
  exec {
  'httpd-restart-on-ssl-changed':
    command     => '/sbin/service httpd restart',
    require     => [ Package['httpd'],Package['mod_ssl']],
    refreshonly => true,
    subscribe   => [File['/etc/httpd/conf.d/ssl.conf'], File["/etc/httpd/conf.d/$hostname.pem"],File["/etc/httpd/conf.d/${hostname}k.pem"]] ;
       }

  file {
  '/etc/httpd/conf.d/ssl.conf':
    owner   => 'root',
    group   => 'root',
    mode    =>  0664,
    content => template('httpd/ssl.conf.erb') ;
  "/etc/httpd/conf.d/$hostname.pem":
    owner   => 'root',
    group   => 'root',
    mode    =>  0664,
    source  => "puppet:///modules/httpd/$hostname.pem";
  "/etc/httpd/conf.d/${hostname}k.pem":
    owner   => 'root',
    group   => 'root',
    mode    =>  0664,
    source  => "puppet:///modules/httpd/${hostname}k.pem";
  "/etc/httpd/conf.d/$ca.pem":
    owner   => 'root',
    group   => 'root',
    mode    =>  0664,
    source  => "puppet:///modules/httpd/$ca.pem";
            }

  package {
  'mod_ssl':
    ensure => 'installed';
          }
}
