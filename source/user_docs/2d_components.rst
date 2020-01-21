Installing individual components
--------------------------------
Instead of installing all Riptide components via the ``riptide-all`` package, you can also
install individual parts of Riptide separately.

Core components::

  $ [sudo] pip3 install riptide-proxy riptide-cli riptide-engine-docker

Database drivers, additional support for database management::

  $ [sudo] pip3 install riptide-db-mysql # MySQL

Plugins, used to integrate Riptide better with special needs of some programming languages or
frameworks::

  $ [sudo] pip3 install riptide-plugin-php-xdebug # Required for the PHP debugger Xdebug

