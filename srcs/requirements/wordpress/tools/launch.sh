cd /data/wordpress

while ! mariadb --host=$MARIADB_HOST --user=$MARIADB_USER -password=$MARIADB_PASSWORD $MARIADB_DATABASE; do
  sleep 1
done

if [ ! -f .installed ]; then
  /tools/install_wordpress.sh && touch .installed
fi

rm -f /etc/php8/php-fpm.d/www.conf

php-fpm8 -F

top -b