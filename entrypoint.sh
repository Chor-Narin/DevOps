#!/bin/bash

# Generate .env dynamically
cat <<EOF > /var/www/html/.env
APP_NAME=Laravel
APP_ENV=production
APP_KEY=$(php artisan key:generate --show)
APP_DEBUG=false
APP_URL=http://localhost

LOG_CHANNEL=stack

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=${DB_DATABASE:-chornarin-db}
DB_USERNAME=${DB_USERNAME:-root}
DB_PASSWORD=${DB_PASSWORD:-Hello@123}
EOF

# Fix permissions
chown -R www-data:www-data /var/www/html/storage
chown -R www-data:www-data /var/www/html/bootstrap/cache

# Clear configuration cache
php artisan config:clear

# Start services
service nginx start
php-fpm
