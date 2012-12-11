ENV["BERKSHELF_PATH"] = File.expand_path(".") + "/.berkshelf"
require "berkshelf/vagrant"

Vagrant::Config.run do |config|
    config.vm.box = "centos6"
    config.vm.box_url = "http://c338540.r40.cf1.rackcdn.com/centos6.box"

    config.vm.define :iptables do |ip|
        ip.vm.host_name = "iptables.localhost"
        ip.vm.network :hostonly, "192.168.1.2"
    end
    
    config.vm.provision :chef_solo do |chef|
        chef.add_recipe("iptables")
    end
end

# vim:et sw=4 ts=4 fdm=marker ft=ruby
