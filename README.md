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
    

on windows, edit

    /c/Windows/System32/drivers/etc/hosts
    
on Linux/Mac, edit

    /etc/hosts
    
Include a line like this:

    192.168.50.99    vagrant.dev

### mysql ###
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