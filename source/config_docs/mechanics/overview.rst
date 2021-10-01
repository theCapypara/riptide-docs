.. cssclass:: no-admonition-variable-helper

Overview / Hierarchy
--------------------

Riptide's configuration is made up of a hierarchy of entities (also called objects or documents).

.. _system configuration: config.html
.. _project: projects.html
.. _projects: projects.html
.. _app: apps.html
.. _services: services.html
.. _commands: commands.html

The currently loaded configuration is based on the `system configuration`_ under
"`<CONFIG> <../index.html#Riptide-config-files>`_/config.yml" and the currently loaded project_, which
is read from a ``riptide.yml``. Additionally, if a ``riptide.local.yml`` exists, it's contents
are merged on top of the ``riptide.yml``.

Projects contain an App_, which contains Services_ and Commands_. And so the configuration forms a hierarchy of different entities:

.. image:: /_static/img/hierarchy.png


The entire (fully processed) configuration can be viewed by using the CLI command ``riptide config-dump``. Projects
are internally inserted under the system configuration:

.. code-block:: yaml

    $ riptide config-dump
    # Riptide configuration

    # This is the final configuration that was created by merging all configuration files together
    # and resolving all variables.
    # Includes some internal system keywords (keys with $, except $ref).
    riptide:
      engine: docker
      proxy:
        autoexit: 15
        autostart: true
        ports:
          http: 80
          https: 443
        url: riptide.local
      repos:
      - git@github.com:Parakoopa/riptide-repo-private.git
      update_hosts_file: true
      project:
        $path: /home/example/riptide/demo-project/riptide.yml
        app:
          commands:
            echo_me:
              $name: echo_me
              command: echo
              image: alpine
          name: dummy
          services:
            hello_world:
              $name: hello_world
              image: strm/helloworld-http
              port: 80
              run_as_current_user: false
              roles:
                - main
        name: dummy
        src: ./src

The files that make up each configuration entity are simple YAML files with a header depending
on their type.

Example project entity that contains one app entity under app. This app contains service entities
under "services".

.. code-block:: yaml

    project:
      name: foo
      src: .
      app:
        name: bar
        services:
          hello_world:
            image: strm/helloworld-http
            port: 80
            run_as_current_user: false
            roles:
              - main

Creating Projects
~~~~~~~~~~~~~~~~~
To create projects, create a new file called "riptide.yml" in the root of your project.

This file is a YAML file with the header "project". The rest of the file is filled with keys
and values, based on the project's schema. See Projects_ for more details.

Schemas
~~~~~~~
Each entity has a schema that defines it. The configuration files you create must fit to this schema.
The schema for all entities is explained in the following sections.

Variables
~~~~~~~~~
Strings in entity documents may contain variables. These variables are references to fields
in the same document.

Example:

.. code-block:: yaml

    project:
      name: foo
      src: .
      notes:
        usage: "Image - {{ app.services.hello_world.image }}"
      app:
        name: bar
        services:
          hello_world:
            image: strm/helloworld-http

Result:

.. code-block:: yaml

    project:
      name: foo
      src: .
      notes:
        usage: "Image - strm/helloworld-http"
      app:
        name: bar
        services:
          hello_world:
            image: strm/helloworld-http

Helper Functions
~~~~~~~~~~~~~~~~
In addition to variables, helper functions (also called "Variable Helpers") can be used to
perform advanced tasks. All entities have one helper called ``parent()`` that returns the parent
entity.

Example:

.. code-block:: yaml

  app:
    name: bar
    services:
      hello_world:
        image: '{{ parent().name }}'

Result:

.. code-block:: yaml

  app:
    name: bar
    services:
      hello_world:
        image: bar

In this example ``parent()`` is called on the service called ``hello_world``. The parent of this service
is the app, and so ``parent().name`` returns the name of the app.

Repositories
~~~~~~~~~~~~
Entities can contain references to other documents.

Example:

.. code-block:: yaml

  app:
    name: bar
    services:
      hello_world:
        $ref: /service/hello-world
        command: 'this will override the comnmand in /service/hello-world'

Riptide will load the entity contained in the file ``service/hello-world.yml`` inside one
of the repositories, that is specified in the `system configuration`_ and merge it with the
one defined here.

More information on repositories can be found under `"How Repositories work" <../using_repo/how_repositories.html>`_.

Details about how documents are processed
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
All of the properties described here are based on the Python library Configcrunch.

If you want additional information about the behaviour of Configcrunch, please have a look
at the `Configcrunch documentation <https://configcrunch.readthedocs.io/>`_.
