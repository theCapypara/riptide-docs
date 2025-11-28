# Installing individual components

Instead of installing all Riptide components via the `riptide-all` package, you can also
install individual parts of Riptide separately. Make sure to activate the virtualenv first
before installing these components.

Core components:

```sh
$ pip3 install riptide-proxy riptide-cli riptide-engine-docker
```

Database drivers, additional support for database management:

```sh
$ pip3 install riptide-db-mysql # MySQL
```

Plugins, used to integrate Riptide better with special needs of some programming languages or
frameworks:

```sh
$ pip3 install riptide-plugin-php-xdebug # Required for the PHP debugger Xdebug
```

See also: {doc}`/development`.
