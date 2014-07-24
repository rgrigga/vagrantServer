#!/usr/bin/env bash

echo ">>> Starting Install Script"

# Update
sudo apt-get update

# Install MySQL without prompt
# moved below
# sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
# sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

echo ">>> Installing Base Items"

# Install base items
sudo apt-get install -y vim tmux curl wget build-essential python-software-properties

#!/usr/bin/env bash

# Update the box
# --------------
# Downloads the package lists from the repositories
# and "updates" them to get information on the newest
# versions of packages and their dependencies

#FIRST RUN STUFF

echo "--- Installing php, apache ---"
sudo add-apt-repository -y ppa:ondrej/php5
sudo apt-get update
sudo apt-get install wget

apt-get install -y apache2
apt-get install -y php5
apt-get install -y libapache2-mod-php5
apt-get install -y php5-cli
apt-get install -y php5-mysql
apt-get install -y php5-curl
apt-get install -y php5-mcrypt
apt-get install -y php5-dev
apt-get install -y php5-xdebug
apt-get install -y  php-apc
apt-get install -y php5-gd
apt-get install -y php-pear
apt-get install -y libcurl3-openssl-dev
pecl install -y pecl_http
pecl install -y oauth
apt-get install -y libpcre3-dev
apt-get install -y make
apt-get install -y curl

echo "--- Installing Composer ---"

curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

echo "--- Installing mysql ---"

echo "see also https://www.debian.org/releases/stable/i386/apbs03.html.en"

export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
apt-get -q -y install mysql-server-5.5
apt-get install -y git
apt-get install -y zsh

#END FIRST RUN STUFF

echo "--- Installing xdebug ---"

cat << EOF | sudo tee -a /etc/php5/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

echo "--- Enabling mod-rewrite ---"
sudo a2enmod rewrite

echo "--- Installing node.js ---"
sudo apt-get update
sudo apt-get install -y  python g++ make

sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y  nodejs
# bower
echo "--- Installing npm and bower ---"
#apt-get install -y nodejs
apt-get install -y npm
sudo npm install -g bower
echo "--- Installing bootstrap, font-awesome, and less ---";
bower install bootstrap --allow-root
bower install fontawesome --allow-root
bower install less --allow-root

# Remove /var/www default
rm -rf /var/www
# Symlink /vagrant to /var/www
ln -fs /vagrant/public /var/www

echo "--- Setting error reporting ---"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Laravel stuff here, if you want

echo "--- Setting up Virtualhosts ---"

# Add ServerName to httpd.conf
echo "ServerName localhost" > /etc/apache2/httpd.conf
# Setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/vagrant/public"
  ServerName localhost
  # RewriteEngine On
  <Directory "/vagrant/public">
    # Options Indexes Includes FollowSymLinks MultiViews
    Require all granted
    AllowOverride All
  </Directory>
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot /viviosoft/agrivault
    ServerName local.agrivault.com
    ServerAlias ag.dev
    RewriteEngine On

    <Directory "/viviosoft/agrivault">
      Options Indexes Includes FollowSymLinks MultiViews
      AllowOverride All
      Require all granted
    </Directory>

</VirtualHost>

<VirtualHost *:80>
    DocumentRoot /viviosoft/av2/public
    ServerName av2.dev
    RewriteEngine On

    <Directory "/viviosoft/av2/public">
      Options Indexes Includes FollowSymLinks MultiViews
      AllowOverride All
      Require all granted
    </Directory>

</VirtualHost>

<VirtualHost *:80>
    DocumentRoot /viviosoft/vs
    ServerName local.vs2.com
    ServerAlias vs2.dev
    RewriteEngine On
    <Directory "/viviosoft/vs">
      Options Indexes Includes FollowSymLinks MultiViews
      AllowOverride All
      Require all granted
    </Directory>
</VirtualHost>

# Add more virtualhosts here
EOF
)

sed -i "s@DocumentRoot /var/www/html@DocumentRoot /var/www/@g" /etc/apache2/sites-available/000-default.conf
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf
# Enable mod_rewrite
a2enmod rewrite
# Restart apache
service apache2 restart


echo ">>> Finished Install Script bootstrap.sh"
echo ">>> A FEW MORE THINGS:
echo " - be sure to add vivio.dev to your local /etc/hosts file!"
echo " you might want to run 'puppet apply manifests/default.pp' or something like it"
echo " - You may need to run sudo dpkg-reconfigure phpmyadmin after"
echo " after installing phpmyadmin..."
echo " CLEAR COOKIES AND CACHE "

# vagrant up
# vagrant ssh
# cd /vagrant
# sudo puppet apply manifests/default.pp
# sudo service apache2 start
# sudo dpkg-reconfigure phpmyadmin
# add a user with
# mysqladmin -proot reload
