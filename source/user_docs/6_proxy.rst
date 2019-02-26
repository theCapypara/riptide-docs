Proxy Server Setup
------------------
The Riptide proxy server routes the traffic for your projects and services,
you use it to access HTTP-based services of the project you are working on.

Proxy Server URL
~~~~~~~~~~~~~~~~
The Proxy server URL can be configured by calling ``riptide config-edit-user``
and changing the value of ``riptide.proxy.url``.

Enter the hostname you want your proxy server to be accessible at there.
Your local machine must be routable to this hostname and all wildcard domains
for that hostname.

Assuming you enter ``riptide.local`` the following hostnames must be routable
to your local machine using DNS:

* ``riptide.local``
* ``*.riptide.local``

Please ask your network administrator on how to setup DNS. For Tudock enter
``xy.tudock.local`` (where xy are your initials) and ask Marco for network setup.

If you don't have a network administrator, you can setup a DNS forwarder like
`Dnsmasq <https://en.wikipedia.org/wiki/Dnsmasq>`_ on your machine instead.

Proxy Server HTTP/HTTPS Ports
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The proxy server can route HTTP and HTTPS traffic. You can change the ports by
editing the system configuration (``riptide config-edit-user``) and changing
the values of ``riptide.proxy.ports``.

If you plan to use the proxy server standalone as your primary HTTP and HTTPS
server on your machine, leave the defaults (80 and 443).

If you already have a webserver on ports 80 and 443 and/or plan to use the
Riptide proxy behind a reverse proxy (eg. Nginx or Apache), change the ports
to something else, preferably a four-digit port combination (eg. 8080 and 8443).

You can also disable HTTPS by setting the value for ``https`` to ``false``.
Do this if you want to run the proxy server behind a reverse proxy with SSL
termination.

Auto-Start and Auto-Exit
~~~~~~~~~~~~~~~~~~~~~~~~
The proxy server can automatically start projects if you access the URL for a
service. To disable this set ``riptide.proxy.autostart`` to ``false``
in the system configuration. ``true`` enables it.

If you want the proxy to automatically shutdown projects after a certain time
of no request, set the ``riptide.proxy.autoexit`` setting to a value
(unit is minutes). ``false`` disables the feature.

.. note:: Auto-exit is not implemented yet.

Starting the Proxy Server
~~~~~~~~~~~~~~~~~~~~~~~~~
How to start the proxy server depends on your system.

Linux, ports <= 1024
^^^^^^^^^^^^^^^^^^^^
If you are on Linux and the port number of either HTTP or HTTPS is below 1024,
you need to start the Proxy Server as root. These elevated privileges are required
for applications to be able to bind ports below 1024. After binding the port the
proxy will automatically drop all it's privileges to the user executing sudo.

To start the server in this scenario::

  $ sudo riptide_proxy
  Was running as root. Changing user to marco.
  Starting Riptide Proxy on HTTPS port 443
  Starting Riptide Proxy on HTTP port 80

After starting the proxy server head over to the URL you configured for the
proxy server and you should see a landing page for the proxy server.

Mac , ports <= 1024
^^^^^^^^^^^^^^^^^^^
Running the proxy server with ports lower than 1024 is not supported due to
permission issues on Mac. Please use higher ports and configure firewall
rules if you wish to access the Proxy Server on ports lower than 1024.

All other platforms
^^^^^^^^^^^^^^^^^^^
On all other platforms and on Linux when using ports above 1024, you can start
the proxy server as your current user without sudo or an Administrator Command Line::

  $ riptide_proxy
  Starting Riptide Proxy on HTTPS port 443
  Starting Riptide Proxy on HTTP port 80

After starting the proxy server head over to the URL you configured for the
proxy server and you should see a landing page for the proxy server.

Start the Proxy on system boot
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You may want to start the proxy server automatically whenever you log in, this
section describes how to do so for different platforms.

Linux, ports <= 1024 (Systemd)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
When using the proxy server with ports below 1024, the server needs to be run as root.
This means for autostart it has to be configured as a system level service.

Create the follwing unit file under ``/etc/systemd/system/riptide.service``::

  [Unit]
  Description=Riptide

  [Service]
  ExecStart=<PROXY> --user=<USERNAME>
  Restart=on-failure

  [Install]
  WantedBy=multi-user.target

You need to replace ``<USERNAME>`` with your username and ``<PROXY>`` with the
full path to the proxy executable which you can get by calling ``which riptide_proxy``.

After that you need to reload the systemd daemon::

  sudo systemctl daemon-reload

To enable autostart::

  sudo systemctl enable riptide

To start the proxy server right away::

  sudo systemctl start riptide

Linux, ports > 1024 (Systemd)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
When using ports above 1024 it is best to configure the proxy server as a user level unit.
This means that the proxy server is directly bound to your user account and will autostart
on login.

