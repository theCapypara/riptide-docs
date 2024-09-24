.. cssclass:: no-admonition-variable-helper

Project
-------

Projects represent one web development project.

They are loaded from ``riptide.yml`` files. Additionally, if a ``riptide.local.yml`` exists, it's contents
are merged on top of the ``riptide.yml``.

A project consists of one `app <./apps.html>`_.

Schema
~~~~~~

.. include:: tpl/desc_schema.rst

.. automethod:: riptide.config.document.project.Project.schema

Helper Functions
~~~~~~~~~~~~~~~~

.. include:: tpl/desc_var_helpers.rst

.. automethod:: riptide.config.document.project.Project.parent
