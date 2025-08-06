# How Repositories work

As [explained in the User Documentation](../../user_docs/repos) repositories contain apps, services
and commands that can be used inside projects.

To use an entity from a repository, simply reference it in your project file via `$ref`:

```yaml
project:
  name: demo
  src: .
  app:
    $ref: /app/demo
    services:
      hello_world:
        command: 'this will override the comnmand for hello_world in app/demo.yml'
```

Riptide will look trough all cloned repositories that are defined in the system configuration under
`repos`. It will start with the first repository and search for a file named `app/demo.yml`.

If it finds this file it will merge the contents of your project file on top of `app/demo.yml`. It
will then do the same for all other repositories defined under `repos`, so you can configure
multiple repositories that override each other and build a hierarchy of repositories using this
technique.

You can view the merged result by calling `riptide config-dump`.

Entities defined in the repository can also reference other entities, even using relative paths.

Repositories are cloned and updated whenever `riptide update` is run.

## Complex example

This is a complex example using two repositories and multiple references. By looking at this
example it should become clear, how repositories work.

This is the base project file for our example:

```yaml
project:
  name: demo
  src: .
  app:
    $ref: /app/demo
    services:
      hello_world:
        command: 'this will override the comnmand for hello_world in app/demo.yml'
      additional_service:
        $ref: /service/demo
        image: 'this will override the image in service/demo.yml'
```

And this is the content of our system configuration's `repos` setting:

```yaml
repos:
  - https://repos.example/repo1.git
  - https://repos.example/repo2.git
```

`repo1.git` contains the following files:

```yaml
# <repo1.git>/app/demo
app:
  services:
    hello_world:
      image: alpine
      command: 'echo hello world'
```

```yaml
# <repo1.git>/service/demo
service:
  image: ubuntu
  command: demo
```

`repo2.git` contains the following files:

```yaml
# <repo2.git>/app/demo
app:
  services:
    hello_world:
      image: debian
```

The end result is the following project file:

```yaml
project:
  name: demo
  src: .
  app:
    services:
      hello_world:
        image: debian
        command: 'this will override the comnmand for hello_world in app/demo.yml'
      additional_service:
        image: 'this will override the image in service/demo.yml'
        command: demo
```

## Removing values

During the merging process it is possible to remove values entirely using the special keyword `$renove`.

Example (remove a service from a loaded app):

```yaml
project:
  name: demo
  src: .
  app:
    $ref: /app/demo
    services:
      hello_world: $remove
```

## Details about how documents are processed

More information about the properties of Riptide's configuration language, can be found in the
section [Overview / Hierarchy](../entities.md).

The configuration language is based on the Python library Configcrunch.

If you want additional information about the behaviour of Configcrunch, please have a look
at the [Configcrunch documentation](https://configcrunch.readthedocs.io/).
