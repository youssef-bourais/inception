# inception:  WordPress with NGINX, MariaDB, and PHP-FPM using Docker



![Screenshot 2025-01-14 at 20-28-02 en subject pdf](https://github.com/user-attachments/assets/cdaf9537-88f9-4109-89a9-4b2cf9ba4994)

## Description

This project sets up a WordPress environment using Docker, consisting of the following services each service in a seperate container:

    NGINX with TLS 1.3 - Configured to provide secure HTTPS access to the WordPress application.
    WordPress with PHP-FPM - A container running WordPress with PHP-FPM for handling dynamic requests.
    MariaDB - A container running the MariaDB database for WordPress.


###### Volumes
        One volume to persist WordPress database data.
        Another volume to persist WordPress website files (uploads, themes, plugins, etc.).
###### Network
        A custom network to connect all containers for seamless communication between the services.

### Components

    NGINX: Web server acting as a reverse proxy and load balancer for the WordPress site, with TLS enabled.
    WordPress: Content Management System (CMS) hosted on PHP-FPM (PHP FastCGI Process Manager).
    MariaDB: A relational database management system, used to store WordPress data.
    Docker Volumes: Persistent storage for both WordPress files and database data.
    Docker Network: A custom bridge network to connect all the containers securely.
