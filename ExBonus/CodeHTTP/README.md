# Documentation: Apache HTTP Status Code Simulations

This repository contains a technical breakdown and practical implementation
of common HTTP status codes (`200`, `301`, `401`, `500`) using the
Apache HTTP Server on Ubuntu.

The exercises focus on:

- Server configuration
- Authentication
- Error handling

---

# 1. HTTP 200 OK: Standard Successful Request

The server successfully processed the request and returned the header
with a `200 OK` status.

## Implementation

Ensure the Apache service is active and running.

Request the header of the local server to verify the default status.

## Commands

```bash
sudo systemctl start apache2
sudo systemctl status apache2
curl -I localhost
```

---

# 2. HTTP 301 Moved Permanently: URL Redirection

The requested resource has been assigned a new permanent URL.

The server returns a `Location` header pointing to the new address.

## Configuration (`000-default.conf`)

The `Redirect` directive is used within the `VirtualHost`
to forward all traffic to a new domain.

```apache
<VirtualHost *:80>
    ServerName sitovecchio.com
    ServerAlias www.sitovecchio.com
    DocumentRoot /var/www/html

    Redirect 301 / https://nuovosito.com
</VirtualHost>
```

## Commands

```bash
sudo vim /etc/apache2/sites-available/000-default.conf
sudo systemctl reload apache2
curl -I localhost
```

---

# 3. HTTP 401 Unauthorized: Basic Authentication

This status indicates that the request requires user authentication.

The server includes a `WWW-Authenticate` header field.

## Implementation

1. Create a protected directory:
   `/var/www/html/area-privata`

2. Configure the directory in Apache to use `AuthType Basic`

3. Create the credentials file using the `htpasswd` utility

## Configuration (`000-default.conf`)

```apache
<Directory "/var/www/html/area-privata">
    AuthType Basic
    AuthName "Attendo credenziali"
    AuthUserFile /etc/apache2/.htpasswd
    Require valid-user
</Directory>
```

## Commands

```bash
sudo htpasswd -c /etc/apache2/.htpasswd nomeutente
curl -I -u wronguser:wrongpass localhost/area-privata/
```

---

# 4. HTTP 500 Internal Server Error: Configuration Conflict

The server encountered a condition that prevented it from fulfilling
the request.

This was simulated by using an invalid directive
inside an `.htaccess` file.

## Implementation

Enable Apache to override global configurations
via the `AllowOverride All` directive.

Create an `.htaccess` file in the document root
containing a syntax error or incomplete command.

## Configuration (`000-default.conf`)

```apache
<Directory /var/www/html>
    AllowOverride All
</Directory>
```

## Commands

```bash
# Create an .htaccess file with an invalid command
vim /var/www/html/.htaccess
curl -I localhost
```

---

# Summary of Utilized Commands

| Command | Description |
|----------|-------------|
| `systemctl start/status apache2` | Manage and monitor the Apache service |
| `curl -I [URL]` | Fetch only the HTTP response headers |
| `vim` | Edit server configuration and local files |
| `htpasswd -c` | Create a new encrypted file for HTTP Basic Authentication |
| `.htaccess` | Configure directory-level server overrides |
| `AllowOverride All` | Enable the processing of `.htaccess` files |
