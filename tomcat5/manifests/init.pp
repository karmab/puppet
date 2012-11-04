class tomcat5 {
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
	 require => Package["tomcat5"],
         shell => "/bin/bash";
             }

        file {
        "/etc/init.d/tomcat":
  	 ensure  => "present",
	 owner   => "root",
    	 group   => "tomcat",
	 mode    => "770",
         require => Package["tomcat5"],
	 replace => "false",
	 source  => "puppet:///modules/tomcat5/tomcat5_initd";
        "/etc/profile.d/java6.sh":
         ensure  => "present",
         owner   => "root",
         group   => "root",
         mode    => "644",
         require => Package["jdk6"],
         source  => "puppet:///modules/tomcat5/java6.sh";
        "/home/tomcat":
	 ensure => "directory",
         owner => "tomcat";
        "/home/tomcat/tomcat":
         ensure => "link",
         target => "/opt/tomcat";
        "/opt/java":
         ensure => "link",
         require => Package["jdk6"],
         target => "/usr/java/jdk1.6.0_23";
        "/opt/tomcat":
         ensure => "link",
	 require => Package["tomcat5"],
         target => "/opt/apache-tomcat-5.5.27";
        "/opt/apache-tomcat-5.5.27":
	 recurse => "true",
	 require => Package["tomcat5"],
	 owner => "tomcat",
	 group => "tomcat";
        "/opt/tomcat/webapps":
          mode=> "775";
	     }

        package {
        "jdk6":
         name  => "jdk",
         ensure => "installed";
        "tomcat5":
	 name =>"tomcat5527" ,
         ensure => "installed";
	        }
}
