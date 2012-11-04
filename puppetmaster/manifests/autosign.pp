class puppetmaster::autosign {	
        file {
	"/etc/puppet/autosign.conf":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         content => "*";
             }
}
