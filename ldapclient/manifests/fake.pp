class ldapclient::fake {
   augeas { 
   "sudoux":
    require => Group["Ux"],
    context => "/files/etc/sudoers",
    changes => [
     "set spec[user = '%Ux']/user %Ux",
     "set spec[user = '%Ux']/host_group/host ALL",
     "set spec[user = '%Ux']/host_group/command ALL",
     "set spec[user = '%Ux']/host_group/command/runas_user root",
     "set spec[user = '%Ux']/host_group/command/tag NOPASSWD",
        ],
          }
   if ($fakeldapusers ) {
   group {
   "Ux":
    gid => "666",
    ensure => "present";
         }
	 }
   define mkfakeldapusers {
   user {
   "$name":
    comment => "Nyse Ux user",
    gid => "666",
    home => "/rhome/$name",
    require => Group["Ux"];
         }
       }
    if ($fakeldapusers ) { mkfakeldapusers{ $fakeldapusers: } }
}
