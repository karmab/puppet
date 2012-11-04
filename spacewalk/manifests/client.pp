class spacewalk::client {
	case $release {
                "4": { $spacewalkclientpackages = ["up2date"] }
		"5": { $spacewalkclientpackages = ["m2crypto","python-dmidecode","rhn-client-tools","rhn-check","rhn-setup","rhnsd","yum-rhn-plugin"] }
	}
	exec {
	"register_to_spacewalk":
	command => "rhnreg_ks --serverUrl=http://$spacewalkserver/XMLRPC --activationkey=$activationkey",
	path => "/usr/sbin",
	require => Package[$spacewalkclientpackages],
	creates => "/etc/sysconfig/rhn/systemid";
	}
	file {
	"/etc/yum.repos.d/space.repo":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
	 content  => template("spacewalk/space.repo.erb");
	    }
        package {
	$spacewalkclientpackages:
	 ensure =>"installed",
	 require => File["/etc/yum.repos.d/space.repo"];
	        }
}
