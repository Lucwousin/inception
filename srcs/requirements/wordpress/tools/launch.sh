cd /data/wordpress

while ! mariadb --host=$MARIADB_HOST --user=$MARIADB_USER --password=$MARIADB_PASSWORD $MARIADB_DATABASE; do
  echo "Database not yet running, retrying..."
  sleep 1
done
echo "Connected to database"

if [ ! -f .installed ]; then
  echo "Wordpress not installed! Installing..."
  /tools/install_wordpress.sh && touch .installed
fi

rm -f /etc/php8/php-fpm.d/www.conf
chown wordpress:wordpress -R /data/wordpress/*
chown 755 -R /data/wordpress/*

php-fpm8 -F
