.. cssclass:: no-admonition-variable-helper

App
---

An app defines all the different services (sub-applications) and commands that are required
to run a web development project for a specific framework or application.

An app consists of a number of `services <./services.html>`_ and `commands <./commands>`_, a list of
files that can be imported during the initial setup and some usage notes.


Schema
~~~~~~

.. include:: tpl/desc_schema.rst

.. automethod:: riptide.config.document.app.App.schema

Helper Functions
~~~~~~~~~~~~~~~~

.. include:: tpl/desc_var_helpers.rst

.. automethod:: riptide.config.document.app.App.parent

.. automethod:: riptide.config.document.app.App.get_service_by_role

.. automethod:: riptide.config.document.app.App.get_services_by_role
