.. cssclass:: no-admonition-variable-helper

Commands
--------

A command is the specification for a container that can be started interactively by the user. This
is used to start CLI command containers.

Commands can either be invoked via ``riptide cmd`` or directly via Riptide's shell integration.

Since services are container definitions, they need to contain at least the name of an image to run.
All other fields are optional.


Schema
~~~~~~

.. include:: tpl/desc_schema.rst

.. automethod:: riptide.config.document.command.Command.schema

.. automethod:: riptide.config.document.command.Command.schema_normal

.. automethod:: riptide.config.document.command.Command.schema_alias

Helper Functions
~~~~~~~~~~~~~~~~

.. include:: tpl/desc_var_helpers.rst

.. automethod:: riptide.config.document.command.Command.parent

.. automethod:: riptide.config.document.command.Command.volume_path

.. automethod:: riptide.config.document.command.Command.home_path
