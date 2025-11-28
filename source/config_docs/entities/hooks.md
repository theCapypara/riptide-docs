# Hook

A hook is an instance of a {doc}`commands` that is executed when a certain event triggers.

You can find more information on how hooks work and how to use them in the corresponding 
section of the user documentation: {doc}`/user_docs/hooks`.

## Schema

```{include} tpl/desc_schema.md

```

```{autodoc2-object} riptide.config.document.hook.Hook.schema
render_plugin = "myst"
```

(list-of-hook-events)=
## List of events

What follows is a list of defined hooks in the latest Riptide release. The keys to be used
in hook configuration files are the strings next to the identifier. For `PreStart` you
will find that this is `pre-start`.
It is also always possible to configure and trigger custom hooks using the `custom-` prefix.

```{autodoc2-object} riptide.hook.event.HookEvent
render_plugin = "myst"
```
