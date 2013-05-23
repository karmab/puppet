Puppet::Type.newtype(:satconfchannel) do
    @doc = "Manage satellite configuration channels"

    ensurable

    newparam(:name) do
        desc "The satellite s configuration channel name"
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

    newparam(:deploy, :boolean => true ) do
        desc "Whether to deploy when subscribing to configuration channel"
    end
end
