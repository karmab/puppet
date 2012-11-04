class karma::kickstarts inherits provisioning {
        file {
        "/var/lib/cobbler/kickstarts/gestion5.ks":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/karma/ks/gestion5.ks";
        "/var/lib/cobbler/kickstarts/be5.ks":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/karma/ks/be5.ks";
        "/var/lib/cobbler/kickstarts/be6.ks":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/karma/ks/be6.ks";
        "/var/lib/cobbler/kickstarts/fe5.ks":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/karma/ks/fe5.ks";
        "/var/lib/cobbler/kickstarts/fe6.ks":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/karma/ks/fe6.ks";

        "/var/lib/cobbler/kickstarts/web6.ks":
         owner  => "root",
         group  => "root",
         mode   =>  644,
         source  => "puppet:///modules/karma/ks/web6.ks";
	     }
}
