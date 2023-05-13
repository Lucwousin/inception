wp core download --allow-root
wp --info
wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=$MARIADB_HOST --dbcharset="utf8" --dbcollate="utf8_general_ci" --allow-root

wp core install --url=$DOMAIN --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_MAIL --skip-email --allow-root
wp user create $WP_USER_USER $WP_USER_MAIL --user_pass=$WP_USER_PASS --role=author --allow-root

wp plugin update --all --allow-root
