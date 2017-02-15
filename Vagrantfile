# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "scotch/box"
  config.vm.network "forwarded_port", guest: 80, host: 4567
  config.vm.network "forwarded_port", guest: 27017, host: 27017
  config.vm.network "private_network", ip: "192.168.33.10"
  config.vm.hostname = "itk-api"
  config.vm.synced_folder "/Users/josefsekava/localhost/itk-api", "/var/www/itk.dev", :mount_options => ["dmode=777", "fmode=666"]

  # Optional NFS. Make sure tso remove other synced_folder line too
  #config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=666"] }

  config.vm.provision "shell", inline: <<-SHELL

        ## Only thing you probably really care about is right here
        DOMAINS=("itk.dev")

        ## Loop through all sites
        for ((i=0; i < ${#DOMAINS[@]}; i++)); do

            ## Current Domain
            DOMAIN=${DOMAINS[$i]}

            echo "Creating directory for $DOMAIN..."
            mkdir -p /var/www/$DOMAIN/www

            echo "Creating vhost config for $DOMAIN..."
            sudo cp /etc/apache2/sites-available/scotchbox.local.conf /etc/apache2/sites-available/$DOMAIN.conf

            echo "Updating vhost config for $DOMAIN..."
            sudo sed -i s,scotchbox.local,$DOMAIN,g /etc/apache2/sites-available/$DOMAIN.conf
            sudo sed -i s,/var/www/public,/var/www/$DOMAIN/www,g /etc/apache2/sites-available/$DOMAIN.conf

            echo "Enabling $DOMAIN. Will probably tell you to restart Apache..."
            sudo a2ensite $DOMAIN.conf

            echo "So let's restart apache..."
            sudo service apache2 restart

        done

  SHELL
end
