class redhatcluster::vmware inherits redhatcluster {
	#buggy at the moment because of the damn license..."
        #exec {
        #"install_vsphere_sdk":
        # command => "/usr/bin/wget http://192.168.16.1/cobbler/repo_mirror/VMware-vSphere-Perl-SDK-4.1.0-254719.$architecture.tar.gz ; /bin/tar zxvf VMware-vSphere-Perl-SDK-4.1.0-254719.$architecture.tar.gz  ; vmware-vsphere-cli-distrib/vmware-install.pl -d ; /bin/rm -rf VMware-vSphere-Perl-SDK-4.1.0-254719.$architecture.tar.gz vmware-vsphere-cli-distrib ",
	# unless  => "/usr/bin/test -e /usr/bin/vmware-uninstall-vSphere-CLI.pl";
        #     }

        package {
        "openssl-devel":
         ensure => "installed";
		}
}

