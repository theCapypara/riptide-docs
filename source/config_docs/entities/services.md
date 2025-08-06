# Service

A service is the definition of a software container that contains one of the applications
required to run the entire [app](./apps).

Since services are container definitions, they need to contain at least the name of an image to run.
All other fields are optional.

## Schema

```{include} tpl/desc_schema.md

```

```{autodoc2-object} riptide.config.document.service.Service.schema
render_plugin = "myst"
```

## Helper Functions

```{include} tpl/desc_var_helpers.md

```

```{autodoc2-object} riptide.config.document.service.Service.parent

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.common_service_command.ContainerDefinitionYamlConfigDocument.system_config

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.service.Service.volume_path

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.service.Service.get_working_directory

render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.service.Service.domain

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

## Helpfer Functions for configuration files

The helper functions listed here can only be used inside files used with the `config` setting
of services.

```{autodoc2-object} riptide.config.service.config_files_helper_functions.read_file

render_plugin = "myst"
```
