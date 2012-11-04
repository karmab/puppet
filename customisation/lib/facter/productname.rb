Facter.add("productname") do
    confine :kernel => [ :sunos ] 
    setcode do
	%x{/usr/sbin/prtdiag  | /bin/grep "System Configuration:" | /usr/bin/awk -F":" '{print $2}' | sed 's/.*sun4. //'}.chomp
        end
end
Facter.add("manufacturer") do
    confine :kernel => [ :sunos ] 
    setcode do
	%x{echo SUN MICROSYSTEMS}.chomp
        end
end

