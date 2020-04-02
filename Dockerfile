FROM php:7.4-cli

RUN apt-get update \
     && apt-get install -y wget git

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '$(wget -q -O - https://composer.github.io/installer.sig)') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/bin/composer

RUN composer selfupdate \
    && composer require "phpunit/phpunit:~8.0" --prefer-source --no-interaction