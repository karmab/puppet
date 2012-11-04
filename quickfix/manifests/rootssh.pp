class quickfix::rootssh {
   augeas {
   "sshd_config":
    changes => [
    "set /files/etc/ssh/sshd_config/PermitRootLogin $rootssh",
               ],
	  }
   service {
   "sshd":
    hasrestart => "true",
    hasstatus => "true",
    ensure => "running",
    subscribe => Augeas["sshd_config"] ;
	   }
}
