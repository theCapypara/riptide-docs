# Sphinx Documentations

This section will guide you through the setup of a sphinx project using the Riptide repository.

Sphinx is a documentation generation tool. This documentation uses Sphinx, so we will use
this documentation as an example.

The project we set up uses [sphinx-autobuild](https://pypi.org/project/sphinx-autobuild/) as a file-watcher and HTTP server for the documentation.

This guide assumes you have Riptide fully set up, with shell integration enabled
and a running proxy server
(for this guide we assume `https://riptide.local` as base URL of your proxy server). It also
assumes you have the `repos` part of the configuration set to only the Riptide Community Repository
(the default).

**Sphinx and Python do NOT need to be installed for this guide.**

## Preparing the project

For this guide we will use this documentation as an example.

Clone `https://github.com/Parakoopa/riptide-docs.git` somewhere via Git, or download the
repository via Github.

Delete the `riptide.yml` file (we don't want Spoilers :) ).

## Creating a basic riptide.yml

Create a `riptide.yml` with the following contents:

```yaml
project:
  name: riptidedocs
  src: .
  app:
    $ref: /app/sphinx/latest
    services:
      sphinx:
        environment:
          REQUIREMENTS_FILE: "requirements_docs.txt"
          SPHINX_SOURCE: source
          SPHINX_BUILD: build
```

This file contains one [project] named `riptidedocs`. We specify with `src` that the source
code for this project is in the same directory that the `riptide.yml` is in.

This [project] contains an [app]. We load this app from the repository (`/app/sphinx/latest`, `Github <https://github.com/Parakoopa/riptide-repo/tree/master/app/sphinx>`)
This [app] has one [service] called `sphinx`. This [service] is the container specification for our Hello World
app.

The [service] `sphinx` is already specified in the app we loaded from the repository.

However we need to set some important environment variables.
`SPHINX_SOURCE` and `SPHINX_BUILD` contain the paths to the source and build directories. With `REQUIREMENTS_FILE`
an additional file can be specified that contains requirements that will be installed on start.
In our case, Riptide is installed before the documentation server starts.

## Running the project setup

Run `riptide setup --skip` to initiate the project. Since we have not added any setup instructions or
files to import (and `/app/sphinx/latest` also doesn't define any), we just skip the setup with the `--skip` flag.

## Starting the project

Since the project's dependencies (express) are now installed, you can open the front page
of the Proxy server (`https://riptide.local`). You will find a new project called `riptidedocs`.

Click on the link and the project will start. After the start you may get a Gateway Timeout. Wait a while
and refresh and you should see this documentation.

## Commands

`/app/sphinx/latest` also defines commands. You can list them with `riptide cmd`.

[app]: ../entities/apps
[project]: ../entities/projects
[service]: ../entities/services
