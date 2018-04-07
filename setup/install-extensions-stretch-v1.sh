#! /bin/bash

set -eo pipefail

apt-get update

docker-php-ext-install bcmath
apt-get install libbz2-dev -y && docker-php-ext-install bz2
docker-php-ext-install calendar
docker-php-ext-install ctype
# docker-php-ext-install dba
# docker-php-ext-install dom
# docker-php-ext-install enchant
# docker-php-ext-install exif
docker-php-ext-install fileinfo
# docker-php-ext-install filter
apt-get install libssl-dev -y && docker-php-ext-install ftp
apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
docker-php-ext-install gettext
apt-get install -y libgmp-dev && docker-php-ext-install gmp
docker-php-ext-install hash
docker-php-ext-install iconv
# docker-php-ext-install imap
# docker-php-ext-install interbase
apt-get install -y libicu-dev && docker-php-ext-install intl
docker-php-ext-install json
# docker-php-ext-install ldap
docker-php-ext-install mbstring
# docker-php-ext-install mysqli
# docker-php-ext-install oci8
# docker-php-ext-install odbc
docker-php-ext-install opcache
# docker-php-ext-install pcntl
docker-php-ext-install pdo
# docker-php-ext-install pdo_dblib
# docker-php-ext-install pdo_firebird
docker-php-ext-install pdo_mysql
# docker-php-ext-install pdo_oci
# docker-php-ext-install pdo_odbc
apt-get install -y libpq-dev && docker-php-ext-install pdo_pgsql
apt-get install -y libsqlite3-dev && docker-php-ext-install pdo_sqlite
# docker-php-ext-install pgsql
# docker-php-ext-install phar
# docker-php-ext-install posix
# docker-php-ext-install pspell
# docker-php-ext-install readline
# docker-php-ext-install recode
# docker-php-ext-install reflection
docker-php-ext-install session
# docker-php-ext-install shmop
apt-get install -y libxml2-dev && docker-php-ext-install simplexml
# docker-php-ext-install snmp
docker-php-ext-install soap
docker-php-ext-install sockets
# docker-php-ext-install sodium
# docker-php-ext-install spl
# docker-php-ext-install standard
# docker-php-ext-install sysvmsg
# docker-php-ext-install sysvsem
# docker-php-ext-install sysvshm
# docker-php-ext-install tidy
docker-php-ext-install tokenizer
# docker-php-ext-install wddx
docker-php-ext-install xml
# docker-php-ext-install xmlreader
# docker-php-ext-install xmlrpc
# docker-php-ext-install xmlwriter
# docker-php-ext-install xsl
# docker-php-ext-install zend_test
docker-php-ext-install zip

yes '' | pecl install redis && docker-php-ext-enable redis
apt-get install -y libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick

apt-get clean
