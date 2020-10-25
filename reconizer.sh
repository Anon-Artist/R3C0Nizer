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
	echo -e "\t1. Subdomain enumeration"
	echo -e "\t2. Sorting alive subdomains and Visual Recon"
	echo -e "\t3. Content Discovery"
	echo -e "\t4. Parameter Mining"
	echo -e "\t5. GFPattern"
	echo -e "\t6. Nuclei"
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
function GFPattern {
	clear
	bash src/GF_Patterns.sh
}
while [ 1 ]
do
	menu
	case $option in
	0)
	break ;;
	1)
	subenum ;;

	2)
	visualrecon ;;
	
	3)
	contentdisc;;

	4)
	paramining ;;
	
	5)
	GFPattern ;;
	
	6)
	nucleicall ;;

	*)
	clear
	echo "Wrong selection";;
	esac
	echo -en "\n\n\t\t\tHit any key to continue"
	read -n 1 line
done
clear
