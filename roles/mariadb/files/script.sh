#! /bin/sh
set -e

echo
echo
echo $SQL_ROOT_PASSWORD
echo
echo

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/mysql ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

gosu mysql mariadbd --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock &
sleep 5

mariadb -u root -p"$SQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};\
CREATE USER IF NOT EXISTS ${SQL_ADMIN}@'%' IDENTIFIED BY '${SQL_ADMINPASSWD}';\
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO ${SQL_ADMIN}@'%' IDENTIFIED BY '${SQL_ADMINPASSWD}';\
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}'; \
FLUSH PRIVILEGES;"
mariadb-admin -u root -p"$SQL_ROOT_PASSWORD" shutdown

exec gosu mysql mariadbd --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock

# CREATE USER IF NOT EXISTS root@localhost IDENTIFIED BY test;
# SET PASSWORD FOR root@localhost = PASSWORD(test);
# GRANT ALL ON *.* TO root@localhost WITH GRANT OPTION;
# CREATE USER IF NOT EXISTS root@'%' IDENTIFIED BY test;
# SET PASSWORD FOR root@'%' = PASSWORD(test);
# GRANT ALL ON *.* TO root@'%' WITH GRANT OPTION;
# CREATE USER IF NOT EXISTS ${MARIADB_USER}@'%' IDENTIFIED BY ${MARIADB_PASSWORD};
# SET PASSWORD FOR ${MARIADB_USER}@'%' = PASSWORD(${MARIADB_PASSWORD});
# CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};
# GRANT ALL ON ${MARIADB_DATABASE}.* TO ${MARIADB_USER}@'%';