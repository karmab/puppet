class jail::rhel6 {
    augeas{
    "ssh":
     context => "/files/etc/ssh/sshd_config/Subsystem[1]",
     changes => [
     "set sftp internal-sftp"
       ],
     notify => Service["sshd"]
          }
    exec {	
    "creatematch$jailgroups":
     command => "echo Match Group ${jailgroups}* >> /etc/ssh/sshd_config; echo '  ChrootDirectory %h' >> /etc/ssh/sshd_config; echo '  ForceCommand internal-sftp' >> /etc/ssh/sshd_config ; /etc/init.d/sshd restart",
     unless => "/bin/grep -iq $jailgroups /etc/ssh/sshd_config",
     path => ["/bin"];
	}
    file {
    "$jailroot":
     ensure =>"directory",
     owner => "root",
     group => "root",
     mode => "755";
    "/root/bin":
     ensure =>"directory";
	  }
    define createjails {
    file {
    "${jailroot}/${name}":
     ensure =>"directory",
     owner => "root",
     group => "$name",
     require => Group["$name"],
     mode => "750";
         }
    group {
    "$name":
     ensure =>"present";
    	  }}
    if ($jailgroups ) { createjails{ $jailgroups: } }
    service {
    "sshd":
     ensure => "true",
     enable => "true",
     hasstatus => "true" ,
     hasrestart => "true";
		}
}
