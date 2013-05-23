Puppet::Type.newtype(:satgroup) do
    @doc = "Manage satellite groups"

    ensurable

    newparam(:name) do
        desc "The satellite s group name"
        #resource[:provider] = :rhn
        isnamevar
    end

    newparam(:host) do
        desc "Satellite host"
    end

    newparam(:user) do
        desc "Satellite User"
        validate do |value|
            unless value =~ /^\w+/
                raise ArgumentError, "%s is not a valid user name" % value
            end
        end
    end

    newparam(:password) do
        desc "Satellite password"
    end
end
