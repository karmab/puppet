class spacewalk {
	file {
	"/etc/yum.repos.d/jpackage.repo":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
	 source  => "puppet://puppet/spacewalk/jpackage.repo";
	"/etc/yum.repos.d/spacewalk.repo":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
	 source  => "puppet://puppet/spacewalk/spacewalk.repo";
	"/etc/yum.repos.d/spacewalk-client.repo":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
	 source  => "puppet://puppet/spacewalk/spacewalk-client.repo";
	    }
        package {
	"oracle-lib-compat":
	 require => [ File["/etc/yum.repos.d/spacewalk.repo"],File["/etc/yum.repos.d/spacewalk-client.repo"]],
	 ensure => "installed"; 
	"oracle-instantclient-selinux":
	 require => [ File["/etc/yum.repos.d/spacewalk.repo"],File["/etc/yum.repos.d/spacewalk-client.repo"]],
	 ensure => "installed"; 
	"oracle-instantclient-sqlplus-selinux":
	 require => [ File["/etc/yum.repos.d/spacewalk.repo"],File["/etc/yum.repos.d/spacewalk-client.repo"]],
	 ensure => "installed"; 
	"spacewalk-oracle":
	 ensure => "installed"; 
	        }
}
