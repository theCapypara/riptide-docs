NodeJS Hello World
------------------
This section will guide you through the setup of a simple NodeJS project using the Riptide repository.

This guide assumes you have Riptide fully set up, with shell integration enabled
and a running proxy server
(for this guide we assume ``https://riptide.local`` as base URL of your proxy server). It also
assumes you have the ``repos`` part of the configuration set to only the Riptide Community Repository
(the default).

**NodeJS does NOT need to be installed for this guide.**

Preparing the project
~~~~~~~~~~~~~~~~~~~~~
For this guide we will set up a very simple Express-based web server. You can probably adapt this
guide to more complex applications.

Create a new directory and create an ``index.js`` in it with the following contents:

.. code-block:: js

    // Source: https://expressjs.com/starter/hello-world.html
    var express = require('express');
    var app = express();

    app.get('/', function (req, res) {
      res.send('Hello World!');
    });

    app.listen(3000, function () {
      console.log('Example app listening on port 3000!');
    });

Create a ``package.json`` containing express as a dependency:

.. code-block:: json

    {
      "name": "js-helloworld",
      "dependencies": {
        "express": "^4.16.4"
      }
    }

Creating a basic riptide.yml
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _project: /config_docs/entities/projects.html
.. _app: /config_docs/entities/apps.html
.. _service: /config_docs/entities/services.html

Create a ``riptide.yml`` with the following contents:

.. code-block:: yaml

    project:
      name: js-helloworld
      src: .
      app:
        name: js-helloworld
        services:
          nodejs:
            image: node:10
            command: 'node index.js'
            port: 3000
            roles:
              - src
              - main

This file contains one project_ named ``js-helloworld``. We specify with ``src`` that the source
code for this project is in the same directory that the ``riptide.yml`` is in.

This project_ contains an app_ called ``js-helloworld``.
This app_ has one service_ called ``nodejs``. This service_ is the container specification for our Hello World
app.

The service_ ``nodejs`` needs a Docker image with Node.js in it, so we specify the ``image`` ``node:10``.
Our script is in the ``index.js``, so we tell Riptide to run ``node index.js`` as the ``command`` of
our service.

Our Hello World app (http) runs on port ``3000``, so we tell Riptide this by setting ``port`` to it.

The final step is adding ``roles``. Roles define the behaviour of services.

The ``src`` role gives our service access to the source code (the ``index.js`` file). The ``main``
role sets the service as the main service for our project.

Adding commands for NPM
~~~~~~~~~~~~~~~~~~~~~~~

Next we need to add the ``node`` and ``npm`` commands to our project, so that we can run ``npm``
to install express from the ``package.json``.

Add the following under ``app`` in the ``riptide.yml``:

.. code-block:: yaml

    commands:
      node:
        $ref: /command/node/10
      npm:
        $ref: /command/npm/node10

This adds two new commands, one containing NodeJS and one containing npm. All npm processes
started will also have access to the directory ``.npm`` in your home directory and your ``.npmrc``.

Those commands come from the Riptide repository, if you want to know how they work, visit the repository:

- `/command/node/10 <https://github.com/Parakoopa/riptide-repo/tree/master/command/node>`_
- `/command/npm/node10 <https://github.com/Parakoopa/riptide-repo/tree/master/command/npm>`_

Running the project setup
~~~~~~~~~~~~~~~~~~~~~~~~~
Run ``riptide setup --skip`` to initiate the project. Since we have not added any setup instructions or
files to import, we just skip the setup with the ``--skip`` flag.

Installing requirements
~~~~~~~~~~~~~~~~~~~~~~~
If you have the shell integration enabled, leave and enter the directory again, this will load
the configured ``npm`` and ``node`` commands. You can now run ``npm install``, which will install
express and create a directory named ``node_modules``.

Starting the project
~~~~~~~~~~~~~~~~~~~~
Since the project's dependencies (express) are now installed, you can open the front page
of the Proxy server (``https://riptide.local``). You will find a new project called ``js-helloworld``.

Click on the link and the project will start. After it starts you will see the "Hello World!" message
telling you, that the project works.

Enable logging
~~~~~~~~~~~~~~
If you want to enable logging, add the following lines to the service ``nodejs``:

.. code-block:: yaml

        logging:
          stdout: true
          stderr: true

You can restart the project by using ``riptide restart``. After the restart you will find
logging files in ``_riptide/logs/nodejs``.

Adding files for import and setup instructions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
For our simple example there are no files to import and we don't really need any setup instructions.

However the ``riptide setup`` command supports usage notes and importing files, as you can see
in the `User Documentation <../../user_docs/4_project.html>`_. You can also see an example project there.

To add usage notes, add the following to the ``app``:

.. code-block:: yaml

  notices:
    usage: >-
      This is a demo usage note.

      You can also use variables here: {{ services.nodejs.image }}

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
