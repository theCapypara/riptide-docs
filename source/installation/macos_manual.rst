Manual MacOS Setup
------------------

This guide will explain how to install Riptide under MacOS. If possible you may want to consider using the
:doc:`nix-darwin setup <macos_nix_darwin>` instead. It is more experimental but much more conveniant and comes with
more features out of the box (such as proxy autostart, which is otherwise not supported for macOS).

.. note:: MacOS is not supported as well as the Linux setup. Most of the downsides
          of Riptide on MacOS come from the Docker Desktop implementation for MacOS.

          Riptide has some `Performance optimizations`_ to increase
          the performance on Mac, but it will still be slower than running it on Linux.

          If you have experience with Docker or Python on MacOS, we'd love your support in making
          Riptide on MacOS even better!

.. _Performance optimizations:  performance_optimizations.html

Installing Requirements
~~~~~~~~~~~~~~~~~~~~~~~

This guide assumes you want to run Riptide in the most common set-up using the Docker Engine.
To use Riptide you need to have the following installed:

* Python 3.8+
* pip for Python 3 (might come installed with Python)
* `Docker Desktop 16.0+ <https://www.docker.com/products/docker-desktop>`_

Python is available for Mac machines using package managers.

.. note:: If you know what the best way of installing Python 3 is, please let us know
          by updating this documentation on Github.

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
  ln -s ~/virtualenvs/riptide/bin/riptide ~/.local/bin
  ln -s ~/virtualenvs/riptide/bin/riptide_proxy ~/.local/bin
  ln -s ~/virtualenvs/riptide/bin/upgrade_riptide ~/.local/bin

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

Shell integration
.................

Riptide adds some additional features to your shell, in order to automatically add project
commands into your shell. Add the following lines to your .zshrc after any changes to PATH:

.. code-block:: zsh

  # Riptide shell integration
  . riptide.hook.zsh
  # Riptide code completion
  eval "$(_RIPTIDE_COMPLETE=source_zsh riptide)"

If you use Bash, add this to your .bashrc after any changes to PATH:

.. code-block:: bash

  # Riptide shell integration
  . riptide.hook.bash
  # Riptide code completion
  eval "$(_RIPTIDE_COMPLETE=source_bash riptide)"

SSL Certificate
...............

Finally you want to import the SSL certificate authority. This allows your browser to trust
the Riptide proxy server. See :ref:`user_docs/proxy:Import the SSL certificate authority` for more details.

Updating Riptide
~~~~~~~~~~~~~~~~

To update Riptide, run:

.. code-block:: bash

  riptide_upgrade

Configuring shared folders
~~~~~~~~~~~~~~~~~~~~~~~~~~
Docker Desktop for MacOS only allows the virtual machine running the Docker daemon
limited access to your machine.

The default configuration is not enough to use Riptide. Please open the settings
of Docker and navigate to the Shared Folders tab. Make sure the following entries
are present:

- /Users
- /Volumes
- /private
- /tmp
- /var/folders
- /usr/local/lib/python3.7 (**Or wherever else Python is installed!**)

Additional MacOS related notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Many additional settings or issues not described in this documentation may be
directly related to the Docker Desktop for MacOS implementation.

Please see the `documentation for Docker Desktop for Mac <https://docs.docker.com/docker-for-mac/>`_ for further information.

Known issues under MacOS
~~~~~~~~~~~~~~~~~~~~~~~~

- Riptide currently uses the default Docker Desktop Mac daemon. This setup is known
  to have significantly worse performance than the Linux version. Riptide has some
  `Performance optimizations`_ to increase performance.
- Due to the performance optimization settings, it might happen that changes to files
  are not immediately visible on the host system or the running containers. Some files
  are not updated on the host system at all (see `Performance optimizations`_).

.. note:: If you are a Mac developer and want to improve this situation, please contact us.
          A possible solution for the perfomance issues may be something like a
          `docker-sync <https://github.com/EugenMayer/docker-sync>`_ implementation
          for Riptide.

Next steps
~~~~~~~~~~
You are now ready to use Riptide. Head to the user documentation for more information on how to use it:

- :doc:`/user_docs/configuration`: Learn how to configure Riptide
- :doc:`/user_docs/shell`: Learn how to use and customize the shell integration
- :doc:`/user_docs/proxy`: Learn how to use the Proxy Server
- :doc:`/user_docs/working_with_riptide`: Learn how to use Riptide with existing Riptide projects
- :doc:`/user_docs/project` and :doc:`/config_docs`: Learn how to use Riptide for new projects
