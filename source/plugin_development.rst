Plugin Development
------------------

Riptide can be extended with plugins. To write a plugin,
create a Python package, that has the following entry point defined:

.. code::

    [riptide.plugin]
    php-xdebug=riptide_plugin_php_xdebug.plugin:PhpXdebugPlugin

Replace ``php-xdebug`` with the identifier of your plugin and the rest
with the entry point of your plugin, implementing AbstractPlugin (see below).

Plugin Interface
~~~~~~~~~~~~~~~~

.. autoclass:: riptide.plugin.abstract.AbstractPlugin
   :members:
   :undoc-members:
   :show-inheritance:
