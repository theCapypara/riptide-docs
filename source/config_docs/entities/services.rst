.. cssclass:: no-admonition-variable-helper

Services
--------

A service is the definition of a software container that contains one of the applications
required to run the entire `app <./app.html>`_.

Since services are container definitions, they need to contain at least the name of an image to run.
All other fields are optional.

Schema
~~~~~~

.. include:: tpl/desc_schema.rst

.. automethod:: riptide.config.document.service.Service.schema

Helper Functions
~~~~~~~~~~~~~~~~

.. include:: tpl/desc_var_helpers.rst

.. automethod:: riptide.config.document.service.Service.parent

.. automethod:: riptide.config.document.service.Service.system_config

.. automethod:: riptide.config.document.service.Service.volume_path

.. automethod:: riptide.config.document.service.Service.get_working_directory

.. automethod:: riptide.config.document.service.Service.domain

.. automethod:: riptide.config.document.service.Service.os_user

.. automethod:: riptide.config.document.service.Service.os_group

.. automethod:: riptide.config.document.service.Service.host_address

.. automethod:: riptide.config.document.service.Service.home_path

.. automethod:: riptide.config.document.service.Service.get_tempdir

Helpfer Functions for configuration files
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The helper functions listed here can only be used inside files used with the ``config`` setting
of services.

.. autofunction:: riptide.config.service.config_files_helper_functions.read_file
