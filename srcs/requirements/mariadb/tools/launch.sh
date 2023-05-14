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
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD' WITH GRANT OPTION;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS '$MARIADB_DATABASE' CHARACTER SET utf8 COLLATE utf8_general_ci;
GRANT ALL ON '$MARIADB_DATABASE'.* to '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
EOF

  echo "Theoretically done setting up the db!"
fi

echo "Running mariadb!"
exec mariadbd --defaults-extra-file=$CONF_FILE --console
