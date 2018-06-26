FROM debian:stretch-slim

RUN echo "Installing base dependencies" && \
    apt-get update && \
    apt-get install -y apt-transport-https lsb-release wget ca-certificates && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list && \
    apt-get update && \
    apt-get install -y php7.2-cli php7.2-fpm php7.2-bcmath php7.2-soap php7.2-zip php7.2-bz2 php7.2-gmp php7.2-gd php7.2-intl php7.2-imagick php7.2-redis php7.2-pdo-mysql && \
    apt-get remove -y lsb-release wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "Fix up fpm config" && \
    sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/7.2/fpm/php-fpm.conf && \
    sed -i 's/listen =.*/listen = \/run\/php\/php.sock/' /etc/php/7.2/fpm/pool.d/www.conf && \
    sed -i 's/;access.log =.*/access.log = \/dev\/stderr/' /etc/php/7.2/fpm/pool.d/www.conf && \
    sed -i 's/;access.log =.*/access.log = \/dev\/stderr/' /etc/php/7.2/fpm/pool.d/www.conf && \
    sed -i 's/;php_admin_value\[error_log\] =.*/php_admin_value[error_log] = \/dev\/stderr/' /etc/php/7.2/fpm/pool.d/www.conf && \
    sed -i 's/;listen.mode =.*/listen.mode = 0777/' /etc/php/7.2/fpm/pool.d/www.conf && \
	mkdir /run/php
    
