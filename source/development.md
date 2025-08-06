# Development

### Repositories

Riptide consists of multiple Python packages and Git repositories listed below:

- [`riptide-lib`](https://github.com/theCapypara/riptide-lib): Main Python library package
- [`riptide-proxy`](https://github.com/theCapypara/riptide-proxy): HTTP(S) and Websocket Reverse Proxy for Riptide projects
- [`riptide-cli`](https://github.com/theCapypara/riptide-clu): Riptide command-line interface
- [`riptide-engine-docker`](https://github.com/theCapypara/riptide-engine-docker): Docker Engine implementation
- [`riptide-engine-dummy`](https://github.com/theCapypara/riptide-engine-dummy): Dummy Engine implementation (for tests)
- [`riptide-db-mysql`](https://github.com/theCapypara/riptide-db-mysql): MySQL and MariaDB database driver
- [`riptide-db-mongo`](https://github.com/theCapypara/riptide-db-mongo): MongoDB database driver
- [`riptide-plugin-php-xdebug`](https://github.com/theCapypara/riptide-plugin-php-xdebug): PHP XDebug Plugin
- [`Documentation`](https://github.com/theCapypara/riptide-docs): Documentation
- [`Community Repository`](https://github.com/theCapypara/riptide-repo): Riptide Community Repository for shared apps, services and commands
- [`Docker Images`](https://github.com/theCapypara/riptide-docker-images): Docker images used by the Community Repository
- [`riptide-all`](https://github.com/theCapypara/riptide-all): Riptide meta package and Nix Flake

## Plugins

Riptide can be extended with plugins. To write a plugin,
create a Python package, that has the following entry point defined:

```
[riptide.plugin]
php-xdebug=riptide_plugin_php_xdebug.plugin:PhpXdebugPlugin
```

Replace `php-xdebug` with the identifier of your plugin and the rest
with the entry point of your plugin, implementing AbstractPlugin (see below).

### Plugin Interface

```{autodoc2-object} riptide.plugin.abstract.AbstractPlugin

render_plugin = "myst"
```
