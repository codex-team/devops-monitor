#!/bin/bash

###################################
# getting ip address of the server 
###################################

function getIpAddr
{
        local ip=`dig +short myip.opendns.com @resolver1.opendns.com` 

cat >> $cwd/sysinfo.json <<EOF
	        "publicIp":
	        {
			"ip": "$ip"
		}
EOF
}
