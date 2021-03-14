FROM ubuntu:20.04
MAINTAINER FS-Physik <admins@fachschaft.physik.kit.edu>

RUN apt-get update \
 && apt-get install -y gnupg apt-transport-https ca-certificates \
        supervisor nginx \
 && apt-key adv --keyserver hkp://keys.gnupg.net --recv-key 0x810273C4 \
 && echo "deb https://packages.inverse.ca/SOGo/nightly/5/ubuntu/ focal focal" > /etc/apt/sources.list.d/SOGo.list \
 && apt-get update \
 && ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
 && mkdir -p /usr/share/doc/sogo/ && touch /usr/share/doc/sogo/stub.sh \
 && apt-get install -y sogo sope4.9-gdl1-postgresql \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN usermod --shell /bin/sh sogo

COPY saml.key /etc/pki/tls/private/saml.key
COPY saml.pem /etc/pki/tls/certs/saml.pem
COPY sogo.conf /etc/sogo/sogo.conf
RUN chmod 644 /etc/sogo/sogo.conf /etc/pki/tls/private/saml.key /etc/pki/tls/certs/saml.pem

COPY setup.sh /setup.sh
COPY nginx-sogo-static.conf /etc/nginx/sites-available/sogo-static.conf
RUN rm /etc/nginx/sites-enabled/default \
 && ln -s  /etc/nginx/sites-available/sogo-static.conf /etc/nginx/sites-enabled/sogo-static.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
