#!/bin/bash

authToken=$(cat .env | awk -F 'DEVOPSBOARD_AUTH_TOKEN=' '{print $2}')

# write help message
usage="$(basename "$0") [-h] [-p <cron format>] -- script to configure devops-monitor

where:
    -h  show this help text
    -p  time interval to launch monitoring (in cron format)

Example: $(basename "$0") -p 0 0 * * *

"
period='0 0 * * *'

while getopts ':hp:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    p) period=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

# create project and get project token
projectToken=$(curl -X POST -H 'Authorization: Bearer '$authToken'' -H 'Content-Type: application/json' -d '{"name":"'`hostname`'"}' https://api.devops.codex.so/projects | awk -F '"token":' '{print $2}' | egrep -o '[^"]+')

# setup crontab file to launch periodically monitor.sh
crontab -l > tmpcron
echo "$period /opt/devops-monitor/monitor.sh $authToken $projectToken" >> tmpcron
crontab tmpcron
rm tmpcron
