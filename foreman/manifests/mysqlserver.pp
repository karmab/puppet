class foreman::mysqlserver inherits foreman::mysql {
	package {
	'mysql-server':
    ensure => 'installed';
	        }
  service {
  'mysqld':
    ensure     => 'running',
    enable     => true ,
    hasrestart => true,
    hasstatus  => true;
	        }
}
