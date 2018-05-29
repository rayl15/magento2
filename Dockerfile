FROM sourcefuse/dealerxtension-base:v3

MAINTAINER Rahul Sharma <rahul.sharma@sourcefuse.com>

#Newrelic installation comment lines to disbale newrelic on next build
RUN apt-get update && \
apt-get install -y wget
# Install New Relic
#RUN apt-get update && \
#    apt-get -yq install wget && \
#    wget -O - https://download.newrelic.com/548C16BF.gpg | apt-key add - && \
#    echo "deb http://apt.newrelic.com/debian/ newrelic non-free" > /etc/apt/sources.list.d/newrelic.list

# Setup environment variables for initializing New Relic
#ENV NR_INSTALL_SILENT 1
#ENV NR_INSTALL_KEY 5a6b0dea687acd246612630ec59261b106d16b86

#RUN apt-get update 
#RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install newrelic-php5
# We need to copy the New Relic config AFTER we installed the PHP extension
# or we get warnings everywhere about the missing PHP extension.
#COPY ./conf/newrelic/20-newrelic.ini /etc/php/7.0/cli/conf.d/20-newrelic.ini 
#COPY ./conf/newrelic/newrelic.cfg /etc/newrelic/newrelic.cfg


RUN rm -rf /etc/nginx/nginx.conf && \
rm -rf /etc/php/7.0/fpm/php-fpm.conf \
rm -rf /etc/php/7.0/cli/php.ini 

    

COPY ./conf/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/php-fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf 
COPY ./conf/php.ini/php.ini /etc/php/7.0/fpm/php.ini
COPY ./conf/php.ini/php.ini /etc/php/7.0/cli/php.ini
COPY ./conf/super/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD . /var/www/html/
RUN cd /var/www/html/ 
RUN cd /var/www/html/ && find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod g+w {} \;
#RUN chmod 777 /var/www/html/conf/newrelic/start.sh 




