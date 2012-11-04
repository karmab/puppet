class oracle::php {
	$oraclephppackages = ["oci8","oracle-instantclient11.2-basic","oracle-instantclient11.2-devel","oracle-instantclient11.2-tools","oracle-instantclient11.2-jdbc","oracle-instantclient11.2-sqlplus","oracle-instantclient11.2-odbc"]
	file {
	"/usr/lib/oracle/11.2/client64/network":
         owner  => "root",
	 ensure => "directory",
	 require => Package[$oraclephppackages];
#	"/usr/lib/oracle/11.2/client64/network/tnsnames.ora":
#         owner  => "root",
#         group  => "root",
#         mode   =>  644,
#	 require => [File["/usr/lib/oracle/11.2/client64/network"],Package["oracle-instantclient11.2-basic"]],
#    	 content => template("oracle/tnsnames.ora.erb");
	     }
	package {
	$oraclephppackages:
	 ensure => "installed";
	}
}
