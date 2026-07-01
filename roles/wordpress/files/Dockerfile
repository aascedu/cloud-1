FROM alpine:3.20

RUN apk add --no-cache wget php php-phar php-iconv php-fpm php-mysqli php-session mariadb-client
RUN mkdir -p /var/www/html/ && chown -R root:root /var/www/html

RUN wget https://github.com/wp-cli/wp-cli-bundle/releases/download/v2.12.0/wp-cli-2.12.0.phar && \
    chmod +x wp-cli-2.12.0.phar && \
    mv wp-cli-2.12.0.phar /usr/local/bin/wp 

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY tools/script.sh /usr/local/bin/script_php.sh
RUN chmod +x /usr/local/bin/script_php.sh

CMD ["sh", "/usr/local/bin/script_php.sh"]