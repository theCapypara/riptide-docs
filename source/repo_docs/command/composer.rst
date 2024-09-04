.. AUTO-GENERATED, SEE README_CONTRIBUTORS. DO NOT EDIT.

Composer
========

Composer_ PHP package manager.

.. _Composer: https://getcomposer.org/

**Link to entity in repository:** `<https://github.com/theCapypara/riptide-repo/tree/master/command/composer>`_


``/command/composer/base``
--------------------------

Latest version of Composer 1. No links to host system (see ``with-host-links``).


Environment variables
~~~~~~~~~~~~~~~~~~~~~

+----------------+-----------+---------------------------------------------------+-------------------------+-------------------------------------------------------+
| Key            | Required? | Already set?                                      | Example Value(s)        | Description                                           |
+================+===========+===================================================+=========================+=======================================================+
| COMPOSER_HOME  | no        | yes (default: "{{ home_path() }}/.composer")      | /home/riptide/.composer | Directory that composer config and cache is stored in |
+----------------+-----------+---------------------------------------------------+-------------------------+-------------------------------------------------------+

Additional volumes
~~~~~~~~~~~~~~~~~~

+-----------------------+-----------------------------+---------------------------------------------+-------------+--------------------------------+
| Name                  | Source                      | Source path                                 | Target path | Description                    |
+=======================+=============================+=============================================+=============+================================+
| tmp                   | Other                       | /tmp ({{ get_tempdir() }})                  | /tmp        | Temporary directory            |
+-----------------------+-----------------------------+---------------------------------------------+-------------+--------------------------------+

``/command/composer/with-host-links``
-------------------------------------

**Based on**: /command/composer/base

Composer 1 with volumes for the user's ``.composer`` and ``.ssh`` directories.

Additional volumes
~~~~~~~~~~~~~~~~~~

+-----------------------+-----------------------------+---------------------------------------------+-------------+----------------------+
| Name                  | Source                      | Source path                                 | Target path | Description          |
+=======================+=============================+=============================================+=============+======================+
| composer              | Home directory              | ~/.composer                                 | ~/.composer | .composer            |
+-----------------------+-----------------------------+---------------------------------------------+-------------+----------------------+
| ssh                   | Home directory              | ~/.ssh                                      | ~/.ssh      | SSH configuration    |
+-----------------------+-----------------------------+---------------------------------------------+-------------+----------------------+

``/command/composer/v2``
------------------------

Latest version of Composer 2. No links to host system (see ``v2-with-host-links``).


Environment variables
~~~~~~~~~~~~~~~~~~~~~

+--------------------+-----------+-----------------------------------------------------+--------------------------------+---------------------------------------------+
| Key                | Required? | Already set?                                        | Example Value(s)               | Description                                 |
+====================+===========+=====================================================+================================+=============================================+
| COMPOSER_HOME      | no        | yes (default: "{{ home_path() }}/.config/composer") | /home/riptide/.config/composer | Directory that composer config is stored in |
| COMPOSER_CACHE_DIR | no        | yes (default: "{{ home_path() }}/.cache/composer")  | /home/riptide/.cache/composer  | Directory that composer cache is stored in  |
+--------------------+-----------+-----------------------------------------------------+--------------------------------+---------------------------------------------+

Additional volumes
~~~~~~~~~~~~~~~~~~

+-----------------------+-----------------------------+---------------------------------------------+-------------+--------------------------------+
| Name                  | Source                      | Source path                                 | Target path | Description                    |
+=======================+=============================+=============================================+=============+================================+
| tmp                   | Other                       | /tmp ({{ get_tempdir() }})                  | /tmp        | Temporary directory            |
+-----------------------+-----------------------------+---------------------------------------------+-------------+--------------------------------+

``/command/composer/v2-with-host-links``
----------------------------------------

**Based on**: /command/composer/v2

Composer 2 with volumes for the user's ``composer`` and ``.ssh`` directories.

Additional volumes
~~~~~~~~~~~~~~~~~~

+----------------+----------------+--------------------+--------------------+----------------------+
| Name           | Source         | Source path        | Target path        | Description          |
+================+================+====================+====================+======================+
| composer       | Home directory | ~/.config/composer | ~/.config/composer | .composer config     |
+----------------+----------------+--------------------+--------------------+----------------------+
| composer_cache | Home directory | ~/.cache/composer  | ~/.cache/composer  | .composer cache      |
+----------------+----------------+--------------------+--------------------+----------------------+
| ssh            | Home directory | ~/.ssh             | ~/.ssh             | SSH configuration    |
+----------------+----------------+--------------------+--------------------+----------------------+
