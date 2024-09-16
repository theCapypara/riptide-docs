MacOS via nix-darwin
--------------------

If you are using `nix-darwin <https://github.com/LnL7/nix-darwin>`_ you can install Riptide on macOS using
a nix-darwin module. This allows much greater functionality to be supported than with the manual setup, however
nix-darwin is overall still somewhat experimental.

This module is provided via a Flake in the `riptide-all <https://github.com/theCapypara/riptide-all>`_ 
repository.

Installation
~~~~~~~~~~~~

You can either install the module via a Flake or by manually pulling the
module with ``fetchTarball`` in a classic nix-darwin system configuration.

In addition to these steps, Docker Desktop must be installed on your system.

Via Flake
^^^^^^^^^

Change your ``flake.nix`` like so:

.. code-block:: nix

    {
        inputs.riptide.url = "github:theCapypara/riptide-all";
        # optional:
        #inputs.riptide.inputs.nixpkgs.follows = "nixpkgs";

        outputs = { self, nixpkgs, riptide }: {
            # change `yourhostname` to your actual hostname
            darwinConfigurations.yourhostname = nixpkgs.lib.darwinSystem {
                # change to your system:
                system = "x86_64-darwin";
                modules = [
                    ./configuration.nix
                    riptide.darwinModules.default
                ];
            };
        };
    }

Via ``fetchTarball``
^^^^^^^^^^^^^^^^^^^^

Change your ``configuration.nix`` like so:

.. code-block:: nix

    {
        imports = [ "${builtins.fetchTarball "https://github.com/theCapypara/riptide-all/archive/master.tar.gz"}/nix/modules/darwin.nix" ];
    }

Enable Riptide
~~~~~~~~~~~~~~

To enable and use Riptide, use the ``services.riptide`` configuration:

.. code-block:: nix

    # Your user and its home directory MUST be declared in the configuration:
    users.users."YOUR USERNAME" = {
        home = "/Users/YOUR USERNAME/";
    };

    services.riptide = {
        enable = true;
        # Replace with your username.
        user = "YOUR USERNAME";
    };

See below for all options.

Shell integration
~~~~~~~~~~~~~~~~~

Riptide adds some additional features to your shell, in order to automatically add project
commands into your shell. To use this feature, asuming you use Flakes, 
you can add hooks into your bashrc or zshrc via 
``riptide.riptideShellIntegration.bash`` or ``riptide.riptideShellIntegration.zsh``.

Example for ZSH using home-manager:

.. code-block:: nix

    { riptide }:

    {
        programs.zsh = {
            enable = true;
            enableCompletion = true;

            initExtra = ''
                ${riptide.riptideShellIntegration.zsh}
            '';
        };
    }

If you can not use this or are not using Flakes add these to either
your .zshrc or .bashrc:

- .bashrc: ``. <(nix-riptide.hook.bash)``
- .zshrc: ``. <(nix-riptide.hook.zsh)``

Please note that these could change with Riptide updates, so using
the value provided by the Flake is recommended.

Module configuration
~~~~~~~~~~~~~~~~~~~~

.. include:: _nix_module_cfg.md
   :parser: myst_parser.sphinx_
