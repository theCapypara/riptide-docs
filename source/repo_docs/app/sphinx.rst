.. AUTO-GENERATED, SEE README_CONTRIBUTORS. DO NOT EDIT.

Sphinx
======

Sphinx_ is a tool that makes it easy to create intelligent and beautiful documentation,
written by Georg Brandl and licensed under the BSD license.

.. _Sphinx: http://www.sphinx-doc.org/en/master/
.. _sphinx-autobuild: https://pypi.org/project/sphinx-autobuild/

**Link to entity in repository:** `<https://github.com/theCapypara/riptide-repo/tree/master/app/sphinx>`_


``/app/sphinx/latest``
----------------------

Latest version of Sphinx and sphinx-autobuild_.

sphinx-autobuild is a file watcher and HTTP server for Sphinx.

Change the ``SPHINX_SOURCE`` and ``SPHINX_BULD`` of the ``sphinx`` service.

Please note that, after you started this project, it takes a while to actually
finish starting. In the meantime you will get a Gateway Timeout.

Services
~~~~~~~~

sphinx
++++++

**Accessible via Proxy?**: yes

**Runs as the user using Riptide?**: yes

sphinx-autobuild server.

Uses the `riptidepy/sphinx <https://hub.docker.com/r/riptidepy/sphinx>`_ image, based on Python 3.7.

Environment variables
.....................

+--------------------+-----------+-------------------------+------------------+------------------------------------------------------------------------------+
| Key                | Required? | Already set?            | Example Value(s) | Description                                                                  |
+====================+===========+=========================+==================+==============================================================================+
| SPHINX_SOURCE      | yes       | yes (default: "source") | source           | Directory that contains the conf.py                                          |
+--------------------+-----------+-------------------------+------------------+------------------------------------------------------------------------------+
| SPHINX_BUILD       | yes       | yes (default: "build")  | build            | Build output directory                                                       |
+--------------------+-----------+-------------------------+------------------+------------------------------------------------------------------------------+
| REQUIREMENTS_FILE  | no        | no                      | requirements.txt | This file is read on startup and the dependencies in it are installed first. |
+--------------------+-----------+-------------------------+------------------+------------------------------------------------------------------------------+

Additional volumes
..................

+-----------------------+-----------------------------+---------------------------------------------+-------------------------------------+---------------------------------------------------+
| Name                  | Source                      | Source path                                 | Target path                         | Description                                       |
+=======================+=============================+=============================================+=====================================+===================================================+
| py_packages           | Data folder                 | _riptide/data/___/site_packages             | ~/.local/lib/python3.7/site-packages| Installed Python packages (see REQUIREMENTS_FILE) |
+-----------------------+-----------------------------+---------------------------------------------+-------------------------------------+---------------------------------------------------+

Commands
~~~~~~~~

make, sphinx-build, sphinx-autogen, sphinx-apidoc
+++++++++++++++++++++++++++++++++++++++++++++++++

make, sphinx-build, sphinx-autogen and sphinx-apidoc commands.

Use image of ``sphinx`` service.

Additional volumes
..................

See ``sphinx`` service.

sphinx-doctest
++++++++++++++

Runs the sphinx doctest command::

  python -msphinx -b doctest {{ parent().services.sphinx.get_working_directory() }}/{{ parent().services.sphinx.environment.SPHINX_SOURCE }}

Uses image of ``sphinx`` service.

Additional volumes
..................

See ``sphinx`` service.
