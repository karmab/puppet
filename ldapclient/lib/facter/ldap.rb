# ldap.rb
Facter.add("ldap") do
        setcode do
        	result="false"
		txt=File.read("/etc/nsswitch.conf")
        	if txt =~ /ldap/
            	 result="true"
        	end
        result
        end
end
