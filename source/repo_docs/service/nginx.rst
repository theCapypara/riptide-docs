.. AUTO-GENERATED, SEE README_CONTRIBUTORS. DO NOT EDIT.

nginx
=====

nginx_ web server.

.. _nginx: https://www.nginx.com/

**Link to entity in repository:** `<https://github.com/theCapypara/riptide-repo/tree/master/service/nginx>`_

..  contents:: Index
    :depth: 2

``/service/nginx/latest``
-------------------------

**Accessible via Proxy?**: yes

**Runs as the user using Riptide?**: no

Latest version of nginx. Make sure to override the file ``/etc/nginx/conf.d/default.conf`` with a ``server`` configuration.

Config
~~~~~~

+-----------------------+--------------------------------+---------------------------------+----------------------------+
| Name                  | Target                         | Should be replaced?             | Description                |
+=======================+================================+=================================+============================+
| nginx_conf            | /etc/nginx/nginx.conf          | no, add files to conf.d instead | Main Nginx configuration   |
+-----------------------+--------------------------------+---------------------------------+----------------------------+
| (Not provided!)       | /etc/nginx/conf.d/default.conf | yes                             | Nginx server configuration |
+-----------------------+--------------------------------+---------------------------------+----------------------------+
