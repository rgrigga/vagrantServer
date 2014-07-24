# /manifests/mysql.pp
class myclass
{
  file {'testfile':
    path    => '/tmp/testfile',
    ensure  => present,
    mode    => 0640,
    content => "I'm a test file.",
  }

  file {'testfile2':
    path    => '/tmp/testfile2',
    ensure  => absent,
  }
  file {'/tmp/test1':
    ensure  => present,
    content => "Hi.",
  }
  notify {'/tmp/test1 has already been synced.':
    require => File['/tmp/test1'],
  }
}

class base {
  ## Update apt-get ##
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
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

class phpmyadmin
{

  package { "apache2":
    ensure => present,
  }

  service { "apache2":
    ensure => running,
    require => Package["apache2"],
  }

  package { "mysql-server":
    ensure => present,
  }

  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }
  package
  {
    "phpmyadmin":
    ensure => present,
    require => [
    Exec['apt-get update'],
    Package["php5", "php5-mysql", "apache2", "mysql-server"]
    ]
  }

  file
  {
    "/etc/apache2/conf-enabled/phpmyadmin.conf":
    ensure => link,
    target => "/etc/phpmyadmin/apache.conf",
    require => Package['apache2'],
    notify => Service["apache2"]
  }


}
class agdb
{

  $mysqlPassword = "root"
  $database = "agrivault"

#  exec
#  {
#    "set-mysql-password":
#    onlyif => "mysqladmin -uroot -proot status",
#    command => "mysqladmin -uroot -proot password $mysqlPassword",
#    require => Service["mysql"],
#  }

  exec
  {
    "create-default-db":
    unless => "/usr/bin/mysql -uroot -p$mysqlPassword $database",
    command => "/usr/bin/mysql -uroot -p$mysqlPassword -e 'create database `$database`;'",
    require => [Service["mysql"]]
#    require => [Service["mysql"], Exec["set-mysql-password"]]
  }

  exec
  {
    "grant-default-db":
    command => "/usr/bin/mysql -uroot -p$mysqlPassword -e 'grant all on `$database`.* to `root@localhost`;'",
    require => [Service["mysql"], Exec["create-default-db"]]
  }

}

include base
include myclass
include php
include phpmyadmin
include agdb