class jboss5 {
	group {
	"jboss":
	 gid => "1005",
         ensure => "present";
              }

	if ($jboss5pwd) {
        user {
        "jboss":
         comment => "Jboss user",
         uid => "1005",
         gid => "1005",
         home => "/home/jboss",
         require => Package["jdk5"],
         password => $jobss5pwd,
         shell => "/bin/bash";
	     }		}
	else {
	user {
        "jboss":
         comment => "Jboss user",
         uid => "1005",
         gid => "1005",
         home => "/home/jboss",
         require => Package["jdk5"],
         shell => "/bin/bash";
             }	   
	     }
	
        file {
        "/etc/init.d/jboss":
  	 ensure  => "present",
	 owner   => "root",
    	 group   => "root",
	 mode    => "755",
         require => Package["jdk5"],
	 source  => "puppet:///modules/jboss5/jboss5_initd";

        "/etc/profile.d/java5.sh":
         ensure  => "present",
         owner   => "root",
         group   => "root",
         mode    => "644",
         require => Package["jdk5"],
         source  => "puppet:///modules/jboss5/java5.sh";

        "/home/jboss":
	 ensure  => "directory",
         owner => "jboss";
        "/home/jboss/jboss":
         ensure => "link",
         target => "/opt/jboss";
        "/opt/jdk5":
         ensure => "link",
         require => Package["jdk5"],
         target => "/usr/java/jdk1.5.0_22";
        "/opt/jboss":
         ensure => "link",
         target => "/opt/jboss-5.1.0.GA";
         "/opt/jboss-5.1.0.GA":
	 # recurse => "true",
	  owner => "jboss",
	  group => "jboss";
	 # ignore => "server/default/tmp";
	     }

        package {
	"jdk5":
	  name =>"jdk-1.5.0_22-fcs" ,
	  ensure => "installed";
        "jboss5":
         ensure => "installed";
	        }
}
