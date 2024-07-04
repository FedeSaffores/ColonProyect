FROM php:8.2-apache

# Instala las extensiones de PHP necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Copia el código de la aplicación al directorio raíz de Apache
COPY . /var/www/html/

# Copia la configuración del VirtualHost de Apache
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

# Habilita el módulo de reescritura de Apache
RUN a2enmod rewrite

# Activa la configuración del VirtualHost
RUN a2dissite 000-default.conf && a2ensite 000-default.conf

# Establece el propietario correcto de los archivos
RUN chown -R www-data:www-data /var/www/html

# Configura el ServerName globalmente para suprimir las advertencias
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Expone el puerto 80
EXPOSE 80

# Ejecuta Apache en primer plano
CMD ["apache2-foreground"]


