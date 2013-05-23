require "xmlrpc/client"
require 'socket'

Puppet::Type.type(:satconfchannel).provide(:rhn) do
    desc "RHN Configuration Channel"
    defaultfor :operatingsystem => ":redhat"
    def create
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        confchannelname = resource[:name]
        begin 
            deploy = resource[:deploy]
        rescue
            deploy = false
        end    
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        systemidarray = Array.new
        systemidarray << systemid
        confchannelarray= Array.new
        confchannelarray << confchannelname
        #Puppet.debug("Puppet::Provider:satconfchannel:rhn found"+ confchannelarray.join(" "))
        begin
            s.call("system.config.addChannels", key, systemidarray, confchannelarray, false);
        rescue
            raise Puppet::Error, "Configuration channel not found"
        end
        if deploy
            Puppet.debug("Puppet::Provider:satconfchannel:rhn deploying conf files:")
            conffiles = s.call("configchannel.listFiles", key, confchannelname);
            conffiles.each { |conffile|
                conffile = conffile["path"]
                result = system "rhncfg-client get #{conffile} >/dev/null"
                if result
                    Puppet.debug("Puppet::Provider:satconfchannel:rhn deployed"+ conffile)
                end    
            }
        end
    end

    def destroy
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        confchannelname = resource[:name]
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        systemidarray = Array.new
        systemidarray << systemid
        confchannels = Array.new
        confchannellist = s.call("system.config.listChannels", key, systemid);
        confchannellist.each { |confchannel|
            if confchannel["label"] != confchannelname
                confchannels << confchannel["label"]
            end
        }
        #Puppet.debug("Puppet::Provider:satconfchannel:rhn found"+ confchannel["label"])
        s.call("system.config.setChannels", key, systemidarray, confchannels);
    end

    def exists?
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        confchannelname = resource[:name]
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        confchannellist = s.call("system.config.listChannels", key, systemid);
        confchannellist.each { |confchannel|
            #Puppet.debug("Puppet::Provider:satconfchannel:rhn found"+ confchannel["label"])
        if confchannel["label"] == confchannelname
            return true
        end
        }
        return false
    end
end
