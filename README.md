# README #

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