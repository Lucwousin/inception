#!/bin/sh

until mariadb --host="$MARIADB_HOST" --user="$MARIADB_USER" --password="$MARIADB_PASSWORD" "$MARIADB_DATABASE"; do
  echo "Database not yet running, retrying in a second..."
  sleep 1
done
echo "Connected to database"

# Don't attempt to download wordpress every time the config fails
if [ ! -f ./license.txt ]; then
  echo "Downloading wordpress core"
  wp core download
fi

if [ ! -f /data/wordpress/wp-config.php ]; then
  echo "Creating wordpress config"
  wp config create \
      --dbname="$MARIADB_DATABASE" \
      --dbuser="$MARIADB_USER" \
      --dbpass="$MARIADB_PASSWORD" \
      --dbhost="$MARIADB_HOST" \
      --dbcharset="utf8" \
      --dbcollate="utf8_general_ci"
fi

if ! wp core is-installed; then
  echo "Installing wordpress"
  wp core install \
    --url="$DOMAIN_NAME" \
    --title="$WP_TITLE" \
    --admin_user="$WP_ADMIN_USER" \
    --admin_password="$WP_ADMIN_PASS" \
    --admin_email="$WP_ADMIN_MAIL" \
    --skip-email

  wp user create "$WP_USER_USER" "$WP_USER_MAIL" \
    --user_pass="$WP_USER_PASS" \
    --role=author
fi

wp plugin update --all

exec php-fpm8 -F
