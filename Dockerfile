FROM ubuntu:18.04
MAINTAINER jmadrazo97 <jmadrazo7@gmail.com>

ENV POSTGRES_VERSION 9.3

# Installing packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor apache2 php7.3 php7.3-xml
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main $POSTGRES_VERSION" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install postgresql-$POSTGRES_VERSION postgresql-client-$POSTGRES_VERSION postgresql-contrib-$POSTGRES_VERSION php7.3-pgsql
RUN apt-get clean
RUN echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf

# Scripts
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-apache2.sh /supervisord-apache2.sh
ADD start.sh /start.sh
RUN chmod 755 /*.sh

# PHP application folder
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

EXPOSE 80 
CMD ["/start.sh"]