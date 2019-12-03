#!/bin/bash

################################################
# The main script which collects server data
# and sends it to api.devops.codex.so
###############################################

server_address='https://api.devops.codex.so/services'

#Location of the scripts
script=`realpath $0`
cwd=`dirname $script`

source "$cwd/ram.sh"
source "$cwd/diskInfo.sh"
source "$cwd/routeTable.sh"
source "$cwd/servicesInfo.sh"
source "$cwd/containers.sh"
source "$cwd/images.sh"
source "$cwd/nginxInfo.sh"

cat > sysinfo.json <<EOF
{
EOF

cat >> sysinfo.json <<EOF
	"hostname": "$(hostname)",
	"name": "nginx-info",
	"project_token": "321084yr1873y4813yr8ewyg3",
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

cat >> sysinfo.json <<EOF
}
EOF

curl -X POST -d @'sysinfo.json' -H "accept: */*" -H "Content-Type: application/json" $server_address -v
