Configuration
-------------
This page will show you how to edit the system configuration file of Riptide (also refered to as "user configuration file").

Initial configuration
~~~~~~~~~~~~~~~~~~~~~

Create your system configuration file using ``riptide config-edit-user``.
This will open an editor.

Leave everything on default for now, individual settings will be explained below.

After creating the configuration file using this command, Riptide CLI is now ready to use!
Continue to the next chapters to learn how to use it with a project and how to setup the Proxy Server.

.. raw:: html

  <script src="../_static/asciinema-player.js"></script>

Proxy server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~
The configuration for the Proxy Server is described in the chapter `Proxy Server Setup <5_proxy.html>`_.

Repository configuration
~~~~~~~~~~~~~~~~~~~~~~~~
The ``repos`` key contains a list of repositories, that are used by Riptide to look up components of projects.

By default the community repository is the only repository in this list. Please see `Using Repositories <repos.html>`_ for more info.

Engine configuration
~~~~~~~~~~~~~~~~~~~~
The entry under ``engine`` defines which container engine implementation is used. Currently only ``docker`` is supported.

Editing the configuration file manually
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You can use the command ``riptide config-edit-user`` to edit the configuration file.

Alternatively you can also directly edit the file
"`<CONFIG> <../index.html#Riptide-config-files>`_/config.yml".
 in your favorite editor.

Advanced: Resolving hostnames & /etc/hosts file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Riptide uses a proxy server to route traffic to your projects. This proxy server
uses hostnames to route traffic. These hostnames need to be routable to your local machine.

In order to make this easy for you, Riptide (by default) automatically updates the /etc/hosts file
(may have a `different path under different OSes <https://en.wikipedia.org/wiki/Hosts_(file)#Location_in_the_file_system>`_).
However in order to do so, **your local user needs write access to this file**.
To change permissions under Linux, you can use the following command::

   sudo setfacl -m u:<YOUR USERNAME>:rw  /etc/hosts

Replace ``<YOUR USERNAME>`` with your username.

If you don't want to change permissions to the file, you can instead add these entries manually.
If Riptide can't update the file, it will prompt you with a message, whenever it needs updating:

.. image:: /_static/img/guide_hosts_warning.png

Manual routing
^^^^^^^^^^^^^^
Alternatively you can disable the automatic update of the hosts file by setting ``update_hosts_file``
to ``false`` in the configuration file.

In this case, you need to make sure, all project URLs are routed correctly via DNS.

Assuming you set the proxy server to run under ``riptide.local`` the following hostnames must be routable
to your local machine using DNS:

* ``riptide.local``
* ``*.riptide.local``
