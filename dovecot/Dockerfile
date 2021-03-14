FROM ubuntu:20.04
MAINTAINER FS-Physik <admins@fachschaft.physik.kit.edu>

# Installs dovecot
# composer and php libs are needed for pam-script-saml (see below)
# wget is an undocumented dependency.
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
 && apt-get install -y dovecot-imapd dovecot-sieve dovecot-managesieved \
                       wget unzip \
                       composer libpam-script \
                       php php-dom php-mbstring php-opcache \
                       php-dev libmcrypt-dev php-pear \
                       vim iputils-ping nmap \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# pam script for validating forwarded SAML2 assertion from SOGo
RUN pecl channel-update pecl.php.net && pecl install mcrypt-1.0.4
RUN sed -i 's/^\[PHP\]$/[PHP]\nextension=mcrypt.so/' /etc/php/7.4/cli/php.ini
RUN wget https://github.com/ck-ws/pam-script-saml/archive/master.zip \
        -O /opt/pam-script-saml.zip \
 && unzip /opt/pam-script-saml.zip -d /opt \
 && rm /opt/pam-script-saml.zip \
 && cd /opt/pam-script-saml-master \
 && composer install

# keycloak metadata
COPY idp-metadata.xml /opt/idp-metadata.xml
COPY pam-dovecot.conf /etc/pam.d/dovecot

COPY mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY logging.conf /etc/dovecot/conf.d/10-logging.conf
COPY auth-system.conf.ext /etc/dovecot/conf.d/auth-system.conf.ext
# System auth is needed for pam
#RUN echo "!include auth-ldap.conf.ext" > /etc/dovecot/conf.d/10-auth.conf \
 #&& echo "!include auth-system.conf.ext" >> /etc/dovecot/conf.d/10-auth.conf

RUN echo "!include auth-system.conf.ext" > /etc/dovecot/conf.d/10-auth.conf

EXPOSE 993
CMD /usr/sbin/dovecot -F
