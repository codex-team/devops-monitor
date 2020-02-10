#!/bin/bash

################################################
# The main script which collects server data
# and sends it to api.devops.codex.so
###############################################

serverAddress='https://api.devops.codex.so/services'

#Location of the scripts
script=`realpath $0`
cwd=`dirname $script`

source "$cwd/ram.sh"
source "$cwd/diskInfo.sh"
source "$cwd/routeTable.sh"
source "$cwd/servicesInfo.sh"
source "$cwd/containers.sh"
source "$cwd/images.sh"
source "$cwd/websites.sh"
source "$cwd/ipAddr.sh"

projectToken=$2

cat > $cwd/sysinfo.json <<EOF
{
	"name": "websites",
	"projectToken": "$projectToken",
	"payload":
	{
EOF
#	"cpu-usage": $("$cwd/cpu.sh"),
#EOF

#Calls functions to get server data
#getRAM
#getDiskInfo
#getRoute
#getServices
#getContainers
#getImages
getNGINX
getIpAddr

cat >> $cwd/sysinfo.json <<EOF
	}
}
EOF

curl -X POST -d @'sysinfo.json' -H "Content-Type: application/json" $serverAddress
