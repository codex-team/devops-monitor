# DevOps monitor

Collects data from local server and sends it to `api.devops.codex.so`

### Installing

1. Download one of the packages:

[monitor.deb](monitor.deb) or [monitor.src.rpm](monitor-1-1.src.rpm)

2. Run:

```shell
sudo dpkg -i  monitor.deb
``` 
   Or

```shell
sudo rpm -i monitor*.src.rpm
```
3. Write your authentication and project tokens into `/opt/devops-monitor/.env`:

```shell
DEVOPSBOARD_AUTH_TOKEN=<your auth token>
DEVOPSBOARD_PROJECT_TOKEN=<your project token>
```
4. Run `configure.sh` to setup monitoring:

```shell
/opt/devops-monitor/configure.sh -p '<time interval in cron format>'
```
