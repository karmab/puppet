class postfix {
        exec {
        "installcanonicalmap":
         command => "/usr/sbin/postmap /etc/postfix/canonical",
	 require =>  Package["postfix"],
         creates => "/etc/postfix/canonical.db";
        "installgenericmap":
         command => "/usr/sbin/postmap /etc/postfix/generic",
	 require =>  Package["postfix"],
 	 creates => "/etc/postfix/generic.db";
	     }
        file {
        "/etc/postfix/main.cf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         require => Package["postfix"],
	 content => template("postfix/main.cf.erb");
             }
        package {
	"mailx":
         ensure => "installed";
	"postfix":
         ensure => "installed";
	        }
      
        service {
        "postfix":
         require => Package["postfix"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true", 
	 ensure => "running",
	 subscribe => File["/etc/postfix/main.cf"];
                }
}
