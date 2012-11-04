class customisation {
    file {
    "/etc/profile.d/customisation.sh":
     ensure =>"present",
     owner   => "root",
     group   => "root",
     mode    => "755",
     source =>"puppet:///modules/customisation/customisation.sh";
	 }
}
