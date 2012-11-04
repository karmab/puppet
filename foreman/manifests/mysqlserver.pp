class foreman::mysqlserver inherits foreman::mysql {
	package {
	"mysql-server":
	 ensure => "installed";
	}
    service {
    "mysqld":
     enable => "true" ,
     hasrestart => "true",
     hasstatus => "true",
	 ensure => "running" ;
	}
}