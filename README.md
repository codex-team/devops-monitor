# DevOps monitor

Collects data from local server and sends it to `api.devops.codex.so`

OpenAPI spec: `openapi.json`

### Installing

#### 1. If you use Ubuntu/Debian:

Download `monitor.deb`

Run:

```shell
sudo dpkg -i  monitor.deb
``` 

#### If you use CentOS/RHEL:

Download `monitor-1-0.src.rpm`

Run:

```shell
sudo rpm -i monitor-1-0.src.rpm
```

#### 2. Run:

```shell
sudo crontab -e 
```

#### 3. Write into your crontab file:

```shell
SHELL=/bin/bash

*/1 * * * * /usr/local/bin/src/monitor.sh https://api.devops.codex.so/services
```
In this example the data is being collected every 1 minute, but you can set any other time interval.
