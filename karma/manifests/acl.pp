class karma::acl {
   $loggroup=["Applications","Monitorizacion","Oracle","Unix"]
   define gen_Applications_acls {
   $group="Applications"
   exec {
   "setfacl -Rm g:${group}:rwx,d:g:${group}:rwx  $name":
    onlyif => [ "[  -d $name ]", "getfacl $name | grep -c $group | grep -q 0"],
    path => ["/usr/bin","/bin"];
   }}
   define gen_Monitorizacion_acls {
   $group="Monitorizacion"
   exec {
   "setfacl -Rm g:${group}:rwx,d:g:${group}:rwx  $name":
    onlyif => [ "[  -d $name ]", "getfacl $name | grep -c $group | grep -q 0"],
    path => ["/usr/bin","/bin"];
   }}
   define gen_Oracle_acls {
   $group="Oracle"
   exec {
   "acls_for_${group}_and_$name":
    command => "setfacl -Rm g:${group}:rwx,d:g:${group}:rwx  $name",
    onlyif => [ "[  -d $name ]", "getfacl $name | grep -c $group | grep -q 0"],
    path => ["/usr/bin","/bin"];
    }}
   define gen_Logs_acls {
   $logdir="/var/log"
   exec {
   "acls_for_logs_and_$name":
    command => "setfacl -Rm g:${name}:rx  $logdir",
    onlyif => [ "getfacl $logdir | grep -c $name | grep -q 0"] ,
    path => ["/usr/bin","/bin"];
   }}
                
   if ($Applications_acls) { gen_Applications_acls { $Applications_acls:}  }
   if ($Monitorizacion_acls) { gen_Monitorizacion_acls { $Monitorizacion_acls:} }
   if ($Oracle_acls) { gen_Oracle_acls { $Oracle_acls:} }
   gen_Logs_acls { $loggroup:} 
}
