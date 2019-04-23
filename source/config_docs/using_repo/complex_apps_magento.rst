Magento
-------
This section will guide you through the setup of a Magento 2 project using the Riptide repository.

Magento is an eCommerce platform written in PHP.
Riptide has templates for both Magento 1 and Magento 2 projects.
This guide will only describe the Magento 2 app. In the `Repository Documentation <../../repo_docs.html#apps>`_ you can find more
information about the Magento 1 and Magento 2 templates.

This guide is an example on how to use Riptide with more complex applications and a guide
for setting up Magento 2.

This guide assumes you have Riptide fully set up, with shell integration enabled
and a running proxy server
(for this guide we assume ``https://riptide.local`` as base URL of your proxy server). It also
assumes you have the ``repos`` part of the configuration set to only the Riptide Community Repository
(the default).

**PHP or Magento do NOT need to be installed for this guide.**

Creating a project
~~~~~~~~~~~~~~~~~~

.. _project: /config_docs/entities/projects.html
.. _app: /config_docs/entities/apps.html

To create a project, create a new file named ``riptide.yml`` with the following contents:

.. code-block:: yaml

    project:
      name: magento-demo
      src: src
      app:
        $ref: /app/magento2/ce/2.3

This file defines a project_ named ``magento-demo``. The project uses the app_ ``/app/magento2/ce/2.3``
from the Riptide repository (`Github <https://github.com/Parakoopa/riptide-repo/tree/master/app/magento2>`_).

We choose the ``src`` directory to install Magento in.

The Magento 2 app comes with PHP-FPM, Nginx, Varnish, MySQL, Redis, RabbitMQ and Mailhog as Mailcatcher.
The default configuration should be suited for most needs, but the next steps of this guide
will also show you, how to customize your Magento 2 installation.

You can change the version (``2.3``) if you want to install another Magento version.

The default database name is ``magento2``, the user is ``root`` and the password ``magento2``.
If you want to change these settings, you have to change the database driver configuration for the
``db`` service like so:

.. code-block:: yaml

    project:
      name: magento-demo
      src: src
      app:
        $ref: /app/magento2/ce/2.3
        services:
          db:
            driver:
              config:
                password: demo
                database: demo

Project setup
~~~~~~~~~~~~~
To get started, run the project setup (``riptide setup``). You will be asked, if you want to start with an existing
option or install a new Magento 2 installation.

For this guide we will choose to install a new Magento 2 shop. If you choose to install an
existing shop, Riptide will ask you to import a MySQL dump and media files (``pub/media``).

Magento installation
~~~~~~~~~~~~~~~~~~~~
After the project setup, when selecting to install a new project,
the following message will be displayed to you::

    > NEW PROJECT
    Okay! Riptide can't guide you through the installation automatically.
    Please read these notes on how to run a first-time-installation for magento2-ce-2.3.

    Installation instructions:
         To install Magento run the following commands on the command line:

          # 0. Download the Magento source code (replace with 'enterprise-edition' if you want):
          mkdir -p <project_directory_root>/src
          cd <project_directory_root>/src
          riptide cmd composer create-project --repository=https://repo.magento.com/ --ignore-platform-reqs magento/project-community-edition ./

          # 1. Dump the autoloader
          cd ./
          riptide cmd composer dump-autoload

          # 2. Start the database and redis
          riptide start -s redis,db

          # 3. Install Magento using the CLI.
          riptide cmd magento setup:install \
            --base-url=https://magento-demo.riptide.local/ \
            --db-host=db \
            --db-name=demo \
            --db-user=root  \
            --db-password=demo \
            --admin-firstname=Admin \
            --admin-lastname=Admin \
            --admin-email=email@yourcompany.com \
            --admin-user=admin \
            --admin-password=admin123 \
            --language=en_US \
            --currency=USD \
            --timezone=America/Chicago \
            --use-rewrites=1

          # 3. (Optional) install sample data
          riptide cmd magento sampledata:deploy

          # 4. Run setup:upgrade
          riptide restart -s redis
          riptide cmd magento setup:upgrade

        You can change the settings in step 3 to your likings, see the installation guide at
          https://devdocs.magento.com/guides/v2.3/install-gde/install/cli/install-cli.html

These instructions may vary for you. Follow the instructions shown to you to set up your shop.

If shell integration is correctly set up you can also omit the prefix ``riptide cmd`` from commands.
You may need to close and reopen your terminal once for this to work.

If you get started with an existing project, follow the project setup for existing projects.
Please note that you need to follow the instructions shown at the beginning of the setup wizard then,
You can also show the instructions again by running ``riptide setup``. This will show both the
instructions for new installations (on the top) and for existing projects ("General Usage notice")
on the bottom.

Starting Magento
~~~~~~~~~~~~~~~~
After you installed Magento, go to the front page of your proxy server (eg. ``https://riptide.local``).
You will find the various services for the Magento 2 shop there:

.. image:: /_static/img/magento_proxy.png

The service named varnish is the main entrypoint for your shop. Click on the link. This
will open your installed Magento 2 shop.

Mailhog
~~~~~~~
The Magento app comes with a mail catcher (Mailhog). You can find it by accessing the link
of the ``mail`` service on the proxy server front page. This mail catcher will collect
all emails sent by the Magento shop.

Commands (magento, composer, n98-magerun2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The Magento app comes with a variety of commands for you to use. You can list them with ``riptide cmd``::

    Commands:
        - php
        - magerun
        - n98-magerun (alias for magerun)
        - n98-magerun2 (alias for magerun)
        - magerun2 (alias for magerun)
        - mysql
        - magento
        - composer

You have access to the PHP interpreter used for the shop (``php``). The ``mysql`` command gives
you direct access to the database (see below). ``magento`` is the ``bin/magento`` command. You can NOT
access ``bin/magento`` directly. Instead use the ``magento`` command provided by Riptide::

   $ magento cache:flush
   Flushed cache types:
   config
   layout
   block_html
   collections
   reflection
   db_ddl
   compiled_config
   eav
   customer_notification
   config_integration
   config_integration_api
   full_page
   config_webservice
   translate
   vertex

In addition to those commands, you also have access to composer (``composer``) and
`n98-magerun2 <https://github.com/netz98/n98-magerun2>`_ by Netz98.

Additionally you can open a console to the containers for the services by using ``riptide exec <service_name``, eg.
``riptide exec php``. You can also open a root console by passing the flag ``--root``.

Accessing the database
~~~~~~~~~~~~~~~~~~~~~~
To access the database, you have to start it first (either via the Proxy server or by running ``riptide start``.

You can access the database directly simply by executing ``mysql``. Additionally you can
access the database using your favorite SQL client. To get the port you can access the database
from, see `this section <../../user_docs/7_working_with_riptide.html#access-other-tcp-udp-ports>`_
of the User Documentation.

Adding own services and commands
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you want to add your own services and commands, simply add new entries under ``services``
or ``commands`` in the project file:

.. code-block:: yaml
   :emphasize-lines: 12-22,24-27

    project:
      name: magento-demo
      src: src
      app:
        $ref: /app/magento2/ce/2.3
        services:
          db:
            driver:
              config:
                password: demo
                database: demo
          styleguide:
            image: node:8
            roles:
              - src
            working_directory: styleguide
            command: node_modules/.bin/gulp serve
            port: 3000
            pre_start:
              - npm install
              - node_modules/.bin/gulp clean
              - node_modules/.bin/gulp build
        commands:
          node:
            $ref: /command/node/8
          npm:
            $ref: /command/npm/node8
