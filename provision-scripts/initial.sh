echo "=================== Running initial provisioning script (initial.sh)"

echo "=================== Provisioning Virtual Machine..."
sudo apt-get update

echo "=================== Installing developer packages..."
sudo apt-get install build-essential curl vim -y > /dev/null

if ! [ -x "$(command -v git)" ]; then
    echo "=================== Install git..."
    sudo apt-get install git -y > /dev/null 
else 
    echo "=================== git already installed..."
fi

if ! [ -x "$(command -v node)" ]; then
    echo "=================== Install node version 8..."
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    # curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
    sudo apt-get install -y nodejs
else 
    echo "=================== node already installed..."
fi

if ! [ -x "$(command -v npm)" ]; then
    echo "=================== Install npm command..."
    sudo apt-get install npm -y
else 
    echo "=================== npm command already installed..."
fi



echo "=================== Installing Oh My Zsh..."
sudo apt-get install -y zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo "=================== Changing default Oh My Zsh theme to new theme..."
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="flazz"/g' ~/.zshrc

echo "=================== Add plugins to zsh..."
path_to_zsh_autosuggestions_directory="/home/vagrant/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
path_to_zsh_syntax_highlighting_directory="/home/vagrant/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
if ! [ -d "$path_to_zsh_autosuggestions_directory" ]; then 
    git clone https://github.com/zsh-users/zsh-autosuggestions $path_to_zsh_autosuggestions_directory
fi 
if ! [ -d "$path_to_zsh_syntax_highlighting_directory" ]; then 
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $path_to_zsh_syntax_highlighting_directory
fi 


echo "=================== Adding locales used on host to avoid Perl errors..."
sudo locale-gen en_US.UTF-8
sudo locale-gen en_CA.UTF-8

# Doesn't work unfortunately, not sure why. 
# However, we can run the following command after sshing into the box
echo "=================== Copying .zshrc and .vimrc configuration files into Virtual Machine..."
cp /vagrant/environment/.zshrc ~/.zshrc
cp /vagrant/environment/.vimrc ~/.vimrc

if ! [ -x "$(command -v yarn)" ]; then
    echo "=================== Installing Yarn..."
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn
else 
    echo "=================== yarn command already installed..."
fi


symbolic_link_to_make="/usr/bin/node"
if ! [ -f "$symbolic_link_to_make" ]; then 
    echo "=================== Creating symlink to allow programs to use node command instead of nodejs"
    sudo ln -s /usr/bin/nodejs "$symbolic_link_to_make"
else 
    echo "=================== symlink to allow programs to use node command instead of nodejs already exists"
fi 
# npm install

echo "=================== Launching Zsh..."
sudo chsh -s /bin/zsh vagrant
zsh


if ! [ -x "$(command -v tree)" ]; then
    echo "=================== Install tree command..."
    cd ~
    wget http://mama.indstate.edu/users/ice/tree/src/tree-1.7.0.tgz
    tar -xvzf tree-1.7.0.tgz
    cd tree-1.7.0
    sudo make
    sudo make install
else 
    echo "=================== tree command already installed..."
fi