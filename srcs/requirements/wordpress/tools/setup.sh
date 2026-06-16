#!/bin/bash

set -e

DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(sed -n '1p' /run/secrets/credentials)
WP_USER_PASSWORD=$(sed -n '2p' /run/secrets/credentials)

mkdir -p /var/www/html
cd /var/www/html

until mysqladmin ping -h mariadb -u"${MYSQL_USER}" -p"${DB_PASSWORD}" --silent; do
    sleep 2
done

if [ ! -f wp-config.php ]; then
    # نتحقق من وجود ملفات الووردبريس قبل التحميل لتجنب خطأ files already present
    if [ ! -f wp-settings.php ]; then
        wp core download --allow-root
    fi

    wp config create \
        --allow-root \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="mariadb:3306"

    wp core install \
        --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
fi

mkdir -p /run/php
exec /usr/sbin/php-fpm7.4 -F