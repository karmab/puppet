class customisation::puppet {
	case $operatingsystem {
	"Debian","Ubuntu": { 
	$puppetservice   = "puppet"
	$puppetconf      = "/etc/puppet/puppet.conf" 
	$puppetconfsrc   = "puppet.conf_$operatingsystem" 
	$puppetsysconf   = "/etc/default/puppet" 
	$puppetsysconfsrc= "puppet_default" 
	$puppetnamespaceauthconf = "/etc/puppet/namespaceauth.conf"
	$puppetnamespaceauthsrc  = "namespaceauth.conf" 
	$puppetauthconf = "/etc/puppet/auth.conf"
	$puppetauthsrc  = "auth.conf" 
	                   }
	"Solaris": { 
	case $puppetversion {
	/0.25.*/: { $puppetservice = "puppetd" }
	/2.6.*/: { 
	$puppetservice   = "cswpuppetd" 
	$puppetinitdfile = "/etc/opt/csw/init.d/cswpuppetd"
	}
	/2.7.*/: {
	$puppetservice   = "cswpuppetd" 
	$puppetinitdfile = "/etc/opt/csw/init.d/cswpuppetd"
	}
	}
	$puppetconf       = "/etc/puppet/puppet.conf" 
	$puppetconfsrc    = "puppet.conf_$operatingsystem" 
	$puppetsysconf    = "/etc/default/puppet" 
	$puppetsysconfsrc = "puppet_default" 
	$puppetnamespaceauthconf = "/etc/puppet/namespaceauth.conf"
	$puppetnamespaceauthsrc  = "namespaceauth.conf" 
	$puppetauthconf = "/etc/puppet/auth.conf"
	$puppetauthsrc  = "auth.conf" 
		  }
	default:  { 
	$puppetservice           = "puppet"
	$puppetconf              = "/etc/puppet/puppet.conf"
	$puppetconfsrc           = "puppet.conf"
	$puppetsysconf           = "/etc/sysconfig/puppet"
	$puppetsysconfsrc        = "puppet_sysconfig" 
	$puppetnamespaceauthconf = "/etc/puppet/namespaceauth.conf"
	$puppetnamespaceauthsrc  = "namespaceauth.conf" 
	$puppetauthconf = "/etc/puppet/auth.conf"
	$puppetauthsrc  = "auth.conf" 
		  }
	}
    if ($puppetinitdfile) {
    file {
    $puppetinitdfile:
     owner   => "root",
     group   => "bin",
     mode    =>  "755",
     source  => "puppet:///modules/customisation/cswpuppetd";
	 }}
    file {
    $puppetconf:
     owner   => "root",
     group   => "root",
     mode    =>  "644",
     source  => "puppet:///modules/customisation/$puppetconfsrc";
    $puppetsysconf:
     owner   => "root",
     group   => "root",
     mode    =>  "644",
     source  => "puppet:///modules/customisation/$puppetsysconfsrc";
    $puppetnamespaceauthconf:
     owner    => "root",
     group    => "root",
     mode     =>  "644",
     content  => template("customisation/$puppetnamespaceauthsrc.erb");
    $puppetauthconf:
     owner    => "root",
     group    => "root",
     mode     =>  "644",
     #replace  =>  "false",
     content  => template("customisation/$puppetauthsrc.erb");
	     }
    if ($puppetinitdfile) {
    service {
    $puppetservice:
     enable     => "true" ,
     hasrestart => "true",
     hasstatus  => "true",
     subscribe  => [File[$puppetconf],File[$puppetsysconf],File[$puppetinitdfile],File[$puppetnamespaceauthconf],File[$puppetauthconf]],
     ensure     => "running" ;
	    }
    } else {
    service {
    $puppetservice:
     enable     => "true" ,
     hasrestart => "true",
     hasstatus  => "true",
     subscribe  => [File[$puppetconf],File[$puppetsysconf],File[$puppetnamespaceauthconf],File[$puppetauthconf]],
     ensure     => "running" ;
	    }
   }
}
