class karma::repos {
        file {	
        "/etc/yum.repos.d/nyse.repo":
         owner  => "root",
         group  => "root",
         mode   =>  644,
	 content => template("karma/nyse.repo.erb-$client") ;
        "/etc/yum.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/karma/yum.conf";
        "/etc/rpm/macros":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/karma/macros_rpm";
    	     }
	if $operatingsystem == "RedHat" and $architecture == "i386" {
        file {
        "/etc/yum.repos.d/updates.repo":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         content => template("karma/updates.repo.erb-$client") ;
	"/etc/yum/pluginconf.d/rhnplugin.conf":
	 owner  => "root",
         group  => "root",
         mode   =>  644,
	 source  => "puppet:///modules/karma/rhnplugin5.conf";
	     }
	}
}
