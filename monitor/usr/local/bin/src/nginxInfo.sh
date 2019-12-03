#!/bin/bash

###############################################################################
#getting nginx information
###############################################################################

function getNGINX
{
	local comma=""
	local stat=`systemctl status nginx | awk 'NR==3{print}' | cut -b 12-` #getting status of nginx server

cat >> sysinfo.json <<EOF
        "nginx-info":
	{
		"status": "$stat",
		"sites":
		[
EOF

	#getting information about nginx sites on this server
	local sites_available=`ls /etc/nginx/sites-available/`
	local n=`echo $sites_available | wc -w`

	for (( i=1; i <= $n; i++ ))
        do
		local site=`echo $sites_available | awk -F" " '{print $'$i'}'`
        	cat >> sysinfo.json <<EOF
			$comma
                	 "site-name": "$site" 
EOF
		comma=","
	done

cat >> sysinfo.json <<EOF
		]
	}
EOF
}
