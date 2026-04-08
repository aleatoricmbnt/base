# Data across plan and apply

Uses **`data.external`** and **`data.archive_file`** during plan, then **`null_resource`** with **`local-exec`** to unzip in apply. Exercises files and archives surviving between phases on the runner.
