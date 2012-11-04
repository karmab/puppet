class nfs {
	if !defined(Package['nfs-utils']) {
        package {
        "nfs-utils":
         ensure => "installed";
	}
	}
#	package {
#        "rpcbind":
#         ensure => "installed";
#                }
}
