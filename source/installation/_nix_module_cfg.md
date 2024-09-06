
### services\.riptide\.enable



Whether to enable Riptide general service and CLI\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `




### services\.riptide\.cli

CLI settings



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.cli\.package



The riptide-cli package to use\.



*Type:*
package



*Default:*
` pkgs.riptide-cli `




### services\.riptide\.dbDrivers



Database driver settings



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.dbDrivers\.mongodb



Riptide MongoDB database driver



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.dbDrivers\.mongodb\.enable



Whether to enable Enable this package\.



*Type:*
boolean



*Default:*
` false `



*Example:*
` true `




### services\.riptide\.dbDrivers\.mongodb\.package



The riptide-db-mongo package to use\.



*Type:*
package



*Default:*
` pkgs.riptide-db-mongo `




### services\.riptide\.dbDrivers\.mysql



Riptide MySQL database driver



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.dbDrivers\.mysql\.enable



Whether to enable Enable this package\.



*Type:*
boolean



*Default:*
` true `



*Example:*
` true `




### services\.riptide\.dbDrivers\.mysql\.package



The riptide-db-mysql package to use\.



*Type:*
package



*Default:*
` pkgs.riptide-db-mysql `




### services\.riptide\.dockerHost



Override the docker/podman socket Riptide connects to\. Only relevant if
` engine.name = "docker" `\. Tries to auto-detect by default\.



*Type:*
string



*Default:*
` "" `



*Example:*
` "unix:///run/user/1000/podman/podman.sock" `




### services\.riptide\.engine



Settings regarding Riptide’s backend engine



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.engine\.package



The riptide-engine-docker package to use\.



*Type:*
package



*Default:*
` pkgs.riptide-engine-docker `




### services\.riptide\.engine\.name



Riptide engine implementation to use



*Type:*
string



*Default:*
` "docker" `




### services\.riptide\.extraConfig



Additional configuration to merge into the system configuration



*Type:*
JSON value



*Default:*
` { } `




### services\.riptide\.plugins



Plugin settings



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.plugins\.phpXdebug



Riptide Plugin to manage the state of PHP Xdebug



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.plugins\.phpXdebug\.enable



Whether to enable Enable this package\.



*Type:*
boolean



*Default:*
` true `



*Example:*
` true `




### services\.riptide\.plugins\.phpXdebug\.package



The riptide-plugin-php-xdebug package to use\.



*Type:*
package



*Default:*
` pkgs.riptide-plugin-php-xdebug `




### services\.riptide\.proxy



Settings regarding Riptide’s proxy server



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.proxy\.enable



Whether to enable Riptide Proxy Server\.



*Type:*
boolean



*Default:*
` true `



*Example:*
` true `




### services\.riptide\.proxy\.package



The riptide-proxy package to use\.



*Type:*
package



*Default:*
` pkgs.riptide-proxy `




### services\.riptide\.proxy\.autostart



Enable or disable auto-starting when a project or service is not running



*Type:*
boolean



*Default:*
` true `




### services\.riptide\.proxy\.ports



Proxy Server port configuration



*Type:*
submodule



*Default:*
` { } `




### services\.riptide\.proxy\.ports\.http



The HTTP port the proxy server should bind to



*Type:*
16 bit unsigned integer; between 0 and 65535 (both inclusive)



*Default:*
` 80 `



*Example:*
` 80 `




### services\.riptide\.proxy\.ports\.https



The HTTPS port the proxy server should bind to



*Type:*
16 bit unsigned integer; between 0 and 65535 (both inclusive)



*Default:*
` 443 `



*Example:*
` 443 `




### services\.riptide\.proxy\.url



The prefix that you want your projects to be accessible
under\. riptide\.local -> projectname\.riptide\.local



*Type:*
string



*Default:*
` "riptide.local" `



*Example:*
` "riptide.local" `




### services\.riptide\.repos



List of Riptide repositories\. By default this contains the public community repository



*Type:*
list of string



*Default:*

```
[
  "https://github.com/theCapypara/riptide-repo.git"
]
```



*Example:*

```
[
  "https://github.com/theCapypara/riptide-repo.git"
  "https://github.com/foobar/repo.git"
]
```




### services\.riptide\.resolveProjectHosts



If enabled, project URLs are locally resolvable\.
Under NixOS this will install the dnsmasq service, if not already installed\.
Under nix-darwin, the /etc/hosts file will be modified by Riptide\.



*Type:*
boolean



*Default:*
` true `




### services\.riptide\.user



The user to run the Riptide proxy as (if enabled) and the user for which
the configuration file will be created\.



*Type:*
string



*Example:*
` "yourUser" `


