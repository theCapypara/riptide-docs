Windows
-------

This guide will explain how to install Riptide under Windows.

.. note:: Windows is not supported as well as the Linux setup. Most of the downsides
          of Riptide on Windows come from the Docker Desktop implementation for Windows.

          Also we can not offer any Windows specific support at the moment.

          If you have experience with Docker or Python on Windows, we'd love your support in making
          Riptide on Windows even better!

Installing Requirements
~~~~~~~~~~~~~~~~~~~~~~~

This guide assumes you want to run Riptide in the most common set-up using the Docker Engine.
To use Riptide you need to have the following installed:

* Python 3.6+
  * Download: `Python website <https://www.python.org/downloads/>`_.
* pip for Python 3 (might come installed with Python)
* `Docker Desktop 16.0+ <https://www.docker.com/products/docker-desktop>`_

There is a good chance you already have Python installed. Try running ``python3 --version`` to check.

Installing Riptide system-wide
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To install all common Riptide components and the Docker implementation run the following command::

  $ pip3 install riptide-proxy riptide-cli riptide-engine-docker

If you use databases, you may need to install additional components, called database drivers::

  $ pip3 install riptide-db-mysql # MySQL

You can test if Riptide is working:

.. raw:: html

   <script src="../_static/asciinema-player.js"></script>
   <asciinema-player src="../_static/casts/test_riptide.cast" cols="80" rows="24"></asciinema-player>


Installing Riptide in a Virtualenv
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Riptide can also be installed in a Virtualenv. This is only recommended for advanced Python
users. Please make sure, to use the correct Python interpreter of your Virtualenv when
`setting up the proxy server <6_project.html>`_.

Updating Riptide
~~~~~~~~~~~~~~~~

To update Riptide, run

  $ riptide_upgrade

Configuring shared drives
~~~~~~~~~~~~~~~~~~~~~~~~~
When installing Riptide on a drive other than C:, or when using projects from other drives,
you may need to share this drive with the Docker VM. A notice about this should automatically
open in this case.

Additional Windows related notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Many additional settings or issues not described in this documentation may be
directly related to the Docker Desktop for Windows implementation.

Please see the `documentation for Docker Desktop for Windows <https://docs.docker.com/docker-for-windows/>`_ for further information.

Known issues under Windows
~~~~~~~~~~~~~~~~~~~~~~~~~~

- Riptide currently uses the default Docker Desktop Windows daemon. This setup is known
  to have significantly worse performance than the Linux version.
- Due to the performance issues, when importing databases the first import attempt
  might fail. Please try again in this case.

.. note:: If you are a Windows developer and want to improve this situation, please contact us.
          A possible solution for the perfomance issues may be something like a
          `docker-sync <https://github.com/EugenMayer/docker-sync>`_ implementation
          for Riptide or using Docker with WSL2 instead of using Docker Desktop. If you do,
          please share your experience!

Get help and join the community
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you need some support or just want to chat with the community, join our
`Slack workspace <https://slack.riptide.parakoopa.de>`_.

Next steps
~~~~~~~~~~
The next pages of this documentation will explain
how to finish the setup of Riptide,
how to setup the Proxy server and
how to install the Bash/Zsh integration.
It will also teach you how to use the Riptide CLI and Proxy server.

Please make sure to read through all of the following pages of this documentation to properly
setup Riptide.
