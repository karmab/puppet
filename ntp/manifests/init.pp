class ntp {
        case $release {
         "6": {
         $ntppackage = "ntpdate"
         $ntpservice = "ntpdate"
         $ntprestart = "/sbin/service ntpdate restart"
                  }
         default: {
         $ntppackage = "ntp"
         $ntpservice = "ntpd"
         $ntprestart = "/sbin/service ntpd restart"
                  }                  } 

        file {
         "/etc/ntp/step-tickers":
          ensure=>"present",
          source => "puppet:///modules/ntp/step-tickers-$client";
         "/etc/ntp/ntpservers":
          ensure=>"present",
          source => "puppet:///modules/ntp/ntpservers-$client";
         "/etc/ntp.conf":
          ensure=>"present",
          source => "puppet:///modules/ntp/ntp.conf-$release";

             }

	package {
        "ntp":
	 name   => $ntppackage,
         ensure => "installed";
	        }

	service {
	"ntpd":
	 name   => $ntpservice,
	 enable => "true";
	}

		    }
