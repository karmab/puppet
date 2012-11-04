class nfs::autofs {
	case $operatingsystem {
	"Debian","Ubuntu": {
	$idmapdservice  = "nfs-common"
	$idmapdconffile = "idmapd.conf_deb"
	$nfspackage     = "nfs-common" 
	$automasterfile = "auto.master" 
	$autorhomefile  = "auto.rhome" 
	 	}
	"SLES": { 
	$idmapdservice  = "idmapd"
	$idmapdconffile = "idmapd.conf"
	$nfspackage     = "nfs-utils" 
	$automasterfile = "auto.master" 
	$autorhomefile  = "auto.rhome" 
		}
	default: { 
	$idmapdservice  = "rpcidmapd"
	$idmapdconffile = "idmapd.conf"
	$nfspackage     = "nfs-utils" 
	$automasterfile = "auto.master" 
	$autorhomefile  = "auto.rhome" 
		 }
	}
	exec {
	"rhome_present":
	 command => "/bin/echo /rhome /etc/$autorhomefile --timeout=20 >>/etc/$automasterfile",
	 unless  => "/bin/grep -q '^/rhome' /etc/$automasterfile";
	     }
        file {
	"/etc/$automasterfile":
	 ensure  =>"present";
        "/etc/$autorhomefile":
         owner   => "root",
         group   => "root",
         mode    => "644",
         require => Package["autofs"],
	 content =>template("nfs/auto.rhome.erb");
	"/etc/idmapd.conf":
         owner   => "root",
         group   => "root",
         mode    => "644",
         require => Package[$nfspackage],
	 source  => "puppet:///modules/nfs/$idmapdconffile";
	     }
        package {
        "autofs":
         ensure  => "installed";
        $nfspackage:
         ensure  => "installed";
 	        }
	service {
        "autofs":
         require    => Package["autofs"],
         enable     => "true" ,
         hasrestart => "true",
         hasstatus  => "true",
         subscribe  => [ File["/etc/$automasterfile"],File["/etc/$autorhomefile"] ],
	 ensure     => "running" ;
	 $idmapdservice: 
         require    => Package[$nfspackage],
         enable     => "true" ,
         hasrestart => "true",
         hasstatus  => "true",
         subscribe  => File["/etc/idmapd.conf"],
	 ensure     => "running" ;
		}
	 if $release != "6" {
	 service {
	 "portmap":
         enable => "true" ,
	 ensure => "running" ;
	 		    }
	       }

}
