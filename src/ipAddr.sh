#!/bin/bash

###################################
# getting ip address of the server 
###################################

function getIpAddr
{
        local ip=`dig +short myip.opendns.com @resolver1.opendns.com` 

cat >> $cwd/sysinfo.json <<EOF
	        "public-ip":
	        {
			"ip": "$ip"
		}
EOF
}
