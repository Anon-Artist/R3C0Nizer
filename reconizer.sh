#!/bin/bash

function menu {
#colors
red=`tput setaf 1`
reset=`tput sgr0`
	clear
	echo
	echo -e "\t\t\t${red}
 =================================================
|   ____  _____  ____ ___  _   _ _                |
|  |  _ \|___ / / ___/ _ \| \ | (_)_______ _ __   |
|  | |_) | |_ \| |  | | | |  \| | |_  / _ \ '__|  |
|  |  _ < ___) | |__| |_| | |\  | |/ /  __/ |     |
|  |_| \_\____/ \____\___/|_| \_|_/___\___|_|     |
|                                                 |
 ================== Anon-Artist ==================
${reset}\n"
	echo -e "\tA. Subdomain Enumeration"
	echo -e "\tB. Scanning for Subdomain Takeover"
	echo -e "\tC. Port Scanning"
	echo -e "\tD. Visual Recon"
	echo -e "\tE. Content Discovery"
	echo -e "\tF. Parameter Fuzzing"
	echo -e "\tG. Nuclei Vulnerability Scanning"
	echo -e "\tH. Scanning for S3 Buckets"
	echo -e "\tI. Scanning for Broken Links"
	echo -e "\tJ. Scanning for CORS Misconfiguration"
	echo -e "\tK. Archive based Scanning"
	echo -e "\tL. GF Pattern based Scanning"
	echo -e "\tM. Scanning for JS files"
	echo -e " "
	echo -e "\t1. 101 Scan (FULL SCAN)\n"
	echo -e "\t0. Exit Menu\n\n"
	echo -en "\t\tEnter an Option: "
	read -n 1 option
}

function subenum {
	clear
        bash src/subenum.sh
}

function paramining {
	clear
	bash src/paramining.sh
}

function visualrecon {
	clear
	bash src/visual_recon.sh
}

function nucleicall {
	clear
	bash src/nucleicall.sh
}

function contentdisc {
        clear
        bash src/contentdiscovery.sh 
}

function archivescan {
	clear
	bash src/archivescan.sh
}

function portscanning {
	clear
	bash src/portscan.sh
}
function takeover_check {
	clear
	bash src/takeover.sh
}

function gfpattern {
	clear
	bash src/GF_pattern.sh
}

function jsrecon {
	clear
	bash src/jsrecon.sh
}

function bucketrecon {
	clear
        bash src/bucketrecon.sh
}

function blcscan {
	clear
        bash src/blcscan.sh
}

function corsscan {
	clear
        bash src/corsscan.sh
}

function fullscan {
	clear
        bash src/101scan.sh
}

while [ 1 ]
do
	menu
	case $option in
	0)
	break ;;
	A | a)
	subenum ;;
	
	B | b)
	takeover_check ;;

	C | c)
	portscanning ;;

	D | d)
	visualrecon ;;
	
	E | e)
	contentdisc;;

	F | f)
	paramining ;;
	
	G | g)
	nucleicall ;;
	
	H | h)
	bucketrecon ;;
	
	I | i)
	blcscan ;;
	
	J | j)
	corsscan ;;
	
	K | k)
	archivescan ;;
	
	L | l)
	gfpattern ;;
	
	M | m)
	jsrecon ;;
	
	1)
	fullscan ;;
	
	*)
	clear
	echo "Wrong selection";;
	esac
	echo -en "\n\n\t\t\tHit any key to continue"
	read -n 1 line
done
clear
