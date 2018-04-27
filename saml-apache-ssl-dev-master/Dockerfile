FROM debian:jessie
MAINTAINER Charles Cahill <charles.cahill@ge.com>

## Open Proxy
ENV DEBIAN_FRONTEND noninteractive
#ENV http_proxy http://http-proxy.consind.ge.com:8080
#ENV https_proxy http://http-proxy.consind.ge.com:8080
ENV no_proxy ge.com

## install software
RUN apt-get update && \
    apt-get install -y git supervisor curl apache2 libapache2-mod-shib2 && \
    apt-get clean
RUN a2enmod alias env headers proxy proxy_http proxy_ajp proxy_balancer lbmethod_byrequests shib2 status ssl ldap authnz_ldap proxy_wstunnel rewrite

RUN shib-keygen

#Remove any potential "default" sites available.
RUN rm -rf /etc/apache2/sites-available/*

#Move all configuration files into place and create log files for Apache
COPY container-files/ /
WORKDIR /var/log/apache2
RUN ln -sf /var/log/apache2/access.log /dev/stdout
RUN ln -sf /var/log/apache2/error.log /dev/stderr

#Configures and starts supervisor and allows for custom boot options.
RUN chmod +x /config/bootstrap.sh
ENTRYPOINT ["/config/bootstrap.sh"]

EXPOSE 443

# Copy script to place apache config files into image and provide CMD to execute start script upon run of image.
CMD /start-apache.sh
COPY start-apache.sh /
