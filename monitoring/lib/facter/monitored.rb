# monitored.rb
Facter.add("monitored") do
        setcode do
		result = false
                if FileTest.exists?("/var/scripts/AGENTE_SNMP/agente_snmp.sh")
		 result = true
		end
	result
        end
end
monitored = Facter.value('monitored')
if monitored == true 
	Facter.add("monitorversion") do
        setcode do
         %x{sed -n '3,3p' /var/scripts/AGENTE_SNMP/agente_snmp.sh | sed 's/.* //' }.chomp
        end
	end
end 
