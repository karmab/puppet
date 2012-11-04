class spacewalk::rhel5client {
	file {
	"/etc/yum.repos.d/epel.repo":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
	 source => "puppet://puppet/spacewalk/epel5.repo";
	"/etc/yum.repos.d/spacewalk-client.repo":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
	 source  => "puppet://puppet/spacewalk/spacewalk-client.repo_rhel5";
	    }
        package {
	"python-dmidecode":
	 ensure => "installed"; 
	"rhn-setup":
	 ensure => "installed"; 
	"yum-rhn-plugin":
	 ensure => "installed"; 
	        }
}
