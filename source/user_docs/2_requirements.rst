Installing Requirements
-----------------------

This guide assumes you want to run Riptide in the most common set-up using the Docker Engine.
To use Riptide you need to have the following installed:

* Python 3.6+
* pip for Python 3 (might come installed with Python)
* `Docker 16.0+ <https://docs.docker.com/install/>`_ (Linux)
* `Docker Desktop 16.0+ <https://www.docker.com/products/docker-desktop>`_ (Mac, Windows)

Python is available for Linux and Mac machines using package managers.
For Windows it can be downloaded on the `Python website <https://www.python.org/downloads/>`_.

There is a good chance you already have Python installed. Try running ``python3 --version`` to check.

Additional requirements for Linux
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Under Linux you need to install the additional requirements for `python-prctl <https://github.com/seveas/python-prctl>`_::

  Before installing python-prctl, you need GCC, libc headers and libcap headers.
  On Debian/Ubuntu:

  $ sudo apt-get install build-essential libcap-dev

  On fedora:

  $ sudo yum install gcc glibc-devel libcap-devel
