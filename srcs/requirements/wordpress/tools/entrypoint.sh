#!/usr/bin/env bash

WP_PATH="/var/www/wordpress"

wp() {
  /usr/local/bin/wp --allow-root --path="$WP_PATH" "$@"
}

if ! wp core is-installed; then
  wp core install \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PWD" \
    --admin_email="$WP_ADMIN_EMAIL" \
    --url="$WP_URL"
  wp option update blogdescription "$WP_SUB_TITLE"
  wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass="$WP_USER_PWD"

  wp plugin uninstall akismet hello
  wp plugin install redis-cache --activate
  wp plugin update --all
  wp redis enable --all

  chown -R www-data:www-data "$WP_PATH"
  chmod -R 774 "$WP_PATH"
fi

php-fpm8.2 -F