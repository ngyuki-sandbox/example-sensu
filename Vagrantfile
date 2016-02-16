Vagrant.configure(2) do |config|
  config.vm.box = "ngyuki/centos-7"
  #config.vm.box = "bento/centos-7.1"
  config.ssh.insert_key = false
  config.ssh.forward_agent = true

  config.vm.define "sensu" do |config|
    config.vm.hostname = "sensu"
    config.vm.network "forwarded_port", guest: 3000, host: 3000
    config.vm.network "forwarded_port", guest: 3001, host: 3001
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 8083, host: 8083
    config.vm.network "forwarded_port", guest: 8086, host: 8086
    config.vm.network "private_network", ip: "192.168.33.10", virtualbox__intnet: "sensu"
  end

  config.vm.define "sv01" do |config|
    config.vm.hostname = "sv01"
    config.vm.network "private_network", ip: "192.168.33.11", virtualbox__intnet: "sensu"
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo yum -y install vim-enhanced mailx nc rsync patch epel-release
    sudo yum -y install ansible jq
    sudo cp /vagrant/hosts.ini /etc/ansible/hosts
    sudo chmod -x /etc/ansible/hosts
  SHELL

  config.vm.provider :virtualbox do |v|
    v.linked_clone = true
    v.memory = "2048"
  end
end
