#!/bin/sh
set -e #Exit script at first error

DB_USER_PASSWORD=$(cat "$DB_USER_PASSWORD_FILE")
DB_ROOT_PASSWORD=$(cat "$DB_ROOT_PASSWORD_FILE")

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

echo "Contenu du dossier mysql au démarrage :"
ls -la /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initilialisation de mariaDB..."
  mariadb-install-db --user=mysql

  echo "Démarrage du mysql temporaire..."
  mysqld --user=mysql &
  sleep 5

  echo "Création de la base et des utilisateurs..."
  mysql -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
  mysql -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
  mysql -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
  mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
  mysql -u root -p"${DB_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"
  mysql -u root -p"${DB_ROOT_PASSWORD}" -e "SELECT User, Host FROM mysql.user;"

  echo "Shutdown du mysql temporaire..."
  mysqladmin -u root -p"${DB_ROOT_PASSWORD}" shutdown
  sleep 2
  echo "Configuration initiale terminée !"
else
  echo "Configuration initiale déjà réalisée !"
fi
echo "Lancement de mysql."
exec mysqld_safe
