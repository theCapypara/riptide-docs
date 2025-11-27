# Log Files

A service in a project may define log files. These log files may be from the
standard output, the standard error, a file inside of the service container
or the output of a utility command inside the service container.

These can be configured using the `logging` attributes of a {doc}`/config_docs/entities/services`.

## `riptide log`

Riptide has a builtin command to view log files: `riptide log`. Using the `-s` flag you can filter specific
services and using the `-l` flag you can filter specific log files. There are also more options, like following the
log output (`-f`). See `riptide log --help` for more information.

### Example

```ansi-console
$ riptide log -f
[92mcypress stdout       | [0m[STARTED] Task without title.
[92mcypress stdout       | [0m[SUCCESS] Task without title.
[31mopensearch stderr    | [0mWARNING: Please consider reporting this to the maintainers of org.opensearch.bootstrap.Security
[31mopensearch stderr    | [0mWARNING: System::setSecurityManager will be removed in a future release
[33mcypress stderr       | [0m    at Initialize (../../third_party/dawn/src/dawn/native/vulkan/BackendVk.cpp:344)
[33mcypress stderr       | [0m    at Create (../../third_party/dawn/src/dawn/native/vulkan/BackendVk.cpp:266)
[33mcypress stderr       | [0m    at operator() (../../third_party/dawn/src/dawn/native/vulkan/BackendVk.cpp:521)
[33mcypress stderr       | [0m
[93mrabbitmq stdout      | [0m2025-11-26 14:43:50.160652+00:00 [info] <0.546.0>  * rabbitmq_management_agent
[93mrabbitmq stdout      | [0m2025-11-26 14:43:50.160652+00:00 [info] <0.546.0>  * rabbitmq_web_dispatch
[93mrabbitmq stdout      | [0m2025-11-26 14:43:50.237087+00:00 [info] <0.9.0> Time to start RabbitMQ: 6529 ms
[35mopensearch stdout    | [0m[2025-11-26T18:58:51,805][INFO ][o.o.j.s.JobSweeper       ] [riptide] Running full sweep
[35mopensearch stdout    | [0m[2025-11-26T19:03:51,805][INFO ][o.o.j.s.JobSweeper       ] [riptide] Running full sweep
[94mvarnish stderr       | [0mDebug: Version: varnish-7.4.3 revision b659b7ae62b44c05888919c5c1cd03ba6eaec681
[94mvarnish stderr       | [0mDebug: Platform: Linux,6.12.57,x86_64,-junix,-smalloc,-sdefault,-hcritbit
[94mvarnish stderr       | [0mDebug: Child (42) Started
[94mvarnish stderr       | [0mChild launched OK
[94mvarnish stderr       | [0mInfo: Child (42) said Child starts
[32mdb stdout            | [0m2025-11-26 14:43:43+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
[32mdb stdout            | [0m2025-11-26 14:43:43+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.0.44-1debian12 started.
[91mdb stderr            | [0m2025-11-26T14:43:43.970865Z 0 [System] [MY-010931] [Server] /usr/sbin/mysqld: ready for connections. Version: '8.0.44'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server - GPL.
[91mdb stderr            | [0mmbind: Operation not permitted
```

## View files manually

You can also view the log files directly:
open the directory `<project>/_riptide/logs/`.

You will find a directory in there for each service that defines logs.
Inside the directories are the log files.

Log files don't get cleared after a service reboots. If you want to clear them
manually, stop the service and remove the files.
