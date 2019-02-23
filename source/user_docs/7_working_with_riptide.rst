Working with Riptide
--------------------

Now you have everything set up! It is time to access your project through Riptide.

This part of the guide will show you how to do daily tasks with Riptide.

Access your projects webservices
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
First make sure that the proxy server is started. After that head to the
URL you configured for the proxy. You should be greeted with a landing page:

.. image:: /_static/img/guide_landing_page.png

As you can see, projects with all services that have HTTP capabilities
are listed here. You can click on a link to access the service.

All service URLs have the following structure::
  <project>(__<service>).<proxy-url>

If your service is configured to be the main service of the URL, it's url is simply
the URL of the project (eg. ``dummy.riptide.local``). If your project has multiple
services, than the other services are accessible by adding two underscores to the
name of the project (eg. ``dummy__service2.riptide.local``).

Accessing the dummy project's hello_wold service as shown in the screenshot above,
will present you with the autostart page of this webservice:

.. image:: /_static/img/guide_autostart.png

After your project has started up, you will see the contents served by your webservice:

.. image:: /_static/img/guide_hello_world.png

Access other TCP/UDP ports
~~~~~~~~~~~~~~~~~~~~~~~~~~
A project may provide other, non HTTP services.  Riptide allows services to define
additional ports which will be bound to your local machine on a port that will always
stay the same.

For example, if you have two projects, both with a MySQL server that would normally run
on port 3306, then the first project may reserve the port 3306 and the second one 3307.
The ports will always stay the same for these projects so you can configure your
SQL software accordingly.

To view the additional ports for a project, run ``riptide status`` after the services
have been started:

.. image:: /_static/img/guide_ports.png

Running CLI commands
~~~~~~~~~~~~~~~~~~~~
.. note:: This section assumes you have the `Shell Integration <5_shell>`_ set up.
          If not, prefix all commands with ``riptide cmd``.

A project may define helpful shell commands for you to use.

To list them run ``riptide cmd``::

  $ riptide cmd
    Commands:
        - mysql

To run a command, simply execute it on the shell (you need to be inside the project directory)::

  $ mysql --help
  mysql: [Warning] Using a password on the command line interface can be insecure.
  mysql  Ver 8.0.15 for Linux on x86_64 (MySQL Community Server - GPL)
  ...


.. warning:: When using the shell integration and you have just set up a project, you need
             to leave and re-enter the project to use commands.

.. warning:: Piping (``|``, ``<``, ``>``) is not supported for Riptide commands.
             If you need to pipe input, you may be able to run the command directly
             in the `shell of a service <#directly-access-the-shell-of-a-service>`_.

.. warning:: The ``--help`` flag does not work as expected when running commands with
             ``riptide cmd``, it will always show the help for
             ``riptide cmd`` instead. Please set up the shell integration if you need
             the ``--help`` flag.

Starting and stopping services via CLI
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You can start and stop services on the CLI by using the ``start``, ``restart``
and ``stop`` commands. You can pass the ``-s`` flag to only affect certain services
(comma sperated)::

  $ riptide stop -s hello_world,db
  Stopping services...

  hello_world: 2/3|██████████████████████████████████▋                 | Stopping...
  db         : 3/3|████████████████████████████████████████████████████| Stopped!


To view the names and status of all services run ``riptide status``.

Directly access the shell of a service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This should usually not be required, but you can directly access the shell of the
containers the services run in by running ``riptide exec service_name``.

If you need root access inside of the container, pass the flag ``--root``.
