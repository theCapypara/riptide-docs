.. cssclass:: no-admonition-variable-helper

Commands
--------

A command is the specification for a container that can be started interactively by the user. This
is used to start CLI command containers.

Commands can either be invoked via ``riptide cmd`` or directly via Riptide's shell integration.

Commands either run as separate containers in the same container network as
services (normal commands), or are started in running service containers.


Schema
~~~~~~

.. include:: tpl/desc_schema.rst

.. automethod:: riptide.config.document.command.Command.schema

.. automethod:: riptide.config.document.command.Command.schema_normal

.. automethod:: riptide.config.document.command.Command.schema_in_service

.. automethod:: riptide.config.document.command.Command.schema_alias

Helper Functions
~~~~~~~~~~~~~~~~

.. include:: tpl/desc_var_helpers.rst

.. automethod:: riptide.config.document.command.Command.parent

.. automethod:: riptide.config.document.command.Command.volume_path

.. automethod:: riptide.config.document.command.Command.home_path
