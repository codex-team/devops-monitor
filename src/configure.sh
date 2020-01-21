#!/bin/bash

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

# get user credentials
echo "E-Mail: "
read email

echo "Password: " 
read -s password
echo

# login and get auth token 
authToken=$(curl -X POST -H 'Content-Type: application/json' -d '{"email": "'$email'","password": "'$password'"}' https://api.devops.codex.so/auth/login | egrep -o '"jwt":"[a-zA-Z0-9\.\-\_\+]+"' | awk -F ':' '{print $2}' | egrep -o '[^"]+')
echo $authToken

# create project and get project token
projectToken=$(curl -X POST -H 'Authorization: Bearer '$authToken'' -H 'Content-Type: application/json' -d '{"name":"'`hostname`'"}' https://api.devops.codex.so/projects | egrep -o '"token":"[a-zA-Z0-9\.\-\_\+]+"' | awk -F ':' '{print $2}' | egrep -o '[^"]+')
echo $projectToken

# setup crontab file to launch periodically monitor.sh
crontab -e < "$period /opt/devops-monitor/monitor.sh $authToken $projectToken"
