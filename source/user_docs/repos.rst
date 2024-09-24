Using Repositories
------------------

Parts of project configuration may be stored in external repositories. Repositories make
it easy to share Services, Commands or other parts of the configuration across multiple
projects.

You can check if your project uses repositories by opening the project's ``riptide.yml``.
If it contains ``$ref``-keys then parts of the configuration are merged with documents from the
repositories. If, for example, the ``app`` entry contains a ``$ref`` entry with the value ``app/demo``, then Riptide searches
for the App by searching for ``app/demo.yml`` inside all your configured repositories.
The ``app/demo.yml`` is loaded as your App and then the contents under ``app`` in the project's ``riptide.yml`` are merged together.

More information about repositories, can be found under :doc:`/config_docs/mechanics/how_repositories`.

You can change repositories by running ``riptide config-user-edit``. Repositories are defined as a list under the ``repo`` key.
Riptide repositories are Git repositories. Enter the clone-URLs for your repositories there.

You can update (pull) the current contents of all repositories by running ``riptide update``.
This command also updates all project images.

The repositories are stored in the "`<CONFIG> <../index.html#Riptide-config-files>`_/repos" folder.
Since they are ordinary Git repositories you can pull and push repositories that are stored there.
