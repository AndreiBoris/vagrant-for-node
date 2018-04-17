echo "=================== Running php provisioning script (php.sh)"

echo "=================== Install php7 package repository..."
sudo apt-add-repository ppa:ondrej/php
sudo apt-get update

echo "******************* Installing mysql-server-5.5 dependency for php7, likely requires manual run..."
sudo apt-get install -y mysql-server-5.5

echo "=================== Install php7..."
sudo apt-get install -y php7.2 

echo "=================== Installing dependencies for running composer install"
sudo apt-get install -y zip unzip

echo "=================== Installing php7 packages..."
sudo apt-get install -y php7.2-mbstring php7.2-xml php7.2-curl php7.2-bcmath php7.2-soap php7.2-gd php7.2-zip

echo "=================== Install composer..."
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer