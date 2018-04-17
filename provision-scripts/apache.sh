echo "=================== Running apache provisioning script (apache.sh)"

echo "=================== Install Apache2..."
sudo apt-get install -y apache2
sudo a2enmod rewrite
sudo service apache2 restart