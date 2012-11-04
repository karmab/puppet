class puppetmaster {	
	case $operatingsystem {
	"CentOS": { $puppetmasterpackage = "puppet-server" }
	"RedHat": { $puppetmasterpackage = "puppet-server" }
	"Solaris": { $puppetmasterpackage = "CSWpuppetmaster" }
	"Ubuntu": { $puppetmasterpackage = "puppetmaster"  }
	}
	case $operatingsystem {
	"Solaris": { $puppetmasterservice = "cswpuppetmasterd" }
	default: { $puppetmasterservice = "puppetmaster" }
	}
        file {
	"/etc/puppet/puppet.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package[$puppetmasterpackage],
         source  => "puppet://puppet/puppetmaster/puppet.conf";
             }

        package {
	$puppetmasterpackage:
         ensure => "installed";
	        }
      
        service {
        $puppetmasterservice:
         require => Package[$puppetmasterpackage],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true", 
	 ensure => "running",
	 subscribe => File["/etc/puppet/puppet.conf"];
                }
}
