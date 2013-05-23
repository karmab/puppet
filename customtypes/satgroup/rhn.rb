require "xmlrpc/client"
require 'socket'

Puppet::Type.type(:satgroup).provide(:rhn) do
    desc "RHN Support"
    defaultfor :operatingsystem => ":redhat"
    def create
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        groupname = resource[:name]
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        #Puppet.debug("Puppet::Provider:channel:rhn found"+ hostname)
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        begin 
            group = s.call("systemgroup.getDetails", key , groupname); 
            gid = group["id"] 
            gid = gid.to_i
            s.call("system.setGroupMembership", key, systemid, gid , 1);
        rescue    
            raise Puppet::Error, "Group not found"
        end    
    end

    def destroy
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        groupname = resource[:name]
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        begin 
            group = s.call("systemgroup.getDetails", key , groupname); 
            gid = group["id"] 
            gid = gid.to_i
            s.call("system.setGroupMembership", key, systemid, gid , 0);
        rescue    
            raise Puppet::Error, "Group not found"
        end    

    end

    def exists?
        sathost = resource[:host]
        satuser = resource[:user]
        satpassword = resource[:password]
        groupname = resource[:name]
        s = XMLRPC::Client.new( sathost , "/rpc/api")
        key = s.call("auth.login", satuser, satpassword );
        hostname = Socket.gethostname
        if hostname =~ /(.*?)\./
            hostname = $1
        end
        systeminfo = s.call("system.getId", key, hostname );
        systemid = systeminfo[0]["id"]
        systemid = systemid.to_i
        grouplist = s.call("system.listGroups", key, systemid);
        grouplist.each { |group|
            if group["system_group_name"] == groupname and group["subscribed"] == 1
                return true
            end
        }    
        return false
    end
end
