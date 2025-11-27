# Hooks
Hooks allow you to run Riptide commands when certain events occur. These events can be internal
Riptide events, such as before a project starts or before a database is imported. They can also
be Git events. This way you can use Riptide to manage your git hooks, which allows you to run
Riptide commands before committing to run linters, for example. It's also possible to define
custom events and trigger them via the CLI.

Hooks are defined using Riptide {doc}`/config_docs/entities/commands`s and are as such run in a
sandboxed environment, not on the host system. It is possible to react to events on the host system
using [plugins](#plugins).

:::{warning}
The order in which hooks are executed is arbitrary, do not rely on one hook being executed before
another.
:::

## Controlling when hooks are run
Hooks are desgined to be safe: They are not run automatically, until you activate
them and you can control which events are allowed to run hooks individually.

When you run a Riptide (or git) command that triggers a hook for the first time, 
you will be greeted with this message until you did the configuration:

```ansi-console
[33m╭─[0m[33m Riptide Warning [0m[33m───────────────────────────────────────────────────────────[0m[33m─╮[0m
[33m│[0m Riptide has hooks defined for this action. They are not run by default for   [33m│[0m
[33m│[0m security reasons.                                                            [33m│[0m
[33m│[0m To disable this warning, please configure your choice for hooks globally:    [33m│[0m
[33m│[0m     riptide hook-configure -g --enable=true/false                            [33m│[0m
[33m│[0m                                                                              [33m│[0m
[33m│[0m You can also configure your choice specifically for this project:            [33m│[0m
[33m│[0m     riptide hook-configure --enable=true/false                               [33m│[0m
[33m│[0m Additionally you can configure what should happen for this event             [33m│[0m
[33m│[0m specifically:                                                                [33m│[0m
[33m│[0m     riptide hook-configure [-g] --enable=true/false git-post-checkout        [33m│[0m
[33m│[0m                                                                              [33m│[0m
[33m│[0m Please see the Riptide documentation for more information.                   [33m│[0m
[33m╰──────────────────────────────────────────────────────────────────────────────╯[0m
```

As explained in this error message, you need to explicitly allow hooks to be run. Or alternatively
disallow them, which will disable this message but not run any hooks.

Using the `riptide hook-configure` command, you have various fine-grained options to control hooks:

- If you don't specify an extra argument, you will set the default setting for all events, otherwise
  you will override it for a specific event.
- If you use the `-g` flag, this setting is saved globally for all projects. Unless a project
  overrides it, it will take effect. If you don't specify `-g` you are setting an override for the
  current project.
- Using `--enable` you can either enable or disable the event, using `--wait-time` you can configure
  the timeout (see next section).

You can use the `riptide hook-configuration` command to view the configuration for the current
project.

**Examples:**

- Enable hooks globally:
  : `riptide hook-configure -g --enable=true`
- Disable hooks for the current project (overrides global setting):
  : `riptide hook-configure --enable=false`
- Enable git-pre-commit hooks globally (overrides global and default project setting):
  : `riptide hook-configure -g --enable=false git-pre-commit`
- Disable git-pre-commit hooks for the current project (overrides any other setting):
  : `riptide hook-configure --enable=false git-pre-commit`

### Timeouts
Normally Riptide will run hooks immediately whenver triggered (asuming you have enabled them).

You can use the `--wait-time` parameter for `riptide hook-configure` to delay the execution
of a hook. It will then only trigger after the configured amount of seconds.

Within this time you can hit `CTRL+C` to cancel the execution of hooks for that event.
This allows you to **make hooks optional**. Let's say you have a project with `git-pre-commit`
hooks configured but don't want to have these running every time you commit, because they take
a long time. By setting the timeout to a few seconds, you have the option to skip running these
hooks.

```ansi-console
$ riptide hook-configure --wait-time=2 custom-with-wait-time
Event custom-with-wait-time configured:
├── enabled: [32myes[0m (from default)
└── wait time: 2s
$ riptide hook-trigger custom-with-wait-time
[36mRiptide[0m: Will run hooks in [1;36m2[0m seconds. Hit [1mCTRL-C[0m to skip running hooks.
```

## Examples
It's easiest to understand hooks using examples. The following examples will show you how to
configure a hook for their usecase and how it is triggered. We asume you have already allowed
hooks to be run.

### Running a linter before commiting
Using hooks, you can configure a linter to run before committing. Let's say you want to run
`phpstan` and `pint` before comitting. You could have the following project:

```{code-block} yaml
:emphasize-lines: 27-40

project:
  name: example
  src: .
  app:
    name: example
    services:
      www:
        $ref: /service/nginx/latest
        roles:
          - src
      php:
        $ref: /service/php/8.4/fpm
        roles:
          - src
          - php
          - mail
    commands:
      composer:
        $ref: command/composer/v2-with-host-links
        image: riptidepy/php:8.4-cli-composer2
      pint:
        $ref: /command/php/from-service
        command: /src/vendor/bin/pint
      phpstan:
        $ref: /command/php/from-service
        command: /src/vendor/bin/phpstan
    hooks:
      lint-pint:
        events:
          - git-pre-commit
        pass_event_arguments: false
        command:
          from_app: pint
      lint-phpstan:
        events:
          - git-pre-commit
        pass_event_arguments: false
        command:
          from_app: phpstan
          args: analyze src
```

When you commit, this will trigger Riptide to run `pint` and `phpstan`:

```ansi-console
$ git commit -m "testing"
[36m── [0m[39mRiptide: Running [0m[33mgit-pre-commit[0m[39m Hook: [0m[36mlint-phpstan[0m[39m...[0m [36m───────────────────────[0m
 [2K 1/1 [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓] 100%


 [OK] No errors                                                                 

💡 Tip of the Day:
PHPStan is performing only the most basic checks.
You can pass a higher rule level through the --0 option
(the default and current level is 0) to analyse code more thoroughly.

[36m── [0m[39mHook [0m[36mlint-phpstan[0m[39m finished.[0m [36m─────────────────────────────────────────────────[0m
[36m── [0m[39mRiptide: Running [0m[33mgit-pre-commit[0m[39m Hook: [0m[36mlint-pint[0m[39m...[0m [36m──────────────────────────[0m

  [90m.[39m

  [90m────────────────────────────────────────────────────────────────────[39m [90mLaravel[39m  
  [90;42;1m  PASS  [39;49;22m [90m............................................................[39m 1 file  

[36m── [0m[39mHook [0m[36mlint-pint[0m[39m finished.[0m [36m────────────────────────────────────────────────────[0m
[test3 e9452e5] testing
 1 file changed, 39 insertions(+), 17 deletions(-)
```

### Running a setup command before starting
Using the above example, if you add `pre-start` event triggers, the commands
will also run every time Riptide starts the project from the CLI:

```{code-block} yaml
:emphasize-lines: 6,13

...
    hooks:
      lint-pint:
        events:
          - git-pre-commit
          - pre-start
        pass_event_arguments: false
        command:
          from_app: pint
      lint-phpstan:
        events:
          - git-pre-commit
          - pre-start
        pass_event_arguments: false
        command:
          from_app: phpstan
          args: analyze src
```

```ansi-console
$ riptide start
[36m── [0m[39mRunning [0m[33mpre-start[0m[39m Hook: [0m[36mlint-phpstan[0m[39m...[0m [36m───────────────────────────[0m
 [2K 1/1 [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓] 100%


[30;42m                                                                      [39;49m
[30;42m [OK] No errors                                                       [39;49m
[30;42m                                                                      [39;49m

💡 Tip of the Day:
PHPStan is performing only the most basic checks.
You can pass a higher rule level through the [36m--0[39m option
(the default and current level is 0) to analyse code more thoroughly.

[36m── [0m[39mHook [0m[36mlint-phpstan[0m[39m finished.[0m [36m───────────────────────────────────────[0m
[36m── [0m[39mRunning [0m[33mpre-start[0m[39m Hook: [0m[36mlint-pint[0m[39m...[0m [36m──────────────────────────────[0m

  [90m.[39m

  [90m──────────────────────────────────────────────────────────[39m [90mLaravel[39m  
  [90;42;1m  PASS  [39;49;22m [90m..................................................[39m 1 file  

[36m── [0m[39mHook [0m[36mlint-pint[0m[39m finished.[0m [36m──────────────────────────────────────────[0m
[2K[1A[2K[1A[2K[1A[2K╭─ Starting services... ─────────────────────────────────────────────╮
│ php   [38;2;114;156;32m━━━━━━━━━━━━━━━━━━━[0m [35m2/2[0m Already started!                     │
│ www   [38;2;114;156;32m━━━━━━━━━━━━━━━━━━━[0m [35m2/2[0m Already started!                     │
╰────────────────────────────────────────────────────────────────────╯
╭─ Status ───────────────────────────────────────────────────────────╮
│ Services                                                           │
│ ├── [32m▶ php[0m                                                          │
│ └── [32m▶ www[0m                                                          │
│     └── 🌐 Web: [4mhttps://example--www.riptide.kirschbaum.fritz.box[0m  │
╰────────────────────────────────────────────────────────────────────╯

```

### Running a custom command from a Makefile
If we use the example above and add a `custom-linting` event to the two hooks, you can integrate triggering these
hooks into your `Makefile` or other scripting:

```make
.PHONY:

lint::
	riptide hook-trigger custom-linting
```

```ansi-console
$ make lint
riptide hook-trigger custom-linting
[36m── [0m[39mRiptide: Running [0m[33mcustom-linting[0m[39m Hook: [0m[36mlint-phpstan[0m[39m...[0m [36m───────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m
 [2K 1/1 [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓] 100%


[30;42m                                                                                                                        [39;49m
[30;42m [OK] No errors                                                                                                         [39;49m
[30;42m                                                                                                                        [39;49m

💡 Tip of the Day:
PHPStan is performing only the most basic checks.
You can pass a higher rule level through the [36m--0[39m option
(the default and current level is 0) to analyse code more thoroughly.

[36m── [0m[39mHook [0m[36mlint-phpstan[0m[39m finished.[0m [36m─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m
[36m── [0m[39mRiptide: Running [0m[33mcustom-linting[0m[39m Hook: [0m[36mlint-pint[0m[39m...[0m [36m──────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m

  [90m.[39m

  [90m────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[39m [90mLaravel[39m  
  [90;42;1m  PASS  [39;49;22m [90m....................................................................................................................................................[39m 1 file  

[36m── [0m[39mHook [0m[36mlint-pint[0m[39m finished.[0m [36m────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m
```

If no hooks are defined for `custom-linting` nothing would happen. This also allows you to define standardized custom
events across your projects.

### Running a command after stopping any project
You can also define hooks globally in your user configuration.

When you run `riptide config-edit-user` you can insert the following hook, to run every time you stop a project:

```{code-block} yaml
:emphasize-lines: 10-16

riptide:
  engine: docker
  performance:
    ...
  proxy:
    ...
  repos:
    ...
  hooks:
    my-stop-hook:
      events:
        - post-stop
      command:
        run:
          image: ubuntu
          command: "echo Hi! The project stopped! Services: "
```

```ansi-console
$ riptide stop
[2K[1A[2K[1A[2K[1A[2K╭─ Stopping services... ────────────────────────────────────────────────────────╮
│ php   [38;2;114;156;32m━━━━━━━━━━━━━━━━━━━━━━━━━[0m [35m2/2[0m Already stopped!                          │
│ www   [38;2;114;156;32m━━━━━━━━━━━━━━━━━━━━━━━━━[0m [35m2/2[0m Already stopped!                          │
╰───────────────────────────────────────────────────────────────────────────────╯
[36m── [0m[39mRunning [0m[33mpost-stop[0m[39m Hook: [0m[36mmy-stop-hook [0m[1;36m([0m[36mfrom global[0m[1;36m)[0m[39m...[0m [36m────────────────────────[0m
Hi! The project stopped! Services: php,www
[36m── [0m[39mHook [0m[36mmy-stop-hook [0m[1;36m([0m[36mfrom global[0m[1;36m)[0m[39m finished.[0m [36m────────────────────────────────────[0m
╭─ Status ──────────────────────────────────────────────────────────────────────╮
│ Services                                                                      │
│ ├── [31m⏹ php[0m                                                                     │
│ └── [31m⏹ www[0m                                                                     │
╰───────────────────────────────────────────────────────────────────────────────╯

```

## List of events
For a list of events see: [List of events](project:#list-of-hook-events)

## Hook concepts
Hooks can either be defined for an {doc}`/config_docs/entities/apps` or
globally for all projects in the {doc}`/config_docs/entities/config`.

### Configuration
Hooks have some options to configure their behaviour:

- `continue_on_error`: Usually when hooks fail, this causes the Riptide command that triggered them
  also to immediately exit with the failing exit code. In most cases this causes whatever process
  triggered them to stop. Setting this option to `true`, you can continue a process, even if the
  hook fails.
- `pass_event_arguments`: Some event usually pass arguments to the hook, such as most git hooks,
  or the `pre-db-import`, which passes the import file path. By setting this flag to `false` you
  can prevent these arguments to be passed to the hook. 

A detailed list of all configuration options can be found on the 
{doc}`/config_docs/entities/hooks` page.

### Using a command from the app
A hook command can be defined by referencing a command from the app. This allows you to reuse
a command, without having to redefine it. This is useful if you want to run commands you are
already using for development, such as your package manager. Take the following project example:

```{code-block} yaml
:emphasize-lines: 7-8

project:
  name: my-great-js-project
  src: src
  app:
    name: my-great-js-app
    commands:
      npm:
        $ref: /command/npm/node24
```

This app has a `npm` command defined. You can reuse this command for the hook:

```{code-block} yaml
:emphasize-lines: 9-16

project:
  name: my-great-js-project
  src: .
  app:
    name: my-great-js-app
    commands:
      npm:
        $ref: /command/npm/node24
    hooks:
      npm-install:
        events:
          - git-post-checkout
        pass_event_arguments: false
        command:
          from_app: npm
          args: install
```

This will run `npm install` whenever checking out a new commit.

### Using a custom command
You can also define custom commands. These can be defined like any other Riptide 
{doc}`/config_docs/entities/commands`s.

Let's use the example above and say you don't have `npm` already defined as a command in the app,
you can then achieve the same goal using this:

```{code-block} yaml
:emphasize-lines: 12-16

project:
  name: my-great-js-project
  src: .
  app:
    name: my-great-js-app
    hooks:
      npm-install:
        events:
          - git-post-checkout
        pass_event_arguments: false
        command:
          run:
            $ref: /command/npm/node24
            command: npm install
```

## Custom events
As shown in the "Running a custom command from a Makefile" example above, you can easily configure
and trigger custom events. The event keys must start with `custom-` and you can trigger these events
using the CLI command `riptide hook-trigger`.

You can also pass arguments to `riptide hook-trigger`, these will be passed to the hooks that are
executed, unless `pass_event_arguments` is `false` for a hook.

## Plugins
Riptide [plugins](project:#riptide-plugins) can also trigger on events. They are always run, even
if hooks are otherwise disabled.

For a plugin to be able to react to an event, it must advertise that it can by returning `true`
from `responds_to_event` for a given event. When it does this, it's `event_triggered` method is
then later called when the event is triggered. The arguments are the same that would be passed
to a configured hook. 

It must return an exit code. If it returns `0`, this means no error is occured, on a non-zero exit
code Riptide will exit immediately with that exit code.

Example plugin:

```py
from typing import Any, Sequence

from riptide.config.document.config import Config
from riptide.engine.abstract import AbstractEngine
from riptide.hook.event import AnyHookEvent, HookEvent
from riptide.plugin.abstract import AbstractPluginhhh


class ExamplePlugin(AbstractPlugin):
    def after_load_engine(self, engine: AbstractEngine):
        pass

    def after_load_cli(self, main_cli_object):
        pass

    def after_reload_config(self, config: Config):
        pass

    def get_flag_value(self, config: Config, flag_name: str) -> Any:
        pass

    def responds_to_event(self, event: AnyHookEvent) -> bool:
        return event == HookEvent.PreStart or event == "custom-example"

    def event_triggered(self, config: Config, event: AnyHookEvent, arguments: Sequence[str]) -> int:
        print("Running my great example plugin event trigger!")
        if event == "custom-example":
            print("arguments: ", arguments)
        if event == HookEvent.PreStart:
            # Fail
            return 1
        return 0
```

Example run:

```ansi-console
$ riptide start
Running my great example plugin event trigger!
[31m╭─[0m[31m Error [0m[31m───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m[31m─╮[0m
[31m│[0m A hook failed                                                                                                                                                                          [31m│[0m
[31m╰─[0m[31m Use -v to show stack traces [0m[31m─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────[0m[31m─╯[0m
$ echo $?
1
$ riptide hook-trigger custom-example 12345
Running my great example plugin event trigger!
arguments:  ['12345']
$ echo $?
0
```

As plugins run on the host system, they can do everything that Riptide itself could do.
