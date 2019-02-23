Log Files
---------
A service in a project may define log files. These log files may be from the
standard output, the standard error, a file inside of the service container
or the output of a utility command inside the service cointainer.

To view the log files, open the directory ``<project>/_riptide/logs/``.
You will find a directory in there for each service that defines logs.
Inside the directories are the logfiles.

Logfiles don't get cleared after a service reboots. If you want to clear them
manually, stop the service and remove the files.
