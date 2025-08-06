# System (User) Configuration

The system configuration is the main configuration file that defines global behaviour for Riptide,
such as the proxy server configuration.

It is located under "[\<CONFIG>](../../index)/config.yml".

## Schema

```{include} tpl/desc_schema.md

```

```{autodoc2-object} riptide.config.document.config.Config.schema
render_plugin = "myst"
```

## Helper Functions

```{include} tpl/desc_var_helpers.md

```

```{autodoc2-object} riptide.config.document.config.Config.get_config_dir
render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.config.Config.get_plugin_flag
render_plugin = "myst"
```
