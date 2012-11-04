class ldapclient::routessl10 inherits ldapclient::sl10 {
	case $hostname {
	/.*dmz.*/: {
 	$gestiongw="10.4.105.254" 
	}
	/.*qfr.*/: {
 	$gestiongw="10.4.170.254" 
	}
	default: {
 	$gestiongw="10.4.140.254" 
	}
	}
	stage {"ldap_routessl10": before => Stage["main"]}
	# Añadimos los hosts del ldap
        host {
        'ldap.local
         ip =>$ldap1,
         ensure =>"present" ;
        'ldap.local
         ip =>$ldap2,
         ensure =>"present" ;
         }

	# Añadimos las rutas necesarias para llegar al ldap estaticamente
        exec {
        "routes_ldap_s10":
        command => "route -p add $ldapnetwork/$ldapsubnet $gestiongw",
        path => "/usr/bin/,/usr/sbin/",
	unless => "cat /etc/inet/static_routes | grep $ldapnetwork";
        }
}
