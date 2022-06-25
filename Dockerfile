FROM php:8.0.2-apache

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y vim
RUN apt-get install -y git
RUN cd ~
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN HASH=`curl -sS https://composer.github.io/installer.sig`
RUN php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN chmod 644 -R /var/www/html/
RUN apt-get install zip unzip
RUN docker-php-ext-install mysqli pdo pdo_mysql

COPY . /var/www/html

# RUN cd /var/www/html/laravel_test
# RUN php artisan serve