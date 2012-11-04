class customisation::sudo {
	exec {
	"includedir-in-sudoers":
	 command => "/bin/echo '#includedir /etc/sudoers.d' >>/etc/sudoers",
	 require => File["/etc/sudoers.d"],
	 unless  => "/bin/grep -q '^#includedir' /etc/sudoers"; 
	     }
        file {
        "/etc/sudoers.d":
        ensure  => "directory";
	 }
}
