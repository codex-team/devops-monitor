#!/bin/bash

authToken=$(cat .env | egrep -o 'DEVOPSBOARD_AUTH_TOKEN=.+' | awk -F '=' '{print $2}')

# write help message
usage="$(basename "$0") [-h] [-p '<cron format>'] -- script to configure devops-monitor

where:
    -h  show this help text
    -p  time interval to launch monitoring (cron format), in quotes

Example: $(basename "$0") -p '0 0 * * *'

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
projectToken=$(curl -X POST -H 'Authorization: Bearer '$authToken'' -H 'Content-Type: application/json' -d '{"name":"'`dig +short myip.opendns.com @resolver1.opendns.com`'"}'  https://api.devops.codex.so/projects | egrep -o '"token":"[a-zA-Z0-9\.\-\_\+\/]+"' | awk -F ':' '{print $2}' | egrep -o '[^"]+')

# setup crontab file to launch periodically monitor.sh
crontab -l > tmpcron
echo "$period /opt/devops-monitor/monitor.sh $authToken $projectToken" >> tmpcron
crontab tmpcron
rm tmpcron
