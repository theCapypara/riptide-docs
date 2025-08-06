# Performance Optimizations

Riptide has some settings for performance optimizations that may be
enabled on any platform, but only bring benefits on some.

Riptide also has some fixed built-in performance optimizations for specific platforms.

## Configurable Performance Optimizations

These performance optimizations can be toggled in the {doc}`/config_docs/entities/config` (`riptide config-edit-user`).

They are found under the `performance` key. The default value for all settings is `auto`, which means
that Riptide will automatically decide, of the performance option should be enabled or not.

### Named Volumes instead of Host-Path volumes (dont_sync_named_volumes_with_host)

If enabled, volumes, that have a volume_name set, are not mounted to the host system and are instead
created as volumes with the volume_name. Otherwise they are created as host path volumes only.
Enabling this increases performance on some platforms.

Please note, that Riptide does not delete named volume data for old projects.
Please consult the documentation of the engine, on how to do that.

“auto” enables this feature on Mac and Windows, when using the Docker container backend.

Switching this setting on or off breaks existing volumes. They need to be migrated manually.
See Update notes for version {doc}`/update_docs/0.5.0`

### Do not synchronize unimportant paths with the host system (dont_sync_unimportant_src)

Normally all Commands and Services get access to the entire source directory of a project as volume.
If this setting is enabled, `unimportant_paths` that are defined in the {doc}`/config_docs/entities/apps` are not updated on the
host system when changed by the volume. This means changes to these files are not available,
but file access speeds may be drastically increased on some platforms.

Currently all files written inside the container are lost on container restart. The files are currently
written to RAM.

“auto” enables this feature on Mac and Windows, when using the Docker container backend.

This feature can be safely switched on or off. Projects need to be restarted for this to take effect.

## Platform-specific optimizations

### MacOS

Under MacOS when using Docker, the performance setting `delegated` is set for volumes. This means
that sometimes changes to files within the container are not immediately visible on the host system.

See the [Docker documentation](https://docs.docker.com/docker-for-mac/osxfs-caching/) for more details.
