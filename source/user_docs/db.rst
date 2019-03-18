Managing Databases
------------------

If your project uses a supported database you may be able to use the database
features of Riptide. These features allow you to manage different environments
of your database and to switch between them, for example if you are developing
a new feature.

.. note:: Database environments are an abstraction over whatever database management
          your database software comes with. It completely isolates the entire
          physical database files in different directories.

          If you switch the environment you tell Riptide
          to use a different directory for the data of your database.

Listing environments and status
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
``riptide db-status`` shows you the current database environment and
``riptide db-list`` lists them.

.. note:: If these commands fail with the message "No such command", then database
          management is not available for your project.


Creating a new environment
~~~~~~~~~~~~~~~~~~~~~~~~~~
Use ``riptide db-new NAME`` to create a new EMPTY database environment. This also switches
the current environment to this new one. See `Copying.html <#copying>`_ instead if you
want to copy an existing environment.

Importing and exporting
~~~~~~~~~~~~~~~~~~~~~~~
You can import and export dumps of the currently active database environment.
The format of this dump depends on the database driver that the project is using.

``riptide db-import FILE`` to import, ``riptide db-export FILE`` to export.

.. note:: Depending on the database driver this may export/import the entire database server
          with all "sub-databases" or only one active "sub-database".
          For the MySQL driver for example it only exports and imports
          one configured primary database.

Copying
~~~~~~~
To copy an existing environment, use ``riptide db-copy FROM TO``, where ``FROM``
is the name of the environment to copy from and ``TO`` the name of the new environment.

Switches to the new environment.

Deleting
~~~~~~~~
To delete an environment use ``riptide db-drop NAME``. You can not delete the
active environment.

.. warning:: This can not be undone.
