class karma::bind inherits karma::bindclients {
    case $operatingsystem {
    "Debian": {
     $bindroot="/var/cache/bind"
     $bindetcroot="/etc/bind"
     $binduser="bind"
     $bindpackages=["bind9", "bind9utils"]
     $bindservice="bind9"
              }
    "RedHat","Centos": {
     $bindroot="/var/named/chroot/var/named"
     $bindetcroot="/var/named/chroot/var/named"
     $binduser="named"
     $bindpackages=["bind", "bind-chroot","bind-utils"]
     $bindservice="named"
              }
    }
    $dnsclis = inline_template("<%= dnsdomains.keys.join(',') %>")
    $dnsclients =split($dnsclis,',') 
    define gen_hostingzonefiles {
    file {
    "$bindroot/hosting/$client2/named.$name":
     ensure =>"present",
     owner => $binduser,
     group  => $binduser,
     content => template("karma/defaultzone.conf.erb"),
     replace => "false";
    }
    }
    define gen_hostingconffiles {
    $zones=$dnsdomains[$name]
    $client2=$name
    exec {
    "reconfig_on_${name}_change":
     command => "/usr/sbin/rndc reconfig",
     subscribe => File["$bindroot/conf/$name.conf"],
     refreshonly => true ;
    }
    file {
    "$bindroot/hosting/$name":
     ensure =>"directory",
     owner => $binduser,
     group  => $binduser;
    "$bindroot/conf/$name.conf":
     ensure =>"present",
     content => template("karma/$dnsrole.conf.erb");
    }
    if ($dnsrole == "master") { gen_hostingzonefiles{ $zones:} }
    }
    define gen_reversezonefiles {
    $reversename=inline_template("<%= name.split('.').reverse.join('.') %>")
    file {
    "$bindroot/reverse/named.$reversename":
     ensure =>"present",
     owner => $binduser,
     group  => $binduser,
     content => template("karma/defaultreversezone.conf.erb"),
     replace => "false";
    }
    }
    gen_hostingconffiles{ $dnsclients:}
    if ($dnsrole == "master") { gen_reversezonefiles{ $dnsreversedomains:} }
    exec {
    "reconfig_on_reverse_change":
     command => "/usr/sbin/rndc reconfig",
     subscribe => File["$bindetcroot/named.conf.reverse"],
     refreshonly => true ;
         }
     if ( $operatingsystem =="RedHat") or ( $operatingsystem =="CentOS") {
     file {
    "$bindroot/named.ca":
     ensure =>"present",
     owner => $binduser,
     group  => $binduser,
     mode => "640",
     source  => "puppet://puppet/karma/named.ca";
    "$bindroot/named.empty":
     ensure =>"present",
     owner => $binduser,
     group  => $binduser,
     mode => "640",
     source  => "puppet://puppet/karma/named.empty";
    "$bindroot/named.localhost":
     ensure =>"present",
     owner => $binduser,
     group  => $binduser,
     mode => "640",
     source  => "puppet://puppet/karma/named.localhost";
    "$bindroot/named.loopback":
     ensure =>"present",
     owner => $binduser,
     group  => $binduser,
     mode => "640",
     source  => "puppet://puppet/karma/named.loopback";
     }
     }
    file {
    "$bindetcroot/named.conf":
     ensure =>"present",
     source  => "puppet://puppet/karma/named.conf-$hostname";
    "$bindetcroot/named.conf.clientes":
     ensure =>"present",
     content => template("karma/named.conf.clientes.erb");
    "$bindetcroot/named.conf.reverse":
     ensure =>"present",
     content => template("karma/$dnsrole.named.conf.reverse.erb");
    "$bindroot/conf":
     ensure =>"directory",
     owner => $binduser,
     group  => $binduser;
    "$bindroot/hosting":
     ensure =>"directory",
     owner => $binduser,
     group  => $binduser;
    "$bindroot/reverse":
     ensure =>"directory",
     owner => $binduser,
     group  => $binduser;
	     }	
     package { $bindpackages: ensure => "installed";}
     service {
     $bindservice:
      require => Package[$bindpackages],
      enable => "true",
      hasrestart => "true",
      hasstatus => "true",
      subscribe => File[["$bindetcroot/named.conf","$bindetcroot/named.conf.clientes","$bindetcroot/named.conf.reverse"]],
      ensure => "running" ;
                }
}
