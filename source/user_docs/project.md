# Project Setup

The first time you want to use a project, it has to be set up.

For this part of the guide, we will be using a demo project to guide
you through the setup process.

This demo project contains everything you
may encounter while setting up real projects, so we recommend you place this
demo project into an empty directory and follow this guide first before
setting up a real project.

Demo project (place in `riptide.yml` in empty directory):

```yaml
project:
  name: dummy
  src: .
  app:
    name: dummy
    import:
      dummy_directory:
        target: dummy-files
        name: Anything-this-is-just-a-demo
    notices:
      usage: This usage text shows you additional things you need to do when running this project.
    services:
      hello_world:
        image: strm/helloworld-http
        port: 80
        run_as_current_user: false
        roles:
          - main
      db:
        image: mysql:8.0
        roles:
          - db
        driver:
          name: mysql
          config:
            database: dummy
            password: mysql
        run_as_current_user: false
    commands:
      mysql:
        image: "{{ parent().get_service_by_role('db').image }}"
        command: "mysql -hdb -uroot -pmysql dummy"
```

## Running the first-time setup

First, make sure all repositories and Docker images are up to date:

```ansi-console
$ riptide update
[39m── [0m[39mUpdating Riptide repositories[0m[39m...[0m [39m────────────────────────────────────────────────────[0m
Updating [32m'git@github.com:theCapypara/riptide-repo'[0m[33m...[0m
Done!

[39m── [0m[39mUpdating images[0m[39m...[0m [39m──────────────────────────────────────────────────────────────────[0m
[service/db] Pulling 'mysql:8.0':
    Done!
[service/hello_world] Pulling 'strm/helloworld-http':
    Done!
[command/mysql] Pulling 'mysql:8.0':
    Done!
Done!
```

You should run this command regularly to make sure your images and repositories are always up to date.
See the [Docker documentation](https://docs.docker.com/get-started/#images-and-containers) for more details on images.
See {doc}`repos` for more information on repositories.

To run the first-time setup run:

```ansi-console
$ riptide setup
[36m╭─[0m[36m [0m[1;36m🌊 Welcome![0m[36m [0m[36m───────────────────────────────────────────────────────────────────────[0m[36m─╮[0m
[36m│[0m Thank you for using Riptide!                                                         [36m│[0m
[36m│[0m This command will guide you through the initial setup for 'dummy'.                   [36m│[0m
[36m│[0m Please follow the instructions carefully, it won't take long!                        [36m│[0m
[36m╰──────────────────────────────────────────────────────────────────────────────────────╯[0m
[35m> Do you wish to run this interactive setup?[0m [1;35m[y/n][0m [1;36m(y)[0m: 
```

After starting the setup, confirm with `y`.

:::{tip}
If you accidentally press `n` or make a mistake later during the setup, you can always restart it
by passing the `--force` option.
:::

After pressing `y` you will be asked what kind of setup you want to do:

```ansi-console
[35m> Are you working on a [0m[1;4;35mn[0m[35mew project that needs to be installed, or do you want to [0m[1;4;35mi[0m[35mmport [0m
[35mexisting data?[0m [1;35m[n/i][0m [1;36m(i)[0m: 
```

If you press `n` Riptide will exit and show you instructions for the first-time installation of the application
you are using. Follow these instructions.

If you press `i` you will be guided through the import of existing data. What can be imported depends on the project.
For this dummy project, a MySQL database can be imported, Riptide will tell you this after you pressed `i`:

```ansi-console
[39m== [0m[39m# Setting up an existing project[0m [39m====================================================[0m
[39m── [0m[39m## Importing a database[0m [39m─────────────────────────────────────────────────────────────[0m
[35m> Do you want to import a database (format mysql)?[0m [1;35m[y/n][0m: 
```

For this demo, open a text editor and put the following contents in a file called `demo.sql`:

```sql
CREATE TABLE Hello (
    World varchar(255)
);
```

Enter `y` to confirm that you want to import an SQL file:

```ansi-console
[35m> Enter the path to the SQL file: [0m
```

Enter the path to the SQL file that you just created:

```ansi-console
[35m> Enter the path to the SQL file: [0mdemo.sql
╭─ Starting services... ───────────────────────────────────────────────────────────────╮
│ db [32m⠹[0m [38;2;249;38;114m━━━━━━━━━━━━━━━━━[0m[38;5;237m╺[0m[38;5;237m━━━━━━━━━━━[0m [35m3/5[0m Starting Container...                        |
╰──────────────────────────────────────────────────────────────────────────────────────╯
```

You can see that the database is now starting, your SQL file will be imported shortly:

```ansi-console
╭─ Starting services... ───────────────────────────────────────────────────────────────╮
│ db   [38;2;114;156;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━[0m [35m5/5[0m Started!                                     │
╰──────────────────────────────────────────────────────────────────────────────────────╯
╭─ Importing database environment ─────────────────────────────────────────────────────╮
│ Database environment 'default' imported.                                             │
╰──────────────────────────────────────────────────────────────────────────────────────╯
```

After the database is imported, the project may ask you to import other directories,
such as directories containing media files or configuration specific to the application:

```ansi-console
[39m── [0m[39m## Importing files[0m [39m──────────────────────────────────────────────────────────────────[0m
[35m> Do you want to import the file or directory labeled 'Anything-this-is-just-a-demo' to [0m
[35m<project>/dummy-files?[0m [1;35m[y/n][0m: 
```

In our example it doesn't really matter. You may try this out by confirming with `y` and entering
a path to a directory. It will be copied into the dummy-files directory inside the current directory:

```ansi-console
[35m> Do you want to import the file or directory labeled 'Anything-this-is-just-a-demo' to [0m
[35m<project>/dummy-files?[0m [1;35m[y/n][0m: y
[35m> Enter path of files or directory to copy:[0m /tmp/test_dir
[0m╭─ Importing ──────────────────────────────────────────────────────────────────────────╮
│ Copying dummy_directory (dummy-files) from /tmp/test_dir... this may take a while... │
╰──────────────────────────────────────────────────────────────────────────────────────╯
[2K[1A[2K[1A[2K╭─ Importing ──────────────────────────────────────────────────────────────────────────╮
│ File successfully imported.                                                          │
╰──────────────────────────────────────────────────────────────────────────────────────╯

Done importing files.
[35m> Press ENTER to continue[0m[35m...[0m
```

After the import, or after you skipped it, Riptide will inform you that it is done:

```ansi-console
╭─ Project usage instructions ─────────────────────────────────────────────────────────╮
│ This usage text shows you additional things you need to do when running this         │
│ project.                                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────╯

╭─ [1m🌊 Done! Your project is set up![0m ───────────────────────────────────────────────────╮
│ After confirming you have done all the steps in the above-printed usage              │
│ documentation, you can now start the project with [1mriptide start[0m.                     │
│ If you need to read the usage instructions again later on, you can run [1mriptide [0m      │
│ [1mnotes[0m.                                                                               │
│                                                                                      │
│ Make sure to also have a look at the project's README file, if it has one.           │
│ If you want to use commands like [4mmysql[0m, leave and re-enter the project directory.    │
╰──────────────────────────────────────────────────────────────────────────────────────╯
```

Riptide will also show you the usage notes that are defined for the app your project is using. 
This usage note may contain additional steps you need to run after the setup.

If you need to view this again, run `riptide notes` after the setup.

## Next steps

The project is now set-up. If you are setting up a real project, there may need
to be some additional steps you have to do now, that you were told in the usage notes.
If you need to view these notes again run `riptide notes`. This will show you both
the general usage notes, that may contain things you need to do after importing an existing project,
and installation notes, for starting from scratch.

If you want to import databases or files later on, see {doc}`db`
and {doc}`import`.
