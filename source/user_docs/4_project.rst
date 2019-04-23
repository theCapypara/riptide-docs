Project Setup
-------------

The first time you want to use a project, it has to be set up.

For this part of the guide, we will be using a demo project to guide
you through the setup process.

This demo project contains everything you
may encounter while setting up real projects, so we recommend you place this
demo project into an empty directory and follow this guide first before
setting up a real project.

Demo project (place in ``riptide.yml`` in empty directory):

.. code-block:: yaml

    project:
      name: dummy
      src: .
      app:
        name: dummy
        import:
          dummy_directory:
            target: dummy-files
            name: Anything-this-is-just-a-demo
        notices:
          usage: This usage text shows you additional things you need to do when running this project.
        services:
          hello_world:
            image: strm/helloworld-http
            port: 80
            run_as_current_user: false
            roles:
              - main
          db:
            image: mysql:8.0
            roles:
              - db
            driver:
              name: mysql
              config:
                database: dummy
                password: mysql
            run_as_current_user: false
        commands:
          mysql:
            image: "{{ parent().get_service_by_role('db').image }}"
            command: "mysql -hdb -uroot -pmysql dummy"

Running the first-time setup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To run the first-time setup run::

  $ riptide -u setup
  Updating Riptide repositories...
      ...

  Updating images...
      [service/hello_world] Pulling 'strm/helloworld-http':
          Done!
      [command/db] Pulling 'mysql:8.0':
          Done!
      [command/mysql] Pulling 'mysql:8.0':
          Done!
      Done!

  End of --update.

  Thank you for using Riptide!
  This command will guide you through the initial setup for dummy.
  Please follow it very carefully, it won't take long!
  > Press any key to continue...

This will update all repositories and images and start the setup. After starting the setup, press any key::

  > BEGIN SETUP

  Usage notes for running dummy with Riptide:
      This usage text shows you additional things you need to do when running this project.

  > Do you wish to run this interactive setup? [Y/n]


.. tip:: ``-u`` or ``--update`` is for updating your repositories and Docker images
         You can add this flag to any command. Riptide will then first update before running the rest of the command.
         You should run this command regularly to make sure your images and repositories are up to date.
         Images contain the file system of the container that Riptide will run.
         See the `Docker documentation <https://docs.docker.com/get-started/#images-and-containers>`_ for more details on images.
         See `Using Repositories <repos.html>`_ for more information on repositories.


Riptide will then show you the usage notes that
are defined for the app your project is using. This usage note may contain additional steps
you need to run **after** the setup. If you need to view this again, run ``riptide notes`` after the setup.

Confirm that you want to run the interactive setup by pressing ``y``.

.. tip:: If you accidentally press ``n`` or make a mistake later during the setup, you can always restart it
         by passing the ``--force`` option.


After pressing ``y`` you will be asked what kind of setup you want to do::

  > INTERACTIVE SETUP
  > Are you working on a new project that needs to be installed or do you want to Import existing data? [n/I]

If you press ``n`` Riptide will exit and show you instructions for the first-time installation of the application
you are using. Follow these instructions.

If you press ``i`` you will be guided through the import of existing data. What can be imported depends on the project.
For this dummy project, a MySQL database can be imported, Riptide will tell you this after you pressed ``i``::

  > EXISTING PROJECT
    > DATABASE IMPORT
  > Do you want to import a database (format mysql)? [Y/n]

For this demo, open a text editor and put the following contents in a file called ``demo.sql``::

  CREATE TABLE Hello (
      World varchar(255)
  );

Enter ``y`` to confirm that you want to import an SQL file::

  Enter the path to the SQL file.

Enter the path to the SQL file that you just downloaded::

  Enter the path to the SQL file. demo.sql
  -----
  Starting services...

  mysql: 2/6|████████████▎                        | Pulling image... Downloading :...

You can see that the database is now starting, your SQL file will be imported shortly::

  -----
  Starting services...

  mysql: 6/6|█████████████████████████████████████| Started!

  Waiting for database...
  Importing into database environment default... this may take a while...

  Database environment default imported.

  -----

After the database is imported, the project may ask you to import other directories,
such as directories containing media files or configuration specific to the application::

  -----
      > FILE IMPORT
          > dummy_directory IMPORT
      > Do you wish to import Anything-this-is-just-a-demo to <project>/dummy-files? [Y/n]

In our example it doesn't really matter. You may try this out by confirming with ``y`` and entering
a path to a directory. It will be copied into the dummy-files directory inside the current directory::

  > Do you wish to import Anything-this-is-just-a-demo to <project>/dummy-files? [Y/n] y
  Enter path of files or directory to copy: /tmp/test_dir
  -----
  Importing dummy_directory (dummy-files) from /tmp/test_dir
  Copying... this can take some time...
  Done!
  -----

After the import, or after you skipped it, Riptide will inform you that it is done::

  > IMPORT DONE!
  All files were imported.

  DONE!

  ...

Next steps
~~~~~~~~~~

The project is now set-up. If you are setting up a real project, there may need
to be some additional steps you have to do now, that you were told in the usage notes.
If you need to view these notes again run ``riptide notes``. This will show you both
the general usage notes, that may contain things you need to do after importing an existing project,
and installation notes, for starting from scratch.

Please follow the next pages of this guide to setup
Bash and Zsh integration and the Proxy Server.

If you want to import databases or files later on, see `Managing Databases <db.html>`_
and `Importing Files <import.html>`_.
