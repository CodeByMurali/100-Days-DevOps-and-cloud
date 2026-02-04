
### 1. Repository & Installation

* **Enable PHP 8.2**: Install the Remi repository and enable the PHP 8.2 module.
* **Install Packages**: Install `nginx` and `php-fpm`.

### 2. Configure PHP-FPM

* **Create Socket Directory**: `mkdir -p /var/run/php-fpm`.
* **Configure Pool**: Edit `/etc/php-fpm.d/www.conf`:
* Set `listen = /var/run/php-fpm/default.sock`.
* Set `listen.owner = nginx` and `listen.group = nginx`.


* **Start PHP-FPM**: Enable and start the service.

### 3. Configure Nginx

* **Create Server Block**: Create `/etc/nginx/conf.d/phpapp.conf`:
* Listen on port `8096`.
* Set root to `/var/www/html`.
* Add a `location ~ \.php$` block using `fastcgi_pass unix:/var/run/php-fpm/default.sock;`.


* **Clean Up Conflicts**: Remove or fix problematic files like `/etc/nginx/default.d/php.conf` or the systemd drop-in mentioned in your logs.
* **Start Nginx**: Run `nginx -t` to verify, then start the service.

### 4. Verification

* **Test**: Run `curl http://stapp03:8096/index.php` from the jump host.

