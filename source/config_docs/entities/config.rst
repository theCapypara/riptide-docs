.. cssclass:: no-admonition-variable-helper

System (User) Configuration
---------------------------

The system configuration is the main configuration file that defines global behaviour for Riptide,
such as the proxy server configuration.

It is located under "`<CONFIG> <../index.html#Riptide-config-files>`_/config.yml".

Schema
~~~~~~

.. include:: tpl/desc_schema.rst

.. automethod:: riptide.config.document.config.Config.schema

Helper Functions
~~~~~~~~~~~~~~~~

.. include:: tpl/desc_var_helpers.rst

.. automethod:: riptide.config.document.config.Config.get_config_dir

.. automethod:: riptide.config.document.config.Config.get_plugin_flag
