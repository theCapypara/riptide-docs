% AUTO-GENERATED, SEE README_CONTRIBUTORS. DO NOT EDIT.

# Jupyter

Jupyter Service for python notebooks.


## `/service/jupyter/base`

**Accessible via Proxy?**: yes

**Runs as the user using Riptide?**: yes

Python Jupyter Notebooks server.

### Suggested Roles

**Suggested roles**: `src`

This service should have access to the source code of the application via the role `src`.

### Additional volumes

| Name      | Source            | Source path | Target path           | Description            |
| --------- | ----------------- | ----------- | --------------------- | ---------------------- |
| notebooks | Project directory | ./notebooks | /notebooks            | Jupyter notebooks root |
**Link to entity in repository:** `<https://github.com/theCapypara/riptide-repo/tree/master/service/jupyter>`_

| jupyter   | Project directory | ./.jupyter  | /home/docker/.jupyter | Jupyter config         |
