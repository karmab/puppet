class karma::nfs  {
	define mkhomedir {
         file {
        "/rhome/$name":
	 ensure => "directory",
	 mode => "700",
	 owner => "$name",
         group   => "root",
         require => File["/rhome"];
             }
			      }

	if ($homedirusers ) {
	 mkhomedir{ $homedirusers: }
                        }

        file {
	"/rhome":
	 ensure => "directory",
	 mode => "755";
             }
	if !defined(Package['nfs-utils']) {
        package {
        "nfs-utils":
         ensure => "installed";
	}}
}
