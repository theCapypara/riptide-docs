# Command

A command is the specification for a container that can be started interactively by the user. This
is used to start CLI command containers.

Commands can either be invoked via `riptide cmd` or directly via Riptide's shell integration.

Commands either run as separate containers in the same container network as
services (normal commands), or are started in running service containers.

## Schema

```{include} tpl/desc_schema.md

```

```{autodoc2-object} riptide.config.document.command.Command.schema
render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.command.Command.schema_normal
render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.command.Command.schema_in_service
render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.command.Command.schema_alias
render_plugin = "myst"
```

## Helper Functions

```{include} tpl/desc_var_helpers.md

```

```{autodoc2-object} riptide.config.document.command.Command.parent

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.common_service_command.ContainerDefinitionYamlConfigDocument.system_config

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.command.Command.volume_path

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.common_service_command.ContainerDefinitionYamlConfigDocument.os_user

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.common_service_command.ContainerDefinitionYamlConfigDocument.os_group

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.common_service_command.ContainerDefinitionYamlConfigDocument.host_address

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.common_service_command.ContainerDefinitionYamlConfigDocument.home_path

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.common_service_command.ContainerDefinitionYamlConfigDocument.get_tempdir

render_plugin = "myst"
```
