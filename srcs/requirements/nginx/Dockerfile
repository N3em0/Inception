FROM alpine:3.23

RUN apk add --no-cache \
nginx && \
mkdir -p /etc/nginx/ssl && \
apk add --no-cache openssl && \
openssl req -x509 -noenc -out /etc/nginx/ssl/reqinception.pem -keyout /etc/nginx/ssl/keyinception.key -subj "/C=FR/ST=Rhone/L=Lyon/O=42/OU=42/CN=egache.42.fr/UID=egache" -addext "subjectAltName=DNS:egache.42.fr"

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html && \
chmod 755 /var/www/html && \
chown -R nginx:nginx /var/www/html


CMD ["nginx", "-g", "daemon off;"]

# FROM debian:bookworm-slim
#
# RUN apt-get update -y && \
# apt-get install -y --no-install-recommends \ 
# curl iputils-ping net-tools
#
# RUN apt-get install -y --no-install-recommends nginx
# RUN apt-get install -y --no-install-recommends vim curl
#
# RUN mkdir -p /etc/nginx/ssl
# RUN apt-get install -y --no-install-recommends openssl
# RUN openssl req -x509 -noenc -out /etc/nginx/ssl/reqinception.pem -keyout /etc/nginx/ssl/keyinception.key -subj "/C=FR/ST=Rhone/L=Lyon/O=42/OU=42/CN=erwann/UID=egache"  && \
# rm -rf /var/lib/apt/lists/*
