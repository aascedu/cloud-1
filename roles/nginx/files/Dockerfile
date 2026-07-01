FROM nginx:alpine3.20

RUN apk add --no-cache openssl

RUN mkdir -p /etc/nginx/ssl /var/run/nginx
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/CN=apgolf.xyz"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html && \
    chmod 755 /var/www/html && \
    chown -R nobody:nobody /var/www/html

CMD [ "nginx", "-g", "daemon off;" ]