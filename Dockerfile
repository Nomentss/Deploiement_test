# Utiliser une image de base PHP avec Apache
FROM php:8.3-apache

# Installer les extensions nécessaires
RUN docker-php-ext-install pdo pdo_pgsql

# Copier le contenu de l'application Laravel
COPY . /var/www/html

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installer les dépendances PHP
RUN composer install --no-dev --optimize-autoloader

# Donner les permissions nécessaires
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache