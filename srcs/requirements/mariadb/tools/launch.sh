if [ ! -f "/data/wordpress_db/mysql_upgrade_info" ]; then
  echo "Database does not exist, creating..."
  mysql_install_db --defaults-extra-file=/etc/my.cnf.d/mariadb.conf \
                   --user=mysql \
                   --basedir=/usr --datadir=/data/wordpress_db \
                   --skip-test-db

  echo "Database should be created now, setting up accounts..."
  mariadbd --defaults-extra-file=/etc/my.cnf.d/mariadb.conf --user=mysql --bootstrap << EOF
FLUSH PRIVILEGES;

DELETE FROM	mysql.user WHERE User='';

ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD' ;

CREATE DATABASE $MARIADB_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci ;
CREATE USER '$MARIADB_USER'@'%' IDENTIFIED by '$MARIADB_PASSWORD' ;
GRANT ALL ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' ;
FLUSH PRIVILEGES;
EOF
fi

echo "Running mariadb!"
mariadbd --defaults-extra-file=/etc/my.cnf.d/mariadb.conf --user=mysql --basedir=/usr --datadir=/data/wordpress_db --console
