#!/bin/bash

###############################################################################
#getting nginx information
###############################################################################

function getNGINX
{
	local comma=""

cat >> sysinfo.json <<EOF
        "websites":
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
			{
				"name": "$site",
				"status": "enabled"
			}
EOF
		comma=","
	done

cat >> sysinfo.json <<EOF
	]
EOF
}
