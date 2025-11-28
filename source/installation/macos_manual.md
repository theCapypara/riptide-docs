# Manual MacOS Setup

This guide will explain how to install Riptide under MacOS. If possible you may want to consider using the
{doc}`nix-darwin setup <macos_nix_darwin>` instead. It is more convenient and comes with
more features out of the box (such as proxy autostart, which is otherwise not supported for macOS).

## Installing Requirements

This guide assumes you want to run Riptide in the most common set-up using the Docker Engine.
To use Riptide you need to have the following installed:

- Python 3.11+
- pip for Python 3 (might come installed with Python)
- [Docker Desktop](https://www.docker.com/products/docker-desktop) or [OrbStack](https://orbstack.dev/)

Python is available for Mac machines using package managers.

There is a good chance you already have Python installed. Try running `python3 --version` to check.

(install-macos)=
### Installing Riptide

Riptide should always be installed in a dedicated Python virtual environment to avoid conflicts between system packages and Riptide.

Choose a directory you want to store the virtualenv at, create a new virtualenv for Riptide and activate it:

```bash
cd ~/virtualenvs  # This can be whereever you want
python3 -m venv riptide
source riptide/bin/activate # Activates the virtualenv
```

Then, to install all Riptide components and the Docker implementation run the following command:

```bash
pip3 install riptide-all
```

After this you will need to re-activate the virtualenv every time you want to use Riptide, or add the Riptide commands to the PATH:

```bash
# We asume ~/.local/bin is in the PATH and your virtualenv is at ~/virtualenvs. You can choose other directories if not.
ln -s ~/virtualenvs/riptide/bin/riptide ~/.local/bin
ln -s ~/virtualenvs/riptide/bin/riptide_proxy ~/.local/bin
ln -s ~/virtualenvs/riptide/bin/riptide_upgrade ~/.local/bin
```

You can test if Riptide is working:

```{raw} html
<script src="../_static/asciinema-player.js"></script>
<asciinema-player src="../_static/casts/test_riptide.cast" cols="80" rows="24"></asciinema-player>
```

#### Initializing the configuration

You will then need to initialize the Riptide configuration if this is the first time using Riptide. If you used Riptide
before skip this step (this will otherwise reset your configuration):

```bash
riptide config-edit-user --factoryreset
```

#### Shell integration

Riptide adds some additional features to your shell, in order to automatically add project
commands into your shell. Add the following lines to your .zshrc after any changes to PATH:

```zsh
# Riptide shell integration
. riptide.hook.zsh
# Riptide code completion
eval "$(_RIPTIDE_COMPLETE=zsh_source riptide)"
```

If you use Bash, add this to your .bashrc after any changes to PATH:

```bash
# Riptide shell integration
. riptide.hook.bash
# Riptide code completion
eval "$(_RIPTIDE_COMPLETE=bash_source riptide)"
```

#### SSL Certificate

Finally you want to import the SSL certificate authority. This allows your browser to trust
the Riptide proxy server. See {ref}`user_docs/proxy:Import the SSL certificate authority` for more details.

(upgrade-macos)=
## Updating Riptide

To update Riptide, run:

```bash
riptide_upgrade
```

After this make sure to restart the Proxy server. 

## Configuring shared folders (Docker Desktop)

Docker Desktop for MacOS only allows the virtual machine running the Docker daemon
limited access to your machine.

The default configuration is not enough to use Riptide. Please open the settings
of Docker and navigate to the Shared Folders tab. Make sure the following entries
are present:

- /Users
- /Volumes
- /private
- /tmp
- /var/folders
- /usr/local/lib/python3.7 (**Or wherever else Python is installed!**)

## Known issues under MacOS

- Due to emulation, Docker will generally run slower on macOS than on Linux. Consider using
  OrbStack, as it has been reported to be much faster than Docker Desktop. Additionally Riptide
  has some [Performance optimizations] enabled by default to increase performance.
- Due to the performance optimization settings, it might happen that changes to files
  are not immediately visible on the host system or the running containers. Some files
  are not updated on the host system at all (see [Performance optimizations]).

## Next steps

You are now ready to use Riptide. Head to the user documentation for more information on how to use it:

- {doc}`/user_docs/configuration`: Learn how to configure Riptide
- {doc}`/user_docs/shell`: Learn how to use and customize the shell integration
- {doc}`/user_docs/proxy`: Learn how to use the Proxy Server
- {doc}`/user_docs/working_with_riptide`: Learn how to use Riptide with existing Riptide projects
- {doc}`/user_docs/project` and {doc}`/config_docs`: Learn how to use Riptide for new projects

[performance optimizations]: ../user_docs/performance_optimizations
