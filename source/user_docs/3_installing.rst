Installing Riptide
------------------

To install all common Riptide components and the Docker implementation run the following command::

  $ [sudo] pip3 install riptide-proxy riptide-cli riptide-engine-docker

If you use databases, you may need to install additional components, called database drivers::

  $ [sudo] pip3 install riptide-db-mysql # MySQL

You can test if Riptide is working:

.. raw:: html

   <asciinema-player src="../_static/casts/test_riptide.cast" cols="80" rows="24"></asciinema-player>

.. warning::
   Make sure to run these commands as root (using sudo) under Linux to install Riptide system-wide. Alternatively you can use Virtualenvs
   without sudo.

Updating Riptide
----------------

To update Riptide, run

  $ [sudo] riptide_upgrade

Whether or not you need to run the command as root, depends on how you installed Riptide. If in doubt, use sudo under Linux.

Configuration file
~~~~~~~~~~~~~~~~~~

Create your system configuration file using ``riptide config-edit-user``.
This will open an editor.

Leave everything on default for now, individual settings will be explained in the next sections.

Riptide CLI is now ready to use! Continue to the next chapters to learn how
to use it with a project and how to setup the Proxy Server.

.. raw:: html

  <script src="../_static/asciinema-player.js"></script>


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
