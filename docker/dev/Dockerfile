FROM php:8.4-apache

# Update package manager and install required dependencies including cron
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    zip \
    unzip \
    git \
    curl \
    wget \
    imagemagick \
    libmagickwand-dev \
    cron \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip \
    && docker-php-ext-install mbstring \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && a2enmod headers

## APACHE SETTING
ENV APACHE_DOCUMENT_ROOT=/var/www/project/public
RUN a2enmod rewrite && \
    sed -ri -e 's!/var/www/project!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/project!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Copy custom Apache site configuration to the container
COPY ./config/custom.conf /etc/apache2/sites-available/000-default.conf

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Start Apache server
CMD ["apache2-foreground"]