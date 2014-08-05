<style>
    .onion{
        padding-left:10px;
        background-color:rgba(30,30,30,.2);
    }
</style>
<h2>Installation</h2>
<h3>Overview/Quickstart</h3>
<p>There are many ways to skin a cat, but the following method should work on any platform (Window$, Mac, Linux).
    The first few steps describe a minimal local machine setup with ubuntu; The actual project-specific setup (Phase 4: assuming you have an operating system with vagrant and VirtualBox installed, and are already connected to bitbucket) will take about 10 minutes.</p>
<p>If you're familiar with this process, all you need is explained in the following diagram:</p>
<div class="onion">
    Phase 1: fresh os
    <div class="onion">
        Phase 2: install git php, setup ssh
        <div class="onion">
            Phase 3: install vagrant & virtualbox
            <div class="onion">
                Phase 4: Clone repo & Boot it
                <div><code>git clone git:myrepo/myproject.git</code></div>
                <div><code>vagrant up</code></div>
                <div><code>vagrant ssh</code></div>
                <div><code>cd /vagrant</code></div>
                <div><code>sudo su</code></div>
                <div><code>puppet apply manifests/default.php</code></div>
                <div><code>service apache2 start</code></div>
                <div><code>dpkg-reconfigure phpmyadmin</code></div>
                <div class="onion">
                    <div class="badge">within the vm</div>
                    <div><code>cd /vagrant</code></div>
                    <p>Phase 5: Migrations</p>
                    <p><code>php artisan migrate</code></p>
                    or something like this:
                    <p><code>mysql -u root -proot agrivault < ~/vagrant/data/agrivault.sql</code></p>


                    <p>After the installation, run: <code>sudo dpkg-reconfigure phpmyadmin</code></p>
                    <p>Be sure to use root/root (for example)</p>
                    <p><code>sudo service mysql restart</code></p>

                    <p>
                    <p>When importing a database, if you get an error regarding the filesize being too large, this may be helpful:</p>
                    <pre><code>sudo nano /etc/php5/apache2/php.ini</code></pre>

                    <p>search for and change these three lines:</p>
<pre><code>
        upload_max_filesize=2M
        memory_limit=128M
        post_max_size=8M
    </code></pre>
                    <p>Consider setting them to 20MB for small files, or 100MB for the entire rfd table, for example</p>
<pre><code>
        upload_max_filesize=20M
        memory_limit=256M
        post_max_size=20M
    </code></pre>
                    <p>Finally, run:</p>
                    <pre><code>sudo service apache2 restart</code></pre>
                    </p>
                    <p>Manually Download the db from the remote server</p>
                    <p>login to phpmyadmin and import your database.</p>
                </div>
            </div>
        </div>
    </div>
</div>
<p>Our goal is to go from zero to a fully functional local development environment in just a few clicks/commands.
    To someone with no experience, troubleshooting installation problems, server configuration, ssh keys, WAMP, LAMP, XAMPP, Apache, VirtualHosts, etc. can be daunting.
    The process explained below should yield a fully functional local development environment server with:</p>
<ul>
    <li>Most recent php (~5.5, or we can specify any version: more on that later)</li>
    <li>Necessary php extensions (mcrypt, for exapmple)</li>
    <li>Apache 2.4 with modRewrite and Virtual Hosts configured to respond to av2.dev and local.agrivault.com</li>
    <li>MySQL (username:root password: root)</li>
    <li>phpMyAdmin (username:root password: root)</li>
    <li>A fully populated local 'agrivault' database</li>
    <li>Many other development tools/pre-requisites, like
        <ul>
            <li>node.js</li>
            <li>bower</li>
            <li>bootstrap</li>
            <li>less.js</li>
            <li>font-awesome</li>
        </ul>
    </li>
</ul>
<h4>Phase One</h4>
<dl>
    <dt>Install operating system</dt>
    <dd>
        <a href="http://www.ubuntu.com/download/desktop/install-ubuntu-desktop" title="http://www.ubuntu.com/download/desktop/install-ubuntu-desktop">Install Ubuntu</a>
    </dd>
</dl>
<h4>Phase 2</h4>
<dl>
    <dt>install git, php</dt>
    <dd><code>sudo apt-get install php5</code></dd>
    <dd><code>sudo apt-get install </code></dd>
