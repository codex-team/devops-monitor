# DevOps monitor

Collects data from local server and sends it to api.devops.codex.so
OpenAPI spec: `openapi.json`

### Installing

#### 1. If you use Ubuntu/Debian:

Download `mon_1.0-1.deb`

Run:

```shell
sudo dpkg -i  mon_1.0-1.deb
``` 

#### If you use CentOS/RHEL:

Download `mon-1-0.src.rpm`

Run:

```shell
sudo rpm –i mon-1-0.src.rpm
```

#### 2. Run:

```shell
sudo crontab -e 
```

#### 3. Write into your crontab file:

```shell
SHELL=/bin/bash

*/1 * * * * /opt/mon/mon.sh http://api.devops.codex.so/server-data?server-name=your-server-name.com
```
In this example the data is being collected every 1 minute, but you can set any other time interval.
