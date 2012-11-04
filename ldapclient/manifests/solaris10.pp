class ldapclient::solaris10 {
        # Refrescamos la configuracion del nscd en caso de que se cambie el nscd.conf de Solaris
        exec {
        "nscd_restart_sl":
         command => "/usr/sbin/svcadm refresh svc:/system/name-service-cache:default",
	 refreshonly => 'true',
             }
	#Instalamos el paquete de sudo con soporte ldap
        exec {
	"sudo_install_$version":
	command =>"/usr/bin/echo y | /usr/sbin/pkgadd -d https://$pkgserver/solaris/TCMsudo.1.8.1p1_$version.$hardwaremodel.pkg all ",
	creates =>"/usr/local/sudo";
	     }
 
	# Inicialización del cliente ldap cada vez que se cambia el fichero ldap_init.sh
        # Se dispara por medio de la notificacion del fichero ldap_init.sh
        exec {
        "ldap_init_sl":
        command => "/var/ldap/ldap_init.sh",
        refreshonly => 'true',
        require => File[["/var/ldap/cert8.db"],["/var/ldap/key3.db"],["/var/ldap/ldap_init.sh"],["/etc/nsswitch.ldap"]],
             }

        # Configuracion ldap Solaris 
        file {
        "/var/ldap/ldap_init.sh":
        owner  => "root",
        group  => "root",
        mode   =>  700,
        notify => exec ["ldap_init_sl"],
        source  => "puppet:///modules/ldapclient/ldap_init_sl";

        "/var/ldap/cert8.db":
        owner  => "root",
        group  => "root",
        mode   =>  600,
        source  => "puppet:///modules/ldapclient/cert8.db_sl";

        "/var/ldap/key3.db":
        owner  => "root",
        group  => "root",
        mode   =>  600,
        source  => "puppet:///modules/ldapclient/key3.db_sl";

        "/etc/pam.conf":
        ensure  => "present",
        owner  => "root",
        group  => "sys",
        mode   =>  644,
	source  => "puppet:///modules/ldapclient/pam_ldap.conf_s10";
	
        # Configuramos el nsswitch.ldap porque al hacer el ldapinit vuelca
        # el contenido de este fichero en el nsswitch.conf
        "/etc/nsswitch.ldap":
        owner  => "root",
        group  => "sys",
        mode   =>  644,
        ensure  => "present",
        source  => "puppet:///modules/ldapclient/nsswitch.conf_sl";
        
	"/var/ldap/README.cert":
        owner  => "root",
        group  => "root",
        mode   =>  600,
        source  => "puppet:///modules/ldapclient/README.cert_sl";
       
	"/var/ldap/sudo.ldap":
        owner  => "root",
        group  => "root",
        mode   =>  600,
        source  => "puppet:///modules/ldapclient/sudo.ldap_sl";
      
	"/etc/nscd.conf":
        owner  => "root",
        group  => "sys",
        mode   =>  644,
	notify =>  exec["nscd_restart_sl"],
        source  => "puppet:///modules/ldapclient/nscd.conf_sl";

        }

        host {
        'ldap.local
         ip =>"192.168.6.11",
         ensure =>"present" ;
        'ldap.local
         ip =>"192.168.6.12",
         ensure =>"present" ;
         }

}
