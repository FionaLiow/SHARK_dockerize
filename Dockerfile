# Use the PHP Apache image as the base
FROM php:8.2.12-apache

# Install PDO MySQL extension
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Use production php.ini configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy the application files into the container
COPY . /var/www/html

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html && \
	touch /var/www/html/SHARK/locale.txt && \
    chmod 664 /var/www/html/SHARK/locale.txt && \
    chown www-data:www-data /var/www/html/SHARK/locale.txt

# Apache runs as www-data by default, so we don't need to switch users