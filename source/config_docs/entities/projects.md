# Project

Projects represent one web development project.

They are loaded from `riptide.yml` files. Additionally, if a `riptide.local.yml` exists, it's contents
are merged on top of the `riptide.yml`.

A project consists of one [app](./apps).

## Schema

```{include} tpl/desc_schema.md

```

```{autodoc2-object} riptide.config.document.project.Project.schema
render_plugin = "myst"
```

## Helper Functions

```{include} tpl/desc_var_helpers.md

```


```{autodoc2-object} riptide.config.document.project.Project.parent
render_plugin = "myst"
```