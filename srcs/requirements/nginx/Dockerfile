FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/default.conf /etc/nginx/sites-available/default

COPY ./tools/setup.sh /setup.sh

RUN chmod +x /setup.sh

EXPOSE 443

CMD ["/setup.sh"]