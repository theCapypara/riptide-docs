# App

An app defines all the different services (sub-applications) and commands that are required
to run a web development project for a specific framework or application.

An app consists of a number of [services](./services) and [commands](./commands), a list of
files that can be imported during the initial setup and some usage notes.

## Schema

```{include} tpl/desc_schema.md

```

```{autodoc2-object} riptide.config.document.app.App.schema
render_plugin = "myst"
```

## Helper Functions

```{include} tpl/desc_var_helpers.md

```

```{autodoc2-object} riptide.config.document.app.App.parent
render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.app.App.get_service_by_role
render_plugin = "myst"
```

```{autodoc2-object} riptide.config.document.app.App.get_services_by_role
render_plugin = "myst"
```
