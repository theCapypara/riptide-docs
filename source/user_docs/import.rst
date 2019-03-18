Importing Files
---------------

Riptide supports the definition of directories that are used to import files
into during the `project setup <4_project.html>`_.

You can also import files after the setup is completed by running
``riptide import-files KEY PATH_TO_IMPORT``.

``KEY`` is the import key. You can find his by executing ``riptide config-dump``
to output the entire project configuration. The import keys are defined under
``riptide.project.app.import``.

``PATH_TO_IMPORT`` is the path of the directory to import.
