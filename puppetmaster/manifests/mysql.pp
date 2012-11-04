class puppetmaster::mysql {	
	case $operatingsystem {
	"CentOS": { $puppetmasterpackage = "puppet-server" }
	"RedHat": { $puppetmasterpackage = "puppet-server" }
	"Solaris": { $puppetmasterpackage = "CSWpuppetmaster" }
	"Ubuntu": { $puppetmasterpackage = "puppetmaster"  }
	}

        file {
	"/etc/puppet/puppet.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package[$puppetmasterpackage],
	 content => template("puppetmaster/puppet.conf.erb");
             }

        package {
	$puppetmasterpackage:
         ensure => "installed";
	        }
      
        service {
        "puppetmaster":
         require => Package[$puppetmasterpackage],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true", 
	 ensure => "running",
	 subscribe => File["/etc/puppet/puppet.conf"];
                }
}
