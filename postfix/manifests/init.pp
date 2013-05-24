class postfix {
  exec {
  'installcanonicalmap':
    command => '/usr/sbin/postmap /etc/postfix/canonical',
    require =>  Package['postfix'],
    creates => '/etc/postfix/canonical.db';
  'installgenericmap':
    command => '/usr/sbin/postmap /etc/postfix/generic',
	  require =>  Package['postfix'],
 	  creates => '/etc/postfix/generic.db';
	     }

  file {
  '/etc/postfix/main.cf':
    owner   => 'root',
    group   => 'root',
    mode    =>  0644,
    require => Package['postfix'],
    content => template('postfix/main.cf.erb');
       }

  package {
	'mailx':
    ensure => 'installed';
  'postfix':
    ensure => 'installed';
	        }
      
  service {
  'postfix':
	  ensure     => 'running',
    require    => Package['postfix'],
    enable     => true ,
    hasrestart => true,
    hasstatus  => true, 
    subscribe  => File['/etc/postfix/main.cf];
          }
}
