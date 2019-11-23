PHP Hello World
---------------
This section will guide you through the setup of a simple PHP project using the Riptide repository.

We will use an Apache web server, the other guide (`PHP with Database, Redis and Composer <./php_complex.html>`_) shows how to use an Nginx server.

This guide assumes you have Riptide fully set up, with shell integration enabled
and a running proxy server
(for this guide we assume ``https://riptide.local`` as base URL of your proxy server). It also
assumes you have the ``repos`` part of the configuration set to only the Riptide Community Repository
(the default).

**PHP and Apache do NOT need to be installed for this guide.**

Preparing the project
~~~~~~~~~~~~~~~~~~~~~
For this guide we will set up a very simple PHP file.

Create a new directory and create an ``index.php`` in it with the following contents:

.. code-block:: php

    <?php echo "Hello World!"; ?>

Creating a basic riptide.yml
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _project: ../entities/projects.html
.. _app: ../entities/apps.html
.. _service: ../entities/services.html

Create a ``riptide.yml`` with the following contents:

.. code-block:: yaml

    project:
      name: php-helloworld
      src: .
      app:
        name: php-helloworld
        services:
          php:
            $ref: /service/php/7.2/apache
            roles:
              - src
              - main

This file contains one project_ named ``php-helloworld``. We specify with ``src`` that the source
code for this project is in the same directory that the ``riptide.yml`` is in.

This project_ contains an app_ called ``php-helloworld``.
This app_ has one service_ called ``php``. This service_ is the container specification for our Hello World
app.

The service_ ``php`` needs Apache and PHP so we tell it to load ``/service/php/7.2/apache`` from the Riptide repository.
You can find more details and the YAML file for this on `Github <https://github.com/Parakoopa/riptide-repo/tree/master/service/php>`_.

The final step is adding ``roles``. Roles define the behaviour of services.

The ``src`` role gives our service access to the source code (the ``index.php`` file). The ``main``
role sets the service as the main service for our project.

Running the project setup
~~~~~~~~~~~~~~~~~~~~~~~~~
Run ``riptide setup --skip`` to initiate the project. Since we have not added any setup instructions or
files to import, we just skip the setup with the ``--skip`` flag.

Starting the project
~~~~~~~~~~~~~~~~~~~~
Open the front page of the Proxy server (``https://riptide.local``).
You will find a new project called ``php-helloworld``.

Click on the link and the project will start.
After it starts you will see the "Hello World!" message
telling you, that the project works.

Enable logging
~~~~~~~~~~~~~~
If you want to enable additional logging, add the following lines to the service ``php``:

.. code-block:: yaml

        logging:
          stdout: true
          stderr: true

You can restart the project by using ``riptide restart``. After the restart you will find
logging files in ``_riptide/logs/php``. Apache error log is in ``stderr.log`` and Apache access log
in ``stdout.log``.

Adding files for import and setup instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
For our simple example there are no files to import and we don't really need any setup instructions.

However the ``riptide setup`` command supports usage notes and importing files, as you can see
in the `User Documentation <../../user_docs/6_project.html>`_. You can also see an example project there.

To add usage notes, add the following to the ``app``:

.. code-block:: yaml

  notices:
    usage: >-
      This is a demo usage note.

      You can also use variables here: {{ services.php.image }}

    installation: >-
      This will be shown when the user chooses to set up a new project.

The user (and you) can view those notes by calling ``riptide notes``. They are also shown
during ``riptide setup``. The first one is shown in the beginning during the setup and the second
if the uses chooses to install a new project. Use the first notice for general usage notes and post
installation steps and the second as a guide for setting up completely new projects.

You can also specify files to import. During ``riptide setup`` the user will be asked if they
want to import the file or directory. When they choose to do it, Riptide will copy the files
and directories inside the project.

Example:

.. code-block:: yaml

  import:
    example:
      target: "readme.txt"
      name: Readme file

If you run ``riptide setup --force`` you can run the setup wizard for your project again.

You will see the notice, and if you choose to setup an existing project, you can specify a
"Readme file" to import to ``readme.txt``. Try it out and you will see, that Riptide copies
the directory or file you specify to ``readme.txt`` inside your project.
