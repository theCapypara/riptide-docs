# Windows Installation

This guide will explain how to install Riptide under Windows.

:::{note}
Windows is not supported as well as the Linux setup. Most of the downsides
of Riptide on Windows come from the Docker Desktop implementation for Windows.

Riptide has some [Performance optimizations] to increase
the performance on Windows, but it will still be slower than running it on Linux.

Also we can not offer any Windows specific support at the moment.

If you have experience with Docker or Python on Windows, we'd love your support in making
Riptide on Windows even better!
:::

## Installing Requirements

This guide assumes you want to run Riptide in the most common set-up using the Docker Engine.
To use Riptide you need to have the following installed:

- Python 3.8+
  \* Download: [Python website](https://www.python.org/downloads/).
- pip for Python 3 (might come installed with Python)
- [Docker Desktop 16.0+](https://www.docker.com/products/docker-desktop)

There is a good chance you already have Python installed. Try running `python3 --version` to check.

## Installing Riptide

Riptide should always be installed in a dedicated Python virtual environment to avoid conflicts between system packages and Riptide.

Choose a directory you want to store the virtualenv at, create a new virtualenv for Riptide and activate it:

```powershell
cd virtualenvs  # This can be whereever you want
python3 -m venv riptide
source riptide\Scripts\activate.ps1 # Activates the virtualenv
```

Then, to install all Riptide components and the Docker implementation run the following command:

```powershell
pip3 install riptide-all
```

After this you will need to re-activate the virtualenv every time you want to use Riptide.

You can test if Riptide is working:

```{raw} html
<script src="../_static/asciinema-player.js"></script>
<asciinema-player src="../_static/casts/test_riptide.cast" cols="80" rows="24"></asciinema-player>
```

You will then need to initialize the Riptide configuration if this is the first time using Riptide. If you used Riptide
before skip this step (this will otherwise reset your configuration):

### Initializing the configuration

```powershell
riptide config-edit-user --factoryreset
```

### SSL Certificate

Finally you want to import the SSL certificate authority. This allows your browser to trust
the Riptide proxy server. See {ref}`user_docs/proxy:Import the SSL certificate authority` for more details.

## Updating Riptide

To update Riptide, run:

```bash
riptide_upgrade
```

## Configuring shared drives

When installing Riptide on a drive other than C:, or when using projects from other drives,
you may need to share this drive with the Docker VM. A notice about this should automatically
open in this case.

## Additional Windows related notes

Many additional settings or issues not described in this documentation may be
directly related to the Docker Desktop for Windows implementation.

Please see the [documentation for Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/) for further information.

## Known issues under Windows

- Riptide currently uses the default Docker Desktop Windows daemon. This setup is known
  to have significantly worse performance than the Linux version. Riptide has some
  [Performance optimizations] to increase performance.
- Due to the performance optimization settings, it might happen that changes to files
  are not immediately visible on the host system or the running containers. Some files
  are not updated on the host system at all (see [Performance optimizations]).

:::{note}
If you are a Windows developer and want to improve this situation, please contact us.
A possible solution for the perfomance issues may be something like a
[docker-sync](https://github.com/EugenMayer/docker-sync) implementation
for Riptide or using Docker with WSL2 instead of using Docker Desktop. If you do,
please share your experience!
:::

## Next steps

You are now ready to use Riptide. Head to the user documentation for more information on how to use it:

- {doc}`/user_docs/configuration`: Learn how to configure Riptide
- {doc}`/user_docs/shell`: Learn how to use and customize the shell integration
- {doc}`/user_docs/proxy`: Learn how to use the Proxy Server
- {doc}`/user_docs/working_with_riptide`: Learn how to use Riptide with existing Riptide projects
- {doc}`/user_docs/project` and {doc}`/config_docs`: Learn how to use Riptide for new projects

[performance optimizations]: ../user_docs/performance_optimizations