Create the following unit file under ``~/.config/systemd/user/riptide.service``::

  [Unit]
  Description=Riptide

  [Service]
  ExecStart=<PROXY>
  Restart=on-failure

  [Install]
  WantedBy=multi-user.target

You need to replace ``<PROXY>`` with the full path to the proxy executable
which you can get by calling ``which riptide_proxy``.

After that you need to reload the systemd daemon::

  sudo systemctl daemon-reload

To enable autostart::

  systemctl --user enable riptide

To start the proxy server right away::

  systemctl --user start riptide

Other platforms
^^^^^^^^^^^^^^^
There is no info on how to do this on other platforms here yet. Please start the
proxy server manually as described above.

Running the Proxy Server behind Nginx or Apache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You may want to run Riptide behind an Nginx or Apache proxy.
This is especially useful if you work on projects that don't use Riptide.

This guide will show you how to do that, assuming you set the HTTP port of
Riptide proxy to 8888 and disabled HTTPS. This guide assumes Nginx or Apache
will terminate SSL for you.

Nginx
^^^^^

.. code-block:: nginx

    server {
      listen 80;
      listen [::]:80;

      # Configure SSL if desired
      #listen *:443 ssl http2;
      #listen [::]:443 ssl http2;
      #ssl_certificate ...
      #ssl_certificate_key ...

      server_name <INSERT PROXY HOSTNAME HERE>;
      server_name *.<INSERT PROXY HOSTNAME HERE>;

      client_max_body_size 2G;

      location / {
          proxy_pass            http://127.0.0.1:<INSERT PROXY HTTP PORT HERE>;
          proxy_read_timeout    90000;
          proxy_send_timeout    90000;
          proxy_connect_timeout 90000;
          send_timeout          90000;

          proxy_set_header      X-Real-IP $remote_addr;
          proxy_set_header      X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header      Host $host;
          proxy_set_header      X-Forwarded-Proto $scheme;

      }

      # WebSocket Reverse Proxy
      location /___riptide_proxy_ws {
        proxy_pass http://127.0.0.1:<INSERT PROXY HTTP PORT HERE>;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
      }

    }


Apache
^^^^^^

The modules ``proxy``, ``proxy_http`` and ``proxy_wstunnel`` must be enabled.

.. warning:: This is currently untested, please report if you tested this.

.. code-block:: apacheconf

    <VirtualHost *:80>
        ServerName <INSERT PROXY HOSTNAME HERE>
        ServerAlias *.<INSERT PROXY HOSTNAME HERE>

        RewriteCond %{HTTP:Upgrade} =websocket [NC]
        RewriteRule ^/___riptide_proxy_ws    ws://127.0.0.1:<INSERT PROXY HTTP PORT HERE>/___riptide_proxy_ws [P,L]

        ProxyPreserveHost On
        ProxyTimeout 90000
        ProxyPass / http://127.0.0.1:<INSERT PROXY HTTP PORT HERE>/
        ProxyPassReverse / http://127.0.0.1:<INSERT PROXY HTTP PORT HERE>/
    </VirtualHost>

    <IfModule mod_ssl.c>
    <VirtualHost *:443>
        ServerName <INSERT PROXY HOSTNAME HERE>
        ServerAlias *.<INSERT PROXY HOSTNAME HERE>

        RewriteCond %{HTTP:Upgrade} =websocket [NC]
        RewriteRule ^/___riptide_proxy_ws    wss://127.0.0.1:<INSERT PROXY HTTP PORT HERE>/___riptide_proxy_ws [P,L]

        ProxyPreserveHost On
        ProxyTimeout 90000
        ProxyPass / http://127.0.0.1:<INSERT PROXY HTTP PORT HERE>/
        ProxyPassReverse / http://127.0.0.1:<INSERT PROXY HTTP PORT HERE>/
    </VirtualHost>
    </IfModule>


Import the SSL certificate authority
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
If you enable the HTTPS feature of the proxy server, you propably want to import
the certificate authority (CA) into your browser, so that you don't get an SSL
warning every time you restart the proxy server or enter a different project.

Location
^^^^^^^^
The CA file is located under
"`<CONFIG> <../index#Riptide-config-files>`_/riptide_proxy/ca.pem".

The file is created on the first startup of the proxy server. You can also place
your own CA file here.

Chrome
^^^^^^

1. Navigate to ``chrome://settings/certificates?search=SSL``

2. Go to the tab for certificate authorities

3. Click Import and import the CA file, mark it as trusted to identidy websites.

Firefox
^^^^^^^

1. Navigate to ``about:preferences#privacy``

2. Search for "Certificates" and press the "View Certificates..." button.

3. On the "Authorities" tab "Import..." the CA certificate. Trust the certificate
   to identify websites.
