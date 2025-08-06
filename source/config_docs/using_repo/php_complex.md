# PHP with Database, Redis and Composer

This section will guide you through the setup of a complex PHP project using the Riptide repository.

We will use a Nginx web server and PHP-FPM.

This guide assumes you have Riptide fully set up, with shell integration enabled
and a running proxy server
(for this guide we assume `https://riptide.local` as base URL of your proxy server). It also
assumes you have the `repos` part of the configuration set to only the Riptide Community Repository
(the default).

**PHP and Nginx do NOT need to be installed for this guide.**

## Preparing the project

For this guide we will set up a PHP file.

Create a new directory and create an `index.php` in it with the following contents:

```php
<?php
require_once "vendor/autoload.php";

$hello = new Rivsen\Demo\Hello();
echo $hello->hello();
```

This PHP file tries to load the autoloader supplied by Composer and then tries to load a
class from the [rivsen/hello-world](https://github.com/Rivsen/hello-world) package.

We will also be setting up Redis and a MySQL database, however our simple PHP example
will not use them. You can experiment with your own PHP code to access them, this guide
will give you everything you need for this (aside from PHP knowledge).

We also need a `composer.json` with the requirement for this package:

```json
{
    "name": "phpcomplex-helloworld",
    "require": {
        "rivsen/hello-world": "*"
    }
}
```

Instead you can also run `composer require rivsen/hello-world` later on, after we added
the `composer` command.

## Creating a riptide.yml with nginx and php-fpm

Create a `riptide.yml` with the following contents:

```yaml
project:
  name: phpcomplex-helloworld
  src: .
  app:
    name: phpcomplex-helloworld
    services:
      nginx:
        $ref: /service/nginx/latest
        roles:
          - src
          - main
        config:
          default_nginx_conf:
            from: default_nginx.conf
            to: '/etc/nginx/conf.d/default.conf'
        pre_start:
          # Wait for php (otherwise nginx crashes) :(
          - "until ping -c5 php &>/dev/null; do :; done"
      php:
        $ref: /service/php/8.3/fpm
        roles:
          - src
          - php
```

The PHP service is nearly the same as in the `riptide.yml` of the [simple example](./php).

We just added the role `php` and switched the reference to the `fpm` variant. This
variant does not container Apache but instead PHP and PHP-FPM. The role `php` is used, so that we can
later use the `/command/php/from-service` command from the repository.

We added the new service nginx. This service is also based on a service from the repository and
also get's access to the source code.

In `config` we tell Riptide to take the `default_nginx.conf` and put it to `/etc/nginx/conf.d/default.conf`
in the container.

The `default_nginx.conf` contains the server settings for Nginx. We connect PHP and Nginx there.
This is the contents of this file:

```
server {
    listen 80;
    root /src;
    index index.php;
    server_name {{ domain() }};
    location ~* \.php$ {
        fastcgi_index   index.php;
        fastcgi_pass    php:9000;
        include         fastcgi_params;
        fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
        fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
    }
}
```

As you can see, we tell Nginx to use the service `php` as a FastCGI backend for all php files. The service `php`
contains php-fpm and nginx will communicate with it to process php files.

Since this is a `config` file, variables and variable helper functions can be used in this file.
In this case we use the {func}`~riptide.config.document.service.Service.domain` helper. Riptide
will process the file, look for all template strings ( `{{ something }}` ) and replace them. The
helper {func}`~riptide.config.document.service.Service.domain` returns the domain of the proxy
server that our project is accessible under. So when the service is started this line will actually
say something like `server_name phpcomplex-helloworld.riptide.local;`.

In `pre_start` for `nginx` we make sure that `nginx` doesn't get started before `php` does,
because otherwise nginx would crash.

## Adding commands for Composer

Next we need to add the `php` and `composer` commands to our project, so that we can run `composer`
to install express from the `composer.json`.

Add the following under `app` in the `riptide.yml`:

```yaml
commands:
  php:
    $ref: /command/php/from-service
  composer:
    $ref: /command/composer/with-host-links
```

This adds two new commands, one containing PHP and one containing PHP and the newest Composer version.
All composer processes started will also have access to the directory `.composer` in your home directory and `.ssh`.

Those commands come from the Riptide repository, if you want to know how they work, visit the repository:

- [/command/php/from-service](https://github.com/Parakoopa/riptide-repo/tree/master/command/php)
- [/command/composer/with-host-links](https://github.com/Parakoopa/riptide-repo/tree/master/command/composer)

## Installing requirements

If you have the shell integration enabled, leave and enter the directory again, this will load
the configured `php` and `composer` commands. You can now run `composer install`, which will install
the dependencies and create a directory named `vendor`.

## Running the project setup

Run `riptide setup --skip` to initiate the project. Since we have not added any setup instructions or
files to import, we just skip the setup with the `--skip` flag.

## Starting the project

Open the front page of the Proxy server (`https://riptide.local`).
You will find a new project called `php-helloworld`.

Click on the link and the project will start.
After it starts you will see the "Hello World!" message
telling you, that the project works.

## Adding Redis

To add redis, add a new service under `services`:

```yaml
redis:
  $ref: /service/redis/4.0
```

You can start this service using the Riptide CLI:

```
$ riptide start
Starting services...

nginx: 2/2|█████████████████████████████████████████████████████████████| Already started!
php  : 2/2|█████████████████████████████████████████████████████████████| Already started!
redis: 4/6|████████████████████████████████████████▋                    | Checking...
```

Try to write PHP code to access Redis! Since the service is named `redis`, you will be able
to access Redis under the hostname `redis`.

## Adding MySQL

To add a MySQL database, add a new service under `services`:

```yaml
db:
  $ref: /service/mysql/5.6
  driver:
    name: mysql
    config:
      database: db
      password: password
```

You can specify the database and password. Username is always `root`.

This is using the MySQL service from the repository and the MySQL database driver. The database
driver enables the [database management features](/../../user_docs/db) of Riptide.

Database driver are separate packages that need to be installed. The package for MySQL can
be installed via `pip install riptide-db-mysql` ([Github](https://github.com/theCapypara/riptide-db-mysql)).

When you start the database via `riptide start` you can access it.

Try to write PHP code to access the database! Since the service is named `db`, you will be able
to access MySQL under the hostname `db`.

The database driver also provides a way to directly access the database. When you enter `riptide status`
you can see the port on which you can access the database from the host system.

## Enable logging

See the [simple example](./php).

## Adding files for import and setup instructions

See the [simple example](./php).

[app]: ../entities/apps
[project]: ../entities/projects
[service]: ../entities/services
