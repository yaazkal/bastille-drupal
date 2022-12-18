#!/bin/sh

DRUPAL_TAR="/tmp/drupal.tar.gz"
DEST_PATH="/usr/local/www/drupal"
DRUPAL_VERSION="${drupal-version}"
PHP_VERSION="${php-version}"
DB_SERVER="${db-server}"
PG_VERSION="15"
PKG_CMD="pkg install -y"

if [ "${PHP_VERSION}" != "82" ]; then
  echo "[ERROR] The selected PHP version is not supported."
  exit 1
fi

echo "[INFO] Downloading Drupal ${drupal-version}"
if [ "${DRUPAL_VERSION}" = 'latest' ]; then
  fetch -o "${DRUPAL_TAR}" -q https://www.drupal.org/download-latest/tar.gz
else
  echo "[ERROR] The selected Drupal version is not supported."
  exit 1
fi

echo "[INFO] Extracting Drupal in ${DEST_PATH}"
tar -C "${DEST_PATH}" --strip-components 1 -xzf "${DRUPAL_TAR}"
chown -R www:www "${DEST_PATH}/sites/default"

case "${DB_SERVER}" in
  mariadb|mysql)
    ${PKG_CMD} "php${PHP_VERSION}-pdo_mysql"
    if [ "${DB_SERVER}" = "mariadb" ]; then ${PKG_CMD} mariadb106-server; fi
    if [ "${DB_SERVER}" = "mysql" ]; then ${PKG_CMD} mysql80-server; fi
    sysrc mysql_enable=YES
    service mysql-server restart
    ;;
  pgsql|postgres|postgresql)
    ${PKG_CMD} "php${PHP_VERSION}-pdo_pgsql postgresql${PG_VERSION}-server"
    sysrc postgresql_enable=YES
    if [ ! -e "/var/db/postgres/data${PG_VERSION}" ];then
      service postgresql initdb
    fi
    service postgresql restart
    echo "[WARN] Since you are using PostgreSQL you need to set sysvshm=new in the jail configuration and restart the jail"
    ;;
  sqlite)
    ${PKG_CMD} "php${PHP_VERSION}-pdo_sqlite"
    ;;
  *)
    echo "[ERROR] The selected database server is not supported."
    exit 1
    ;;
esac

echo '[INFO] Done.'
