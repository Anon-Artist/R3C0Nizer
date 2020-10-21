#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter domain name : " DOM

if [ -d ~/recon/ ]
then
  echo " "
else
  mkdir ~/recon

fi

if [ -d ~/recon/$DOM ]
then
  echo " "
else
  mkdir ~/recon/$DOM

fi

if [ -d ~/recon/$DOM/nuclei ]
then
  echo " "
else
  mkdir ~/recon/$DOM/nuclei

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
echo "${blue} [+] Started Nuclei Scanning ${reset}"
echo " "

#nuclei
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/nuclei ]
then
 echo "${magenta} [+] Running nuclei ${reset}"
 nuclei -update-templates
 nuclei -l ~/recon/$DOM/unique.txt -t cves/ -t files/ -o ~/recon/$DOM/nuclei/nuclei_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  echo "${magenta} [+] Running nuclei ${reset}"
  go get -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  nuclei -update-templates
  nuclei -l ~/recon/$DOM/unique.txt -t cves/ -t files/ -o ~/recon/$DOM/nuclei/nuclei_results.txt
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
