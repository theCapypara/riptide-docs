Linux
-----

This guide will explain how to install Riptide under Linux distributions.

Installing Requirements
~~~~~~~~~~~~~~~~~~~~~~~

This guide assumes you want to run Riptide in the most common set-up using the Docker Engine.
To use Riptide you need to have the following installed:

* Python 3.6+
* pip for Python 3 (might come installed with Python)
    * on Ubuntu ``sudo apt-get install python3-pip``
* `Docker 16.0+ <https://docs.docker.com/install/>`_
    * Do **NOT** install Docker via Snap. Follow the instructions on the page linked.
    * Make sure to also follow the `post-installation steps <https://docs.docker.com/install/linux/linux-postinstall/>`_.
* `python-prctl <https://github.com/seveas/python-prctl>`_ requirements:
    * on Ubuntu: ``sudo apt-get install build-essential libcap-dev``
    * on Fedora: ``sudo yum install gcc glibc-devel libcap-devel``

Python is available using package managers.

There is a good chance you already have Python installed. Try running ``python3 --version`` to check.

Installing Riptide system-wide
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To install all Riptide components and the Docker implementation run the following command::

  $ sudo pip3 install riptide-all

Make sure this command is run with sudo!

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

  $ [sudo] riptide_upgrade

If you installed Riptide system-wide and not in a Virtualenv, you **MUST** use sudo.
Failing to to so may break your installation.

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
