#!/bin/bash

server_address=$1 
regex='^[a-zA-Z0-9\-\_\.\:\/]*$'      

if [[ ! $server_address =~ $regex ]]; 
then
	echo ERROR: incorrect server address
	exit 1
fi

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
        "hostname": "$(hostname)",
	"cpu-usage": $("$cwd/cpu.sh"),
EOF

getRAM
getDiskInfo
getRoute
getServices
getContainers
getImages
getNGINX

cat >> sysinfo.json <<EOF
}
EOF

curl -X POST -d @'sysinfo.json' -H "accept: */*" -H "Content-Type: application/json" $server_address -v
