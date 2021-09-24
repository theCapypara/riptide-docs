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
  Detected Xdebug version: 3
  Mode: debug
  Extra configuration:
  Request trigger: no (xdebug.start_with_request=yes)

Enable / Disable XDebug
~~~~~~~~~~~~~~~~~~~~~~~
Use the following commands to toggle XDebug for all running services and all Riptide commands for a single project::

  $ riptide xdebug off
  $ riptide xdebug on

Xdebug Mode
~~~~~~~~~~~
By default Xdebug is configured to run in "develop" mode. Using the ``-m/--mode`` option you can change the mode
Xdebug should use. You can comma-seperate multiple modes.

This setting only applies to Xdebug 3.

Activation method
~~~~~~~~~~~~~~~~~
By default ``xdebug.start_with_request`` is set to ``yes``, so the only triggers configuring whether or not debugging
should happen are this command and your IDE listening for connections or not.

If you want, you can use ``--request/-r`` to set this value to ``trigger``. The debugger will then only connect if
it detects the cookie for it (see Xdebug documentation). To disable this again use ``--no-request/-R``.

This setting only applies to Xdebug 3.

Additional configuration
~~~~~~~~~~~~~~~~~~~~~~~~
You can pass additional configuration as comma-seperated key-value pairs using the option ``--config/-c``. This is the
same format as used by the ``XDEBUG_CONFIG`` environment variable.

For example, to set the ``xdebug.log`` and ``xdebug.log_level`` settings:

    riptide xdebug -c 'log=/tmp/xdebug.log,log_level=10' on

Xdebug Version
~~~~~~~~~~~~~~
The plugin tries to automatically detect the Xdebug version. For this it tries the following:

- First it checks if the environment variable (that Riptide is running with!)
  ``RIPTIDE_XDEBUG_VERSION`` is set to either ``2`` or ``3``.
- (**RECOMMENDED**) Otherwise it checks if the label ``php_xdebug_version`` of the image assigned to the first
  service in the app with the role `php`` is set to either ``2`` or ``3``.
- Otherwise, it checks if in the currently loaded configuration the environment variable
  ``RIPTIDE_XDEBUG_VERSION`` is set to either ``2`` or ``3`` at ANY service or comamnd in the app
  (absolutely not recommended).

Based on the determined value, it will set the correct Xdebug configuration. If no version could be detected,
Riptide will assume version 2 and output a warning.

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
