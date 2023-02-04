#!/bin/bash

# need to edit /etc/nginx/sites-enabled/default-tls
# and set
#        server_name ${mydomain};

#        ssl_certificate /etc/letsencrypt/live/${mydomain}/fullchain.pem;
#        ssl_certificate_key /etc/letsencrypt/live/${mydomain}/privkey.pem;

mydomain=$1

if [ -z $mydomain ] ; then echo "must supply domainname" ; exit ; fi

sudo sed -i "s/server_name.*/server_name $mydomain;/" /etc/nginx/sites-available/default-tls
sudo sed -i "s/ssl_certificate .*/ssl_certificate \/etc\/letsencrypt\/live\/$mydomain\/fullchain.pem;/" /etc/nginx/sites-available/default-tls
sudo sed -i "s/ssl_certificate_key .*/ssl_certificate_key \/etc\/letsencrypt\/live\/$mydomain\/privkey.pem;/" /etc/nginx/sites-available/default-tls
