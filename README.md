# DevOps monitor

Collect data from local server and send it to example.com 

```shell
./begin.sh -t 60 -a http://example.com/monitor/v1/server-data?server-name=abc.com
```
Help: `./begin.sh -h`

Server must respond with status 204.
The server side can be generated from `openapi.json` on http://editor.swagger.io