</dl>
<dl>
    <dt>Install VirtualBox </dt>
    <dd>
        <a href="https://www.virtualbox.org/wiki/Downloads" title="https://www.virtualbox.org/wiki/Downloads">Virtualbox</a>
        <p>note: you should do this one manually on Ubuntu, because the software center will install v1.4.1 -- you want v1.4.3</p>
        <p>Don't worry, it's easy.</p>
    </dd>
    <dt>Install Vagrant </dt>
    <dd>
        <a href="http://www.vagrantup.com/downloads.html">make vagrant up yours</a>
    </dd>

    <dt>* Configure Local System</dt>
    <dd>* install basic local requirements, like:
        <ul>
            <li><code>sudo apt-get install git</code></li>
            <li><code>sudo apt-get install php5-cli</code></li>
        </ul>
    </dd>
    <dd>* install things like:
        <ul>
            <li>
                <a href="http://www.jetbrains.com/phpstorm/">install phpStorm</a>
            </li>
            <dt>Install phpStorm </dt>
        </ul>
    </dd>
    <dd></dd>
</dl>
<p>* Please note: this method was developed on a completely fresh machine with no operating system.  I installed a fresh copy of Ubuntu 14.04, set up nothing beyond the logical installation process provided by the installation wizard (a single user with a password).  The only real local requirements are : [ git,php ]</p>
<h4>Phase Two</h4>
<p>At this point, you should have VirtualBox and Vagrant</p>
<dl>
    <dt>Set up local ssh key</dt>
    <dd>
        <p>Your local ssh key will 'pass-through' to the vagrant machine.</p>
    </dd>
    <dt>Connect to bitbucket</dt>
    <dd>
        <p>If you need help with this, contact your nearest Viviosoft colleague</p>
    </dd>

    <dt>Clone the project(s)</dt>
    <dd>av2</dd>
    <dd>agrivault</dd>
</dl>
<h4>Phase 3</h4>
<dl>
    <dt>Clone the project(s)</dt>
    <dd>av2</dd>
    <dd>agrivault</dd>
    <dd><code>vagrant up</code></dd>
    <dd><code>composer update</code></dd>
    <dd><code>php artisan migrate</code></dd>
</dl>

<h4>Prerequisites</h4>
<ul>
    <li>VirtualBox </li>
    <li>Vagrant </li>
    <li>phpStorm (optional)</li>
    <li>Clone the project(s) ('av2' and/or 'agrivault')</li>
</ul>
<p>Personally, I clone my projects in a structure like this:</p>
<pre>/home/ryan/Code
├── MyApp6
├── MyApp7
├── node_modules
├── testproject
│   ├── bootstrap.sh
│   ├── hosts
│   ├── public
│   └── Vagrantfile
└── viviosoft
    ├── agrivault
    └── av2
</pre>
<p>More detail:</p>
<p>ps: I removed most of the agrivault files from this tree to illustrate the subject of this article; the actual projects of course have many more files.</p>
<pre>ryan@Lenbuntu:~/Code$ tree ~/Code/viviosoft -L 2
/home/ryan/Code/viviosoft
├── agrivault
│   ├── account-display-info.php
│   ├── account-manage.php
│   ├── account-profile.php
│   ├── ...
│   ├── bootstrap.sh
│   ├── index.php
│   ├── phpinfo.php
│   ├── test.php
│   ├── Vagrantfile
└── av2
    ├── after.sh
    ├── app
    ├── artisan
    ├── bootstrap
    ├── bootstrap.sh
    ├── bower.json
    ├── composer.json
    ├── composer.lock
    ├── CONTRIBUTING.md
    ├── error_log
    ├── manifests
    ├── phpunit.xml
    ├── project.sh
    ├── public
    ├── readme.md
    ├── server.php
    ├── Vagrantfile
    └── vendor
</pre>
<p>Once those are complete, </p>
<h2>more (How do I...)</h2>
<p>the commands explained are relative to ~$ if you are local, or ~/vagrant if you are on vagrant</p>
<h3>Install Laravel?</h3>
<pre><code>composer create-project laravel/laravel av2 --prefer-dist</code></pre>

<h3>configure .gitignore?</h3>
<h4>phpStorm</h4>
<pre><code> .idea/
        .idea
        .idea/workspace.xml
        workspace.xml
    </code></pre>

<h3>Configure local server for "av2.dev"?</h3>
<pre>    cd /etc/apache2/sites-available
    sudo cp ag.dev.conf av2.dev.conf
    sudo nano av2.dev.conf
</pre>

(make your changes)

<pre>    sudo a2ensite av2.dev
    sudo service apache2 reload
    sudo nano /etc/hosts
</pre>

(add line for av2.dev)
<pre>    sudo chmod -R 777 ~/viviosoft/av2/storage
</pre>
If all above goes well, the browser should respond to http://av2.dev

<h2>Version Control</h2>
<p>Configured for git, bitbucket, and phpstorm</p>
<ul>
    <li>
        <a href="https://bitbucket.org/dclem/agrivault-v1.0">Bitbucket</a>
    </li>
</ul>