class nfs::autofssolaris10 {
	$autofspackage  = "SUNWatfsr"
	$idmapdservice  = "mapid"
	$idmapdconffile = "nfs"
	$nfspackage     = "SUNWnfsskr" 
	$automasterfile = "auto_master" 
	$autorhomefile  = "auto_rhome" 
	exec {
	"rhome_present":
	 command => "svcadm disable autofs && svcadm disable mapid && echo /rhome /etc/$autorhomefile --timeout=20 >>/etc/$automasterfile && echo NFSMAPID_DOMAIN=localdomain >>/etc/default/$idmapdconffile && svcadm  enable mapid && svcadm enable autofs",
	 unless  => "/bin/grep '^/rhome' /etc/$automasterfile",
 	 require => File["/etc/$autorhomefile"],
         path => ["/bin/","/usr/bin","/usr/sbin"];
	     }
        file {
        "/etc/$autorhomefile":
         owner   => "root",
         group   => "bin",
         mode    => "644",
         require => Package[$autofspackage],
	 content => template("nfs/auto_rhome.erb");
	     }
        package {
        $autofspackage:
         ensure  => "installed";
        $nfspackage:
         ensure  => "installed";
 	        }
}
