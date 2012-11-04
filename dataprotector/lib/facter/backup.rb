# dataprotector.rb
Facter.add("dataprotector") do
        setcode do
                result = "false"
                if FileTest.exists?("/etc/opt/omni/client/omni_info") or FileTest.exists?("/usr/omni/config/client/omni_info")
                 result = "true"
                end
        result
        end
end
dataprotector = Facter.value('dataprotector')
if dataprotector == "true" 
	Facter.add("dataprotectorversion") do
        setcode do
         if FileTest.exists?("/etc/opt/omni/client/omni_info")
         %x{grep version /etc/opt/omni/client/omni_info | head -1  | sed 's/.* -version //'}.chomp
	 end
	 if FileTest.exists?("/usr/omni/config/client/omni_info")
         %x{grep version /usr/omni/config/client/omni_info | head -1  | sed 's/.* -version //'}.chomp
         end
        end
	end
end 

