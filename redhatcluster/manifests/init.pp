class redhatcluster {
	case $release {
	 "5": { 
	  $cmanfile="cman_initd5" 
	  $redhatclusterpackages=["cman","lvm2","rgmanager","system-config-cluster"]
  	      }
	 "6": { 
	  $cmanfile="cman_initd6" 
	  $redhatclusterpackages=["cman","lvm2","rgmanager"]
	      }
		      }
        file {
	"/etc/init.d/cman":
         owner  => "root",
         group  => "root",
         mode   =>  "755",
         require => Package["cman"],
         source  => "puppet:///modules/redhatcluster/$cmanfile";
	     }
	file {
        "/etc/lvm/lvm.conf":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
         require => Package["lvm2"],
         content =>template("redhatcluster/lvm.conf-${release}.erb");
        "/root/cluster.conf":
         owner  => "root",
         group  => "root",
         mode   =>  "640",
         require => Package["rgmanager"],
         source  => "puppet:///modules/redhatcluster/cluster.conf-$cluster";
             }

        package {
        $redhatclusterpackages:
         ensure => "installed";
	        }
        service {
        "cman":
         enable => "true",
	 require => Package["cman"];
        "iptables":
         enable => "false",
	 ensure => "stopped";
        "rgmanager":
         enable => "true",
	 require => Package["rgmanager"];
                }
	if $release != "6" {
	service {
        "qdiskd":
         enable => "true";
		}
				     }
}

