FROM ubuntu:latest
MAINTAINER sunny <tufeiping@gmail.com>

# Install dependencies packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql openssh-server unzip curl php5-curl

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD start-sshd.sh /start-sshd.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
ADD supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
RUN chmod 755 /*.sh

# Config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

RUN mkdir -p /dzz && rm -fr /var/www/html && ln -s /dzz /var/www/html

# Download DzzOffice
RUN wget http://down.dzzoffice.com/dzzoffice1.0/dzzoffice1.0_SC_UTF8_Release20140513.zip -O /tmp/dzzoffice.zip 
RUN unzip /tmp/dzzoffice.zip

# Deploy DzzOffice
RUN cp -rf /dzzoffice1.0_SC_UTF8/upload/* /dzz

RUN chmod -R 777 /dzz/core/config
RUN chmod -R 777 /dzz/data

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:123456'|chpasswd
ADD sshd_config /etc/ssh/sshd_config

EXPOSE 80 3306 22

CMD ["/run.sh"]
