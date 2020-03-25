# DevOps monitor

Collects data from local server and sends it to `api.devops.codex.so`

### Installing

1. Download one of the packages:

[monitor.deb](monitor.deb) or [monitor.rpm](monitor-1.0-1.src.rpm)

2. Install package:

```shell
$ sudo apt install monitor*.deb
Or
$ sudo dnf install monitor*.rpm 
``` 
3. Write your integration token into `/opt/devops-monitor/.env`:

```shell
DEVOPSBOARD_PROJECT_TOKEN=<your project token>
```
4. Run `configure.sh` to setup monitoring:

```shell
/opt/devops-monitor/configure.sh -p '<time interval in cron format>'
```
