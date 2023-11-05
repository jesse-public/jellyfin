FROM nginx:stable-alpine

RUN \
  echo "*** installing dependencies ***" && \
  apk update --no-cache && \
  apk upgrade --no-cache && \
  apk add openssl curl && \
  rm -rf /var/cache/apk/*

RUN rm /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./certs/ca.crt /usr/local/share/ca-certificates/root-ca.crt
COPY ./certs/*.crt /etc/nginx/certs/
RUN rm /etc/nginx/certs/ca.crt
COPY ./certs/*.key /etc/nginx/private/

# nginx: [emerg] could not build server_names_hash, you should increase server_names_hash_bucket_size: 32
RUN sed -i 's/http {/http {\server_names_hash_bucket_size 64;/g' /etc/nginx/nginx.conf

RUN cat /usr/local/share/ca-certificates/root-ca.crt >> /etc/ssl/certs/ca-certificates.crt
