$init = <<INIT
apt-get update
apt-get install -y ruby ruby-dev gcc git python-dev libffi-dev libssl-dev build-essential automake libtool pkg-config python-pip python-virtualenv
gem install fpm
INIT

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision "shell", inline: $init

  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box = "cybera/ubuntu-trusty"
  end

end
