#!bin/bash
set -e

if [ ! -f "/var/www/html/wp-config.php" ]; then

sed -i 's/^memory_limit = .*/memory_limit = 256M/' /etc/php83/php.ini
wp core download --path=/var/www/html \
                 --allow-root

wp config create	--allow-root --dbname=$SQL_DATABASE --dbuser=$SQL_ADMIN --dbpass=$SQL_ADMINPASSWD --dbhost=mariadb:3306 --path=/var/www/html

wp core install     --allow-root \
                    --url=$DOMAIN_NAME \
                    --admin_user=$SQL_ADMIN \
                    --admin_password=$SQL_ADMINPASSWD \
                    --admin_email=arthurascedu@proton.me \
                    --title=Inception \
                    --path=/var/www/html

# wp user create      --allow-root \
#                     $SQL_USER \
#                     example@example.com \
#                     --user_pass=$SQL_USERPASSWD \
#                     --path=/var/www/html
chown -R nobody:nobody /var/www/html/
fi

if [ ! -d "/run/php" ]; then
    mkdir -p /run/php
fi

/usr/sbin/php-fpm83 -F