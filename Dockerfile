# 1. Gunakan PHP 8.1 FPM sebagai base image
FROM php:8.1-fpm

# 2. Instal dependensi tambahan untuk Laravel (misalnya GD untuk image manipulation)
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# 3. Instal dependensi sistem lainnya yang dibutuhkan oleh Laravel
RUN apt-get install -y libmcrypt-dev libzip-dev \
    && docker-php-ext-install zip

# 4. Salin file aplikasi Laravel ke dalam container
COPY . /var/www/html

# 5. Set working directory di container
WORKDIR /var/www/html

# 6. Instal Composer untuk mengelola dependensi PHP
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 7. Jalankan Composer untuk menginstal dependensi Laravel
RUN composer install --optimize-autoloader --no-dev

# 8. Set izin untuk folder storage dan cache supaya dapat ditulis oleh aplikasi
RUN chmod -R 775 storage bootstrap/cache

# 9. Ekspose port yang digunakan oleh aplikasi (biasanya 8080 untuk PHP-FPM)
EXPOSE 8080

# 10. Tentukan perintah untuk menjalankan PHP-FPM di dalam container
CMD ["php-fpm"]
