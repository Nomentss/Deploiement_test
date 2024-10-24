# Utilise l'image PHP avec Apache
FROM php:8.3-apache

# Installer les extensions PHP requises
RUN apt-get update && apt-get install -y \
    libzip-dev \
    git \
    && docker-php-ext-install zip

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copier le code source
COPY . /var/www/html

# Installer les dépendances PHP
RUN composer install --no-dev --optimize-autoloader

# Donner les permissions nécessaires
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache

# Activer le module rewrite d'Apache pour Laravel
RUN a2enmod rewrite

# Copier votre fichier de configuration Apache personnalisé
COPY ./docker/apache/apache2.conf /etc/apache2/apache2.conf

# Exposer le port 80
EXPOSE 80

# Lancer Apache
CMD ["apache2-foreground"]
