Most Linux Distributions
------------------------

This guide will explain how to install Riptide under most Linux distributions.

Automatic Installation
~~~~~~~~~~~~~~~~~~~~~~
You can run the following command on Ubuntu, openSUSE or Arch Linux to automatically install Riptide:

.. code-block:: bash

  # Ubuntu (possibly Debian)
  curl https://raw.githubusercontent.com/theCapypara/riptide-docs/master/source/installer/ubuntu.sh | bash
  # openSUSE
  curl https://raw.githubusercontent.com/theCapypara/riptide-docs/master/source/installer/opensuse.sh | bash
  # Arch Linux
  curl https://raw.githubusercontent.com/theCapypara/riptide-docs/master/source/installer/arch.sh | bash

Running this requires you to have curl, Python and sudo installed.

The script will interactively guide you through installing all required dependencies.

The script will configure Riptide and make it available on next login. It will also install a `riptide` Systemd
service, Riptide's :doc:`proxy server </user_docs/proxy>`.

.. warning::
  Do not use this script for updating. See below on how updating works.

Manual Installation
~~~~~~~~~~~~~~~~~~~
You can follow these steps along to install Riptide yourself. 
This will do the same things as the automatic installer.

Installing Requirements
^^^^^^^^^^^^^^^^^^^^^^^

This guide assumes you want to run Riptide in the most common set-up using the Docker Engine.
To use Riptide you need to have the following installed:

* Python 3.8+
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

Installing Riptide
^^^^^^^^^^^^^^^^^^
Riptide should always be installed in a dedicated Python virtual environment to avoid conflicts between system packages and Riptide.

Choose a directory you want to store the virtualenv at, create a new virtualenv for Riptide and activate it:

.. code-block:: bash

  cd ~/virtualenvs  # This can be whereever you want
  python3 -m venv riptide
  source riptide/bin/activate # Activates the virtualenv

Then, to install all Riptide components and the Docker implementation run the following command:

.. code-block:: bash

  pip3 install riptide-all


After this you will need to re-activate the virtualenv every time you want to use Riptide, or add the Riptide commands to the PATH:

.. code-block:: bash

  # We asume ~/.local/bin is in the PATH and your virtualenv is at ~/virtualenvs. You can choose other directories if not.
  ln -s ~/virtualenvs/riptide/bin/riptide ~/.local/bin/riptide
  ln -s ~/virtualenvs/riptide/bin/riptide_proxy ~/.local/bin/riptide_proxy
  ln -s ~/virtualenvs/riptide/bin/upgrade_riptide ~/.local/bin/upgrade_riptide
  ln -s ~/virtualenvs/riptide/bin/riptide.hook.bash ~/.local/bin/riptide.hook.bash
  ln -s ~/virtualenvs/riptide/bin/riptide.hook.zsh ~/.local/bin/riptide.hook.zsh

If you do not have a ``~/.local/bin`` in your ``PATH`` and have no other suitable location, you can add ``~/.local/bin`` to the ``PATH`` by 
adding the following somewhere at the **top** of your ``.bashrc`` (before any of the Riptide shell integration; see below):

.. code-block:: bash

  export PATH=~/.local/bin:$PATH

Same thing applies if using ZSH, use the ``.zshrc`` instead. You can also use the ``.profile`` or ``.bash_profile`` or similiar files instead.
Please see your distributions documentation for more info.

You can test if Riptide is working:

.. raw:: html

   <script src="../_static/asciinema-player.js"></script>
   <asciinema-player src="../_static/casts/test_riptide.cast" cols="80" rows="24"></asciinema-player>

Initializing the configuration
..............................

You will then need to initialize the Riptide configuration if this is the first time using Riptide. If you used Riptide
before skip this step (this will otherwise reset your configuration):

.. code-block:: bash

   riptide config-edit-user --factoryreset

Allow writing to /etc/hosts
...........................

After this, make sure your user can edit the hosts file, this is required for Riptide to resolve
project hostnames (see :ref:`user_docs/configuration:Resolving hostnames and hosts-file`):

.. code-block:: bash

  sudo setfacl -m u:${USER}:rw /etc/hosts

Shell integration
.................

Riptide adds some additional features to your shell, in order to automatically add project
commands into your shell. Add the following lines to your .bashrc after any changes to PATH:

.. code-block:: bash

  # Riptide shell integration
  . riptide.hook.bash
  # Riptide code completion
  eval "$(_RIPTIDE_COMPLETE=source_bash riptide)"

If you use ZSH, add this to your .zshrc after any changes to PATH:

.. code-block:: zsh

  # Riptide shell integration
  . riptide.hook.zsh
  # Riptide code completion
  eval "$(_RIPTIDE_COMPLETE=source_zsh riptide)"

Systemd service
...............

Then you will need to configure the Systemd deaemon for the Riptide Proxy Server:

Create the following unit file under ``/etc/systemd/system/riptide.service``::

  [Unit]
  Description=Riptide

  [Service]
  ExecStart=<PROXY> --user=<USERNAME>
  Restart=on-failure

  [Install]
  WantedBy=multi-user.target

You need to replace ``<USERNAME>`` with your username and ``<PROXY>`` with the
full path to the proxy executable which you can get by calling ``which riptide_proxy``.

After that you need to reload the Systemd daemon:

.. code-block:: bash

  sudo systemctl daemon-reload

To enable autostart:

.. code-block:: bash

  sudo systemctl enable riptide

To start the proxy server right away:

.. code-block:: bash

  sudo systemctl start riptide

SSL Certificate
...............

Finally you want to import the SSL certificate authority. This allows your browser to trust
the Riptide proxy server. See :ref:`user_docs/proxy:Import the SSL certificate authority` for more details.


Updating Riptide
~~~~~~~~~~~~~~~~

To update Riptide, run:

.. code-block:: bash

  riptide_upgrade

Next steps
~~~~~~~~~~
You are now ready to use Riptide. Head to the user documentation for more information on how to use it:

- :doc:`/user_docs/configuration`: Learn how to configure Riptide
- :doc:`/user_docs/shell`: Learn how to use and customize the shell integration
- :doc:`/user_docs/proxy`: Learn how to use the Proxy Server
- :doc:`/user_docs/working_with_riptide`: Learn how to use Riptide with existing Riptide projects
- :doc:`/user_docs/project` and :doc:`/config_docs`: Learn how to use Riptide for new projects
