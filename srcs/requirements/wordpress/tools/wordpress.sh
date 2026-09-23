#!/bin/sh
set -e

DB_USER_PASSWORD=$(cat "$DB_USER_PASSWORD_FILE")
WP_ADMIN_PASSWORD=$(cat "$WP_ADMIN_PASSWORD_FILE")
WP_USER_PASSWORD=$(cat "$WP_USER_PASSWORD_FILE")

# echo "Waiting for MariaDB"
# while ! mariadb -h"$DB_HOST" -u"$DB_USER" -p"$DB_USER_PASSWORD" --skip-ssl -e "SELECT 1;" &> /dev/null; do
#   sleep 2
# done
# echo "MariaDB UP !"

if [ ! -f "wp-config.php" ]; then
  echo "DL de WordPress"
  php -d memory_limit=512m /usr/local/bin/wp core download --allow-root

  echo "Génération de wp-config.php"
  wp config create --allow-root \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_USER_PASSWORD" \
    --dbhost="$DB_HOST"

  echo "Installation de Wordpress"
  wp core install --allow-root --skip-email --url="$DOMAIN_NAME" \
    --title="R1ception" \
    --admin_user="$WP_ADMIN_LOGIN" \
    --admin_password="$WP_ADMIN_PASSWORD" \
    --admin_email="$WP_ADMIN_EMAIL"

  echo "Creation de user"
  wp user create --allow-root "$WP_USER_LOGIN" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD" --role=author

  echo "Installation done"
else
  echo "Le fichier wp-config existe deja"
fi

echo "Démarrage de wordPress"
exec php-fpm85 -F
