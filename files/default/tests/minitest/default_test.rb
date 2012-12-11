describe_recipe "iptables::default" do
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources

    it "installs iptables package" do
        package("iptables").must_be_installed
    end

    it "installs rebuild-iptables script" do
        file("/usr/sbin/rebuild-iptables").must_exist.with(:mode, "755")
    end

    it "creates filter and nat directories in /etc/iptables.d" do
        %w{filter nat}.each do |table|
            directory("/etc/iptables.d/#{table}").must_exist
        end
    end

    it "adds iptables filter table rule all_established" do
        file("etc/iptables.d/filter/all_established").must_exist
        rule = %x{iptables-save}
            .split("\n")
            .grep(/-A FWR -m state --state RELATED,ESTABLISHED -j ACCEPT/)
        rule.size.must_be :==, 1
    end

    it "adds iptables filter table rule all_icmp" do
        file("etc/iptables.d/filter/all_icmp").must_exist
        rule = %x{iptables-save}
            .split("\n")
            .grep(/-A FWR -p icmp -j ACCEPT/)
        rule.size.must_be :==, 1
    end
end

# vim:et sw=4 ts=4 et
