require "xmlrpc/client"
require 'socket'

Puppet::Type.type(:satchannel).provide(:rhn) do
    desc "RHN Channel"
    defaultfor :operatingsystem => ":redhat"
    def create
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        channelname = resource[:name]
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        #Puppet.debug("Puppet::Provider:satchannel:rhn found"+ hostname)
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        channellist = s.call("system.listSubscribedChildChannels", key, systemid);
        channels = Array.new
        channellist.each { |channel|
            channels << channel["label"]
        }
        channels << channelname
        begin 
            s.call("system.setChildChannels", key, systemid, channels);
        rescue
            raise Puppet::Error, "Channel not found"
        end    
    end

    def destroy
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        channelname = resource[:name]
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        channellist = s.call("system.listSubscribedChildChannels", key, systemid);
        channels = Array.new
        channellist.each { |channel|
            if channel["label"] != channelname
                channels << channel["label"]
            end
        }
        s.call("system.setChildChannels", key, systemid, channels);
    end

    def exists?
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        channelname = resource[:name]
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        channellist = s.call("system.listSubscribedChildChannels", key, systemid);
        channellist.each { |channel|
        #Puppet.debug("Puppet::Provider:satchannel:rhn channel:"+ channel["label"])
        if channel["label"] == channelname
            return true
        end
        }
        return false
    end
end
