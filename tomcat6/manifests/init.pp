class tomcat6 {
	group {
	"tomcat":
	 gid => "1002",
         ensure => "present";
              }

        user { 
        "tomcat": 
         comment => "Apache Tomcat user",
         uid => "1002",
         gid => "1002",
         home => "/home/tomcat",
	 require => [ Package["tomcat6"],Group["tomcat"]],
         shell => "/bin/bash";
             }

        file {
        "/etc/init.d/tomcat":
  	 ensure  => "present",
	 owner   => "root",
    	 group   => "tomcat",
	 mode    => "770",
         require => [Package["tomcat6"],Group["tomcat"]],
         replace => "false",
	 source  => "puppet:///modules/tomcat6/tomcat6_initd";
        "/etc/profile.d/java6.sh":
         ensure  => "present",
         owner   => "root",
         group   => "root",
         mode    => "644",
         require => Package["jdk"],
         source  => "puppet:///modules/tomcat6/java6.sh";
        "/home/tomcat":
	 ensure => "directory",
         owner => "tomcat";
        "/opt/java":
         ensure => "link",
         require => Package["jdk"],
         target => "/usr/java/jdk$jdkversion";
        "/opt/tomcat":
         ensure => "link",
	 require => Package["tomcat6"],
         target => "/opt/apache-tomcat-6.0.26";
        "/opt/apache-tomcat-6.0.26":
	 recurse => "true",
	 require => [Package["tomcat6"],Group["tomcat"]],
	 owner => "tomcat",
	 group => "tomcat";
        "/opt/tomcat/webapps":
          mode=> "775";
	     }

        package {
        "jdk":
         name  => "jdk",
         ensure => "installed";
        "tomcat6":
	 name  => "tomcat",
         ensure => "installed";
	        }
}
