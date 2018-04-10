# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8881, host: 8881

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.44.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "../shared", "/home/vagrant/shared"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "1024"
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    echo "Provisioning Virtual Machine..."
    sudo apt-get update

    echo "Installing developer packages..."
    sudo apt-get install build-essential curl vim -y > /dev/null

    echo "Installing Git..."
    sudo apt-get install git -y > /dev/null

    echo "Installing Node and NVM..."
    curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
    source ~/.nvm/nvm.sh
    nvm install node
    nvm alias default node

    echo "Installing Oh My Zsh..."
    sudo apt-get install -y zsh
    wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh 
    sudo chsh -s /bin/zsh vagrant
    zsh

    echo "Changing default Oh My Zsh theme to new theme..."
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="flazz"/g' ~/.zshrc

    echo "Adding locales used on host to avoid Perl errors..."
    sudo locale-gen en_US.UTF-8
    sudo locale-gen en_CA.UTF-8

    echo "Add plugins to zsh..."
    source ~/.zshrc
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    # Doesn't work unfortunately, not sure why. 
    # However, we can run the command after sshing into the box
    perl -0777 -i.original -pe 's/^plugins=\(\n\s*git\n\)/plugins=\(git z zsh-autosuggestions zsh-syntax-highlighting\)/igsm' ~/.zshrc


    cd /vagrant

    echo "Installing Node dependencies..."
    npm install -g webpack
    # npm install
  SHELL
end
