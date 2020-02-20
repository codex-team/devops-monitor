#!/bin/bash

###############################################################################
#getting nginx information
###############################################################################

function getNGINX
{
	local comma=""

cat >> $cwd/sysinfo.json <<EOF
	        "websites":
		[
		
EOF

	#getting information about nginx sites on this server
	local sites_available=`ls /etc/nginx/sites-available/`
	local n=`echo $sites_available | wc -w`

	for (( i=1; i <= $n; i++ ))
        do
		local site=`echo $sites_available | awk -F" " '{print $'$i'}'`
        	cat >> $cwd/sysinfo.json <<EOF
			$comma
			{
				"name": "$site",
				"status": "enabled"
			}
EOF
		comma=","
	done

cat >> $cwd/sysinfo.json <<EOF
		],
EOF
}
