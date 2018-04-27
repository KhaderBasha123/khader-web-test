#!/bin/bash -x

 # Make sure /etc/apache2 exists and if so copy down config branch to root
if [ -d /etc/apache2 ]; then
 echo "Cloning IdP configs directory and checking out ${WEBSERVER_HOST} branch"
  pushd /
  git clone https://github.appl.ge.com/tas/saml-apache-configs.git
  cd saml-apache-configs
  git checkout --track origin/${WEBSERVER_HOST}
  if [ $? -ne 0 ]; then
    echo "Could not find configs for ${WEBSERVER_HOST}, aborting"
    exit 1
  fi
  # echo "copying GE-specific apache and shibboleth files into place use by the base Apache image"
  cp -pr /saml-apache-configs/apache2 /etc/
  cp -pr /saml-apache-configs/shibboleth /etc/
  popd

  # generate ssl cert for use by the Apache Image
   #mkdir /etc/apache2/ssl
   #cd /etc/apache2/ssl
   #echo "creating webserver cert "
   #openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout apache.key -out apache.crt -subj "/C=US/ST=Kentucky/L=Louisville/O=General Electric/OU=GE Appliances/CN=${WEBSERVER_HOST}.al.ge.com"
  
  fi
