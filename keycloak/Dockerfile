FROM ubuntu:20.04
MAINTAINER Lars Franke <lars@fachschaft.physik.kit.edu>

ENV KEYCLOAK_VERSION=12.0.4

RUN apt-get update -y \
 && apt-get install -y wget openjdk-8-jdk-headless \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN wget -q -O keycloak.tar.gz \
        "https://github.com/keycloak/keycloak/releases/download/${KEYCLOAK_VERSION}/keycloak-${KEYCLOAK_VERSION}.tar.gz" \
 && tar xf keycloak.tar.gz \
        --directory /opt \
 && mv /opt/keycloak-* /opt/keycloak \
 && rm keycloak.tar.gz

WORKDIR /opt/keycloak

COPY standalone.xml standalone/configuration/standalone.xml
COPY setup.sh /setup.sh
CMD /setup.sh
