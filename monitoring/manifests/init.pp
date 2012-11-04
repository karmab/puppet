class monitoring {
        file {
        "/etc/snmp/snmpd.conf":
         owner  => "root",
         group  => "root",
         mode   => "644",
         require => Package["net-snmp"],
         content  => template("monitoring/snmpd.conf.erb");
	 "/etc/sysconfig/snmpd.options":
         owner  => "root",
         group  => "root",
         mode   =>  "644",
         require => Package["net-snmp"],
         source  => "puppet:///modules/monitoring/snmpd.options";
             }

        package {
	"net-snmp":
         ensure => "installed";
	"net-snmp-libs":
         ensure => "installed";
        "net-snmp-utils":
         ensure => "installed";
	        }
      
        service {
        "snmpd":
         require => Package["net-snmp"],
         enable => "true" ,
         hasrestart => "true",
         hasstatus => "true", 
	 ensure => "running",
	 subscribe => [ File["/etc/snmp/snmpd.conf"] , File["/etc/sysconfig/snmpd.options"]];
                }
}
