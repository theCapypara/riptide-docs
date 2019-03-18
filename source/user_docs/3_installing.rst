Installing Riptide
------------------

.. note:: This section is WIP for the release of Riptide. Currently it only
         shows how to install Riptide at Tudock.

To install Riptide follow these steps:

1. Make a ``riptide`` directory somewhere, best place is you home directory::

     $ mkdir ~/riptide
     $ cd ~/riptide

2. Clone the Riptide CLI repository::

     $ git clone ssh://git@k4101.pixsoftware.de:7999/riptide/cli.git cli

3. Optional: Set-up a dedicated `Virtualenv <https://docs.python-guide.org/dev/virtualenvs/>`_
   for Riptide. Skip this if you don't know what this means.

4. Run the installation script. You will be asked if ``sudo`` is required to run ``pip`` commands.
   If you are on Linux and NOT using a Virtualenv say ``y``, otherwise and on other platforms say ``n``::

     $ cd cli
     $ ./install-dev-td.sh

5. The installer has cloned all other repositories and set-up python.
   You can test if Riptide is working:

   .. raw:: html

     <asciinema-player src="../_static/casts/test_riptide.cast" cols="80" rows="24"></asciinema-player>

6. Create your system configuration file using ``riptide config-edit-user``.
   This will open an editor.

   Leave everyhting on default for now, except ``repo`` where you may enter
   adresses to Git repositories with common Riptide assets.

   For Tudock enter ``ssh://git@k4101.pixsoftware.de:7999/riptide/repo.git``.

   Everything else will be configured later in the chapter `Proxy Server Setup <6_proxy.html>`_.

   .. raw:: html

     <asciinema-player src="../_static/casts/user_config.cast" cols="80" rows="24"></asciinema-player>

7. Riptide CLI is now ready to use! Continue to the next chapters to learn how
   to use it with a project and how to setup the Proxy Server.

.. raw:: html

  <script src="../_static/asciinema-player.js"></script>


Resolving hostnames & permissions for the /etc/hosts file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Riptide uses a proxy server to route traffic to your projects. This proxy server
uses hostnames to route traffic. These hostnames need to be routable to your local machine.

In order to make this easy for you, Riptide (by default) automatically updates the /etc/hosts file
(may have a `different path under different OSes <https://en.wikipedia.org/wiki/Hosts_(file)#Location_in_the_file_system>`_).
However in order to do so, **your local user needs write access to this file**.
To change permissions under Linux, you can use the following command::

   sudo setfacl -m u:<YOUR USERNAME>:rw  /etc/hosts

Replace ``<YOUR USERNAME>`` with your ussername.

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
