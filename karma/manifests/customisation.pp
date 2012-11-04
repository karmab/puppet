class karma::customisation {
    if $virtual == "vmware" and $operatingsystem == "RedHat" {
    exec {
    "redhat-auto-register":
     command=> "/usr/sbin/rhnreg_ks --username karma001 --password karma001 --nohardware",
     unless => "/usr/bin/test -f /etc/sysconfig/rhn/systemid";
 #    "installvmwaretools":
 #     command => "/usr/bin/wget 'http://192.168.1.1/cobbler/repo_mirror/VMwareTools-8.3.2-257589.tar.gz' ; /bin/tar zxvf VMwareTools-8.3.2-257589.tar.gz ; vmware-tools-distrib/vmware-install.pl -d ; /bin/rm -rf vmware-tools-distrib VMwareTools-8.3.2-257589.tar.gz",
 #     creates => "/usr/bin/vmware-toolbox" ;
	  }
}
}
