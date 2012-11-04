class jail::jailkit {
    file {
    "$jailroot":
     ensure =>"directory";
    "/root/bin/":
     ensure =>"directory";
    "/root/bin/jailcreate.sh":
     ensure =>"present",
     owner => "root",
     mode => "700",
     content => template("jail/jailcreate.sh.erb");
	  }
    package {
    "jailkit":
     ensure => "installed";
	        }
}
