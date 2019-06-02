.. title:: Riptide

|Riptide|
=========

.. |Riptide| image:: logo.png
    :alt: Riptide

Riptide is a set of tools to manage development environments for web applications.
It's using container virtualization tools, such as `Docker <https://www.docker.com/>`_
to run all services needed for a project.

It's goal is to be easy to use by developers.
Riptide abstracts the virtualization in such a way that the environment behaves exactly
as if you were running it natively, without the need to install any other requirements
the project may have.

Hello World!
------------

A simple hello world web service:

.. code-block:: yaml

    # riptide.yml
    project:
      name: hello-world
      src: .
      app:
        name: hello-world
        services:
          hello_world:
            image: strm/helloworld-http
            port: 80
            run_as_current_user: false
            roles:
              - main


To setup the project run:

.. code-block:: sh

    # Setup project
    riptide setup
    # Start Riptide Proxy
    riptide_proxy

After the setup head over to ``http://hello-world.riptide.local`` (assuming you are
using the default configuration and DNS is set up). The Service will auto-start
and after that you will be greeted with the message: ``Hello from hello_world``.


Riptide config files
--------------------
If you need to edit the Riptide configuration files, here are the paths on where to find them:

* Linux: ``~/.config/riptide``
* Windows: ``C:\Users\USERNAME\AppData\Local\riptide``
* Mac: ``/Users/USERNAME/Library/Application Support/riptide``

Documentation
-------------

.. toctree::
   :maxdepth: 2

   user_docs
   config_docs
   repo_docs
   module_docs
   update_docs

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
