Shell Integration
-----------------

Riptide has integrations for the pouplar Bash and Zsh shells.
We highly recommend installing these!

CLI Command Aliases
~~~~~~~~~~~~~~~~~~~
Riptide projects may define custom commands for you to use.
The demo project from the `previous chapter <4_project>`_ for example
defines a ``mysql`` command. To run it *without* the integration you have to execute::

  $ riptide cmd mysql -e "DESCRIBE Hello;"
  mysql: [Warning] Using a password on the command line interface can be insecure.
  +-------+--------------+------+-----+---------+-------+
  | Field | Type         | Null | Key | Default | Extra |
  +-------+--------------+------+-----+---------+-------+
  | World | varchar(255) | YES  |     | NULL    |       |
  +-------+--------------+------+-----+---------+-------+

If the shell integration is enabled, you can just run the command like you would any
other shell command::

  $ mysql -e "DESCRIBE Hello;"
  mysql: [Warning] Using a password on the command line interface can be insecure.
  +-------+--------------+------+-----+---------+-------+
  | Field | Type         | Null | Key | Default | Extra |
  +-------+--------------+------+-----+---------+-------+
  | World | varchar(255) | YES  |     | NULL    |       |
  +-------+--------------+------+-----+---------+-------+

Install the integration
^^^^^^^^^^^^^^^^^^^^^^^

If you are using **Bash**, add the following line to your ``.bashrc``::

  . <installation_dir>/cli/shell/riptide.hook.bash

If you are using **Zsh**, add the following line to your ``.zshrc``::

  . <installation_dir>/cli/shell/riptide.hook.zsh

``<installation_dir>`` is the folder you placed all the Riptide components in,
if you followed this guide this should be ``~/riptide``.

You need to re-open your terminals or source the rc-file inside them
for the integration to be enabled.

.. note:: If you want to try these commands out yourself using the demo project,
          you may need to start the database first: ``riptide start -s db``.

.. warning:: Whenever you set up a project for the first time,
             you need to exit and re-enter the project directory to use the commands.

Autocomplete
~~~~~~~~~~~~

Riptide has limited experimental autocomplete support.

To enable it for **Bash**, add the following line to your ``.bashrc``::

  eval "$(_RIPTIDE_COMPLETE=source_bash <full_path_to_riptide>)"

To enable it for **Zsh**, add the following line to your ``.zshrc``::

  eval "$(_RIPTIDE_COMPLETE=source_zsh <full_path_to_riptide>)"

Replace ``<full_path_to_riptide>`` with the full path to the ``riptide`` command.
On Mac and Linux you can get this path by executing ``which riptide``.

You need to re-open your terminals or source the rc-file inside them
for the integration to be enabled.
