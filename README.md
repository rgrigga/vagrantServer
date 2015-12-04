# README #

You might call this package a "mini-clone" of Laravel Homestead... although it is not directly tied to Homestead.  let me explain:

This package was created because I wanted to run laravel Homestead on several machines, one of which was a weak 32-bit windows machine.  At the time, Homestead would not work for me, apparently on 32-bit.  So I wrote my own vagrant file and puppet scripts... along with phpmyadmin and some other goodies, with the goal of replicating the functionality of Homestead.

I have since moved on to using the "real" Homestead package, but I learned a lot from the process of digging into the guts of what's going on.  I am no longer maintaining or using this package, but it stands an example for reference regarding various principles, for better or for worse.

## Prerequisites ##
* Vagrant
* Virtualbox
* Local ssh key (rsa)

    ssh-keygen -t rsa

## After Install ##

    vagrant ssh
    sudo puppet apply manifests/default.pp
    sudo service apache2 start
    sudo dpkg-reconfigure phpmyadmin

### Your hosts file ###
on windows, edit

    /c/Windows/System32/drivers/etc/hosts
    
on Linux/Mac, edit

    /etc/hosts
    
Include a line like this:

    192.168.50.99    vagrant.dev

### mysql ###

You may need to login to vagrant, and run the following:

    sudo nano /etc/mysql/my.cnf

with nano, press ctl-w, then search for `skip-external`

comment out skip-extenal locking like this: (add a `#`)

    #skip-external-locking

change this:

    bind-address            = 127.0.0.1

to this:

    bind-address            = 0.0.0.0

*this is not secure for production, but allow you to use the vagrant database, for example, from within a cakephp application.  Your Config/database.php might look like this:

    public $dev = array(
        'datasource' => 'Database/Mysql',
        'persistent' => false,
        'host' => '192.168.50.99',
        'login' => 'root',
        'password' => 'root',
        'database' => 'vs4',
        'prefix' => '',
        //'encoding' => 'utf8',
    );



### phpmyadmin ###
* username: root
* password: root

### What is this repository for? ###

* A VagrantFile, .sh script, and a few puppet scripts.
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

    vagrant up
    vagrant ssh
    cd /vagrant

* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact
