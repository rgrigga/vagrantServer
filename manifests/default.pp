Exec{
    path => [
    '/usr/local/bin',
    '/opt/local/bin',
    '/usr/bin',
    '/usr/sbin',
    '/bin',
    '/sbin'],
    logoutput => true,
}

# Puppet configurations

class base {

## Update apt-get ##
  exec { 'apt-get update':
#    path    => "/usr/local/bin/:/usr/bin/:/bin/",
#    command => 'apt-get update'
      command => '/usr/bin/apt-get update'

  }
}

# class http{
#    package { "apache2":
#        ensure => present,
#    }

#    service { "apache2":
#        ensure => running,
#        require => Package["apache2"],
#    }
#}

class http {
  define apache::loadmodule () {
    exec { "/usr/sbin/a2enmod $name" :
      unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
      notify => Service["apache2"]
    }
  }

  apache::loadmodule{"rewrite":}

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }
}

class php{

  package { "php5":
    ensure => present,
  }

  package { "php5-cli":
    ensure => present,
  }

  package { "php5-xdebug":
    ensure => present,
  }

  package { "php5-mysql":
    ensure => present,
  }

  package { "php5-imagick":
    ensure => present,
  }

  package { "php5-mcrypt":
    ensure => present,
  }

  package { "php-pear":
    ensure => present,
  }

  package { "php5-dev":
    ensure => present,
  }

  package { "php5-curl":
    ensure => present,
  }

  package { "php5-sqlite":
    ensure => present,
  }

  package { "libapache2-mod-php5":
    ensure => present,
  }

}

class mysql{

  $mysqlPassword = "root"
  $database = "agrivault"

  package { "mysql-server":
    ensure => present,
  }

  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }

#  exec
#  {
#    "set-mysql-password":
#    onlyif => "mysqladmin -uroot -proot status",
#    command => "mysqladmin -uroot -proot password $mysqlPassword",
#    require => Service["mysql"],
#  }

#  exec
#  {
#    "create-default-db":
#    unless => "/usr/bin/mysql -uroot -p$mysqlPassword $database",
#    command => "/usr/bin/mysql -uroot -p$mysqlPassword -e 'create database `$database`;'",
#    require => [Service["mysql"], Exec["set-mysql-password"]]
#  }

#  exec
#  {
#    "grant-default-db":
#    command => "/usr/bin/mysql -uroot -p$mysqlPassword -e 'grant all on `$database`.* to `root@localhost`;'",
#    require => [Service["mysql"], Exec["create-default-db"]]
#  }

}

class phpmyadmin
{

    package
    {
        "phpmyadmin":
            ensure => present,
            require => [
                Exec['apt-get update'],
                Package["php5", "php5-mysql", "apache2"]
            ]
    }

    file
    {
        "/etc/apache2/conf-enabled/phpmyadmin.conf":
            ensure => link,
            target => "/etc/phpmyadmin/apache.conf",
            require => [Package['apache2'],Service['mysql']],
            notify => Service["apache2"]
    }

}
class composer
{
  exec { "composer show":
#    path    => "/usr/local/bin/:/usr/bin/:/bin/",
    command => "/usr/local/bin/composer licenses"
  }
}
include base
include http
include php
include mysql
include phpmyadmin
# include composer

# do not install phpunit via pear!
# instead, use composer
# see https://github.com/sebastianbergmann/phpunit/wiki/End-of-Life-for-PEAR-Installation-Method

