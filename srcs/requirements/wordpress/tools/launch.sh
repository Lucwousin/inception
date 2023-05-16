#!/bin/sh

cd /data/wordpress

G_ARGS="--path=/data/wordpress --user=wp_pool"
chown "wp_pool:wp_pool" -R /data/wordpress

if [ ! -f /data/wordpress/wp-config.php ]; then
  wp core download $G_ARGS
  wp config create $G_ARGS \
      --dbname="$MARIADB_DATABASE" \
      --dbuser="$MARIADB_USER" \
      --dbpass="$MARIADB_PASSWORD" \
      --dbhost="$MARIADB_HOST" \
      --dbcharset="utf8" \
      --dbcollate="utf8_general_ci"

  # it's okay if the db already exists... right?!
  wp db create $G_ARGS || true
fi

# now it should really exist, otherwise it's probably a good time to fail
until wp db check $G_ARGS; do
  sleep 1
done

wp core is-installed $G_ARGS ||
    (wp core install $G_ARGS --url=$DOMAIN_NAME \
        --title=$WP_TITLE --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_MAIL \
        --skip-email && \
    wp user create $WP_USER_USER $WP_USER_MAIL \
        $G_ARGS --user_pass=$WP_USER_PASS --role=author && \
    wp plugin update $G_ARGS --all)

#until mariadb --host=$MARIADB_HOST --user=$MARIADB_USER --password=$MARIADB_PASSWORD $MARIADB_DATABASE; do
#  echo "Database not yet running, retrying in a second..."
#  sleep 1
#done
#echo "Connected to database"

exec php-fpm8 -F
