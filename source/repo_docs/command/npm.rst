.. AUTO-GENERATED, SEE README_CONTRIBUTORS. DO NOT EDIT.

NPM
===

NPM_ Node.js package manager.

This command template can also be used for other Node.js commands (by changing the command), if they
require access to the npm cache.

.. _npm: https://www.npmjs.com/

**Link to entity in repository:** `<https://github.com/Parakoopa/riptide-repo/tree/master/command/npm>`_

..  contents:: Index
    :depth: 2

``/command/npm/base``
----------------------

Latest NPM version with the latest Node.js version.

Additional volumes
~~~~~~~~~~~~~~~~~~

+-----------------------+-----------------------------+---------------------------------------------+-------------+--------------------+
| Name                  | Source                      | Source path                                 | Target path | Description        |
+=======================+=============================+=============================================+=============+====================+
| npm                   | Home directory              | ~/.npm                                      | ~/.npm      | NPM cache          |
+-----------------------+-----------------------------+---------------------------------------------+-------------+--------------------+
| npmrc                 | Home directory              | ~/.npmrc                                    | ~/.npmrc    | NPM config         |
+-----------------------+-----------------------------+---------------------------------------------+-------------+--------------------+
| ssh                   | Home directory              | ~/.ssh                                      | ~/.ssh      | SSH configuration  |
+-----------------------+-----------------------------+---------------------------------------------+-------------+--------------------+

``/command/npm/nodeX``
----------------------

**Based on**: /command/npm/base

Latest NPM with different Node.js versions. Avaiable Node.js versions:

- 8
- 10
- 11
- 12