Introduction
------------

Riptide is a set of tools to manage development environments for web applications.
It's using container virtualization tools, such as `Docker <https://www.docker.com/>`_
to run all services needed for a project.

It's goal is to be easy to use by developers.
Riptide abstracts the virtualization in such a way that the environment behaves exactly
as if you were running it natively, without the need to install any other requirements
the project may have.

Riptide has to following major features:

* Environments can be defined in re-usable YAML files. The components of these files
  can be shared across multiple projects using Git repositories.

* Web services can be started without installing anything besides the engine (eg. Docker)
  and Riptide.

* Using Bash and Zsh integration CLI commands for projects can be defined an run in a shell
  just like ordinary commands.

* Riptide manages file and process permissions and tries to run everything as the
  same user that runs the Riptide command.

* Cross platform! Riptide works on Linux, Mac and Windows.

* Riptide is shipped with a simple proxy server that matches all your projects and services
  using DNS hostnames. It comes with out of the box SSL support and can also run behind
  another reverse proxy such as Nginx or Apache. The Proxy automatically starts
  and stops projects as you need them.

* You can work on multiple different projects at the same time, all requiring different
  versions of software and libraries without having to install anything.

Riptide is split into the following sub-projects:

* Riptide Library (``riptide-lib``): Main Python library that ties everything together.

* Riptide CLI (``riptide-cli``): CLI that you will interact with to manage your Riptide projects.

* Riptide Proxy (``riptide-proxy``): Proxy Server that proxies you the content of your web-services.

* Engines: The engine that actually starts and stops containers for services and commands.
  The following Engines are available:

  * ``riptide-engine-docker``: Docker Engine

* Database Drivers: Optional components that make managing databases in your development environment easier.
  See :doc:`/user_docs/db` for features.
  The following Database Drivers are available:

  * ``riptide-db-mysql``: Driver for MySQL based databases

Riptide Projects include the definition of an app. The app defines what services to run and what commands are available.
Services are parts of the application that are constantly running, such as the actual web-service or the database.
Commands are utility CLI commands that are helpful in working with your application such as `node` or `npm` for NodeJS projects.

This guide shows you how to set up Riptide and how to interact with services and commands.