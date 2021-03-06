class foreman::mysql {
    file {	
    '/etc/cron.d/foreman':
      owner   => 'root',
      group   => 'root',
      mode    =>  0644,
      source  => 'puppet://puppet/foreman/foreman_cron';
    '/etc/cron.d/puppetmaster':
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      source  => 'puppet://puppet/foreman/puppetmaster_cron';
    '/etc/yum.repos.d/foreman.repo':
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      content => template('foreman/foreman.repo.erb');
    '/etc/foreman/database.yml':
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      source  => 'puppet://puppet/foreman/database.yml_mysql';
    '/usr/lib/ruby/site_ruby/1.8/puppet/reports/foreman.rb':
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      content => template('foreman/foreman.rb.erb');
    	     }
    package {
    'foreman':
      require => File['/etc/yum.repos.d/foreman.repo'],
      ensure  => 'installed';
    ['mysql','mysql-devel','ruby-mysql','rubygem-activerecord']:
      ensure  => 'installed';
	          }
    service {
    'foreman':
      ensure     => 'running',
      enable     => true ,
      hasrestart => true,
      hasstatus  => true;
	}
}
