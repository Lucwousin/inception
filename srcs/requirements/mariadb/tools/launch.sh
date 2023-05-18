#!/bin/sh

DB_DIR=/data/wordpress_db
CONF_FILE=/etc/my.cnf.d/mariadb.conf

mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

chown -R mysql:mysql "$DB_DIR"
cd "$DB_DIR" || exit 1

if [ ! -d "$DB_DIR/mysql" ]; then
  echo "Database does not exist, creating..."
  mysql_install_db --defaults-extra-file=$CONF_FILE --skip-test-db

  echo "Setting up users (and stuff)"
  mysqld --defaults-extra-file=$CONF_FILE --bootstrap << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* to '$MARIADB_USER'@'%';
FLUSH PRIVILEGES;
EOF

  echo "Theoretically done setting up the db!"
fi

echo "Running mariadb!"
exec mariadbd --defaults-extra-file=$CONF_FILE --console
