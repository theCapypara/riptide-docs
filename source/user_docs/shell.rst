Shell Integration
-----------------

Riptide has integrations for the popular Bash and Zsh shells.
We highly recommend installing these!

CLI Command Aliases
~~~~~~~~~~~~~~~~~~~
Riptide projects may define custom commands for you to use.
Take for example a command called ``mysql``. To run it *without* the integration you have to execute::

  $ riptide cmd mysql -e "DESCRIBE Hello;"

If the shell integration is enabled, you can just run the command like you would any
other shell command::

  $ mysql -e "DESCRIBE Hello;"

We highly recommend using the shell integration. 
The ``riptide cmd`` command does not support passing all arguments and options.

Install the integration
^^^^^^^^^^^^^^^^^^^^^^^

.. note::
   If you used the Linux installation script this is already done for you.

   If you are on :doc:`/installation/linux_nixos` or use :doc:`/installation/macos_nix_darwin`, see their setup pages for more information instead.

If you are using **Bash**, add the following line to your ``.bashrc``::

  . riptide.hook.bash

If you are using **Zsh**, add the following line to your ``.zshrc``::

  . riptide.hook.zsh

You need to re-open your terminals for the integration to be enabled (or source your bashrc/zshrc).

.. warning:: When using Riptide inside a virtualenv, you need to replace ``riptide.hook.bash`` with
             the full path to ``riptide.hook.bash``. You can get that by calling ``which riptide.hook.bash``.
             The same applies for the zsh integration.

.. warning:: Whenever you set up a project for the first time,
             you need to exit and re-enter the project directory to use the commands.

Autocomplete
~~~~~~~~~~~~

Riptide has limited experimental autocomplete support.

To enable it for **Bash**, add the following line to your ``.bashrc``::

  eval "$(_RIPTIDE_COMPLETE=source_bash riptide)"

To enable it for **Zsh**, add the following line to your ``.zshrc``::

  eval "$(_RIPTIDE_COMPLETE=source_zsh riptide)"

Replace ``<full_path_to_riptide>`` with the full path to the ``riptide`` command.
On Mac and Linux you can get this path by executing ``which riptide``.

You need to re-open your terminals or source the rc-file inside them
for the integration to be enabled.

.. warning:: When using Riptide inside a virtualenv, you need to replace ``riptide`` with
             the full path to ``riptide``. You can get that by calling ``which riptide``.