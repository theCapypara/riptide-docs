PHP Debugging with XDebug
-------------------------

By default XDebug is disabled when using PHP projects, for performance reasons.

If you want to enable XDebug, make sure you have the ``riptide-plugin-php-xdebug`` package installed.
This is installed by default since Riptide 0.5.0.

See Status of XDebug
~~~~~~~~~~~~~~~~~~~~
To see if XDebug is currently enabled for a project, use the following command::

  $ riptide xdebug
  Xdebug status for riptidedocs: Disabled.

Enable / Disable XDebug
~~~~~~~~~~~~~~~~~~~~~~~
Use the following commands to toggle XDebug for all running services and all Riptide commands for a single project::

  $ riptide xdebug off
  $ riptide xdebug on

Enable XDebug in PHPStorm
~~~~~~~~~~~~~~~~~~~~~~~~~
When XDebug is enabled, it will automatically try to connect.

Enable Remote Debugging in PHPStorm to accept debugging connections:

.. image:: /_static/img/xdebug_1.png

When a service container tries to connect for the first time, you have to configure path mappings.
You will see the following warning in the debugging window of PhpStorm:

.. image:: /_static/img/xdebug_2.png

Click on "Configure Server". Create a new server entry and as a "Name" enter the name that was shown in
the previous warning (in this case ``riptide-demo-xdebug``). As "Host" enter the URL of the project/service.

Check "Use path mappings". Select the sub-directory your ``src`` entry of your ``riptide.yml`` points to.
In this example ``src`` is ``.``, so we will select the top project directory. Enter ``/src`` as
"Absolute Path on the server" and save.

.. image:: /_static/img/xdebug_3.png

The debugger should now work for this project.
