#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/reconizer/ ]
then
  echo " "
else
  mkdir ~/reconizer
fi

if [ -d ~/reconizer/$DOM ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM
fi

if [ -d ~/reconizer/$DOM/whatweb ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/whatweb
fi


echo "${red}
 =================================================
|   ____  _____  ____ ___  _   _ _                |
|  |  _ \|___ / / ___/ _ \| \ | (_)_______ _ __   |
|  | |_) | |_ \| |  | | | |  \| | |_  / _ \ '__|  |
|  |  _ < ___) | |__| |_| | |\  | |/ /  __/ |     |
|  |_| \_\____/ \____\___/|_| \_|_/___\___|_|     |
|                                                 |
 ================== Anon-Artist ==================
${reset}"
echo "${blue} Starting Whatweb!. ${reset}"; sleep 1
echo " "

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "

if [ ! -x "$(command -v whatweb)" ]; then
	echo "${blue} [+] Installing Whatweb ${reset}"
	sudo apt-get install whatweb -y > whatweb; rm whatweb

else
	echo "${magenta} [+] Pulling plugins data on $DOM $(date +'%Y-%m-%d %T')${reset}"
	whatweb --info-plugins -t 50 -v $DOM > ~/reconizer/$DOM/whatweb_plugins.txt ; sleep 2
	echo "${magenta} [+] Running Whatweb on $DOM $(date +'%Y-%m-%d %T') ${reset}"
	whatweb -t 50 -v $DOM > ~/reconizer/$DOM/whatweb.txt; sleep 1
	echo ""
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
