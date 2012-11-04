class foreman::report {
	case $operatingsystem {
	"Ubuntu": { $report = "/usr/lib/ruby/1.8/puppet/reports/report.rb"                }
	"Solaris": { $report = "/opt/csw/lib/ruby/site_ruby/1.8/puppet/reports/report.rb" }
	default:  { $report = "/usr/lib/ruby/site_ruby/1.8/puppet/reports/report.rb"      }
	}
    file {	
    $report:
     owner  => "root",
     group  => "root",
     mode   =>  "644",
     source  => "puppet://puppet/foreman/report.rb";
    	     }
}
