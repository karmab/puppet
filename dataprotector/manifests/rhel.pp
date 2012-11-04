class dataprotector::rhel  {
       augeas { 
       "remove5555port":
	before  => Package["OB2-CORE"],
        changes => ["rm /files/etc/services/service-name[. = 'personal-agent'][protocol = 'tcp']","rm /files/etc/services/service-name[. = 'personal-agent'][protocol = 'udp']","rm /files/etc/services/service-name[. = 'rplay'][protocol = 'udp']"],
	      }
       exec {
       "fix-ext4-bug":
	command => "/bin/sed -i 's/ext3/ext3 -t ext4/' /opt/omni/lbin/.util ",
        require => [ Package["OB2-CORE"],Package["OB2-DA"]],
 	unless  => "/bin/grep -q ext4 /opt/omni/lbin/.util";
	#will only work if cell can resolve machine s name
	#	"register-machine-to-cell":
	#	 command => "/opt/omni/bin/omnicc -import_host $fqdn -server $cellserver",
	#	 require => Package["OB2-DA"],
	#	 creates =>"/etc/opt/omni/client/cell_server";
             }
       package {
       "OB2-DA":
 	require => [ Package["OB2-CORE"],Package["xinetd"]],
        ensure => "latest";
       "OB2-CORE":
 	require => Package["xinetd"],
        ensure => "latest";
       "xinetd":
        ensure => "installed";
                }

       service {
       "xinetd":
        require => Package["xinetd"],
        ensure => "running" ;
                }
}
