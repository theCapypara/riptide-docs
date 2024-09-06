NixOS
-----

Riptide can be installed as a NixOS module. This is provided via a Flake
in the `riptide-all <https://github.com/theCapypara/riptide-all>`_ repository.

Installation
~~~~~~~~~~~~

You can either install the module via a Flake or by manually pulling the
module with ``fetchTarball`` in a classic NixOS system configuration.

Via Flake
^^^^^^^^^

Change your ``flake.nix`` like so:

.. code-block:: nix

    {
        inputs.riptide.url = "github:theCapypara/riptide-all";
        # optional:
        #inputs.riptide.inputs.nixpkgs.follows = "nixpkgs";
        # optionally choose not to download darwin deps (saves some resources on Linux)
        #inputs.riptide.inputs.darwin.follows = "";

        outputs = { self, nixpkgs, riptide }: {
            # change `yourhostname` to your actual hostname
            nixosConfigurations.yourhostname = nixpkgs.lib.nixosSystem {
                # change to your system:
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    riptide.nixosModules.default
                ];
            };
        };
    }

Via ``fetchTarball``
^^^^^^^^^^^^^^^^^^^^

Change your ``configuration.nix`` like so:

.. code-block:: nix

    {
        imports = [ "${builtins.fetchTarball "https://github.com/theCapypara/riptide-all/archive/master.tar.gz"}/nix/modules/nixos.nix" ];
    }

Advanced
^^^^^^^^

Advanced users can have a closer look at the Flake file. The file contains
an overlay that can also be used to install the packages without the module,
on any Linux distribution running the Nix package manager.

Enable Riptide
~~~~~~~~~~~~~~

To enable and use Riptide, use the ``services.riptide`` configuration:

.. code-block:: nix

    services.riptide = {
        enable = true;
        # Replace with your username. Must be managed by NixOS via `users.users`.
        user = "YOUR USERNAME";
    };

    # Docker must also be enabled. Podman may also be used, but may not
    # be fully compatible.
    virtualisation = {
        containers.enable = true;
        oci-containers.backend = "docker";
        docker.enable = true;
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
