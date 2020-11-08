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
	echo -e "\t2. Subdomain Takeover Scanning"
	echo -e "\t3. Port Scanning"
	echo -e "\t4. Visual Recon"
	echo -e "\t5. Content Discovery"
	echo -e "\t6. Parameter Fuzzing"
	echo -e "\t7. Archive based Scanning"
	echo -e "\t8. Nuclei"
	echo -e "\t9. Github Recon"
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

function Archivescan {
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

function githubrecon {
	clear
	bash src/gitrecon.sh
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
	takeover_check ;;

	3)
	portscanning ;;

	4)
	visualrecon ;;
	
	5)
	contentdisc;;

	6)
	paramining ;;
	
	7)
	Archivescan ;;
	
	8)
	nucleicall ;;
	
	9)
	githubrecon ;;

	*)
	clear
	echo "Wrong selection";;
	esac
	echo -en "\n\n\t\t\tHit any key to continue"
	read -n 1 line
done
clear
