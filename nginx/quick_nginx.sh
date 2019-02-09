NGINX_HOME='/usr/local/nginx'

mkdir -p ${NGINX_HOME}/{logs,conf,ssl,www,bin}
openssl ecparam -genkey -name prime256v1 -out  ${NGINX_HOME}/ssl/server.key.ecc
openssl req -new -x509 -key ${NGINX_HOME}/ssl/server.key.ecc  -out ${NGINX_HOME}/ssl/server.cert.ecc -days 3650 -subj /CN=$(hostname)
cat ${NGINX_HOME}/ssl/server.key.ecc ${NGINX_HOME}/ssl/server.cert.ecc | tee ${NGINX_HOME}/ssl/server.pem.ecc


openssl genrsa -out ${NGINX_HOME}/ssl/server.key.rsa 2048
openssl req -new -x509 -key ${NGINX_HOME}/ssl/server.key.rsa -out ${NGINX_HOME}/ssl/server.cert.rsa -days 3650 -subj /CN=$(hostname)
cat ${NGINX_HOME}/ssl/server.key.rsa ${NGINX_HOME}/ssl/server.cert.rsa | tee ${NGINX_HOME}/ssl/server.pem.rsa

openssl dhparam -rand - 2048 > ${NGINX_HOME}/ssl/dh.pem

cat ${NGINX_HOME}/ssl/server.pem.ecc  ${NGINX_HOME}/ssl/dh.pem >  ${NGINX_HOME}/ssl/pem.ecc+dh
cat ${NGINX_HOME}/ssl/server.pem.rsa  ${NGINX_HOME}/ssl/dh.pem >  ${NGINX_HOME}/ssl/pem.rsa+dh

< /dev/urandom tr -dc "[:alnum:]" | head -c1500000 > ${NGINX_HOME}/www/index.html

cat > ${NGINX_HOME}/conf/nginx.conf <<EOL
worker_processes 1;

events {
  worker_connections 1024;
}

http {
    server {
        listen 8443 ssl;
        client_max_body_size 0;

        ssl_prefer_server_ciphers on;
        ssl_ciphers "ALL:!aNULL:!MEDIUM:!LOW:!WEAK:!EXPORT:!DES:!PSK:!SRP:!CAMELLIA:!3DES:!AES256:!EDH";

        ssl_protocols           TLSv1 TLSv1.1 TLSv1.2;

        ssl_certificate         /usr/local/nginx/ssl/server.pem.ecc;
        ssl_certificate_key     /usr/local/nginx/ssl/server.key.ecc;

#        ssl_certificate         /etc/nginx/ssl/server.pem.rsa;
#        ssl_certificate_key     /etc/nginx/ssl/server.key.rsa;

        ssl_dhparam             /usr/local/nginx/ssl/dh.pem;
        # Health check handler for cops
        location / {
            root /usr/local/nginx/www;
            rewrite ^  /index.html break;
        }
    }
}
EOL


echo sudo /usr/local/nginx/bin/nginx -g \"daemon off;\"
