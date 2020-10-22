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

if [ -d ~/recon/$DOM/Visual_Recon ]
then
  echo " "
else
  mkdir ~/recon/$DOM/Visual_Recon

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
echo "${blue} [+] Started Sorting Alive Subdomains and Visual Recon ${reset}"
echo " "

#sorting alive subdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/httpx ]
then
  echo "${magenta} [+] Sorting Alive Subdomains ${reset}"
cat ~/recon/$DOM/unique.txt | httpx >> ~/recon/$DOM/Visual_Recon/all-unique-alive-subs.txt
else
  echo "${blue} [+] Installing Httpx ${reset}"
  go get -u github.com/projectdiscovery/httpx/cmd/httpx
  echo "${magenta} [+] Sorting Alive Subdomains ${reset}"
  cat ~/recon/$DOM/unique.txt | httpx >> ~/recon/$DOM/Visual_Recon/all-unique-alive-subs.txt
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved to all-unique-alive-subs.txt"

#screenshotting
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
mkdir ~/recon/$DOM/Visual_Recon/screenshots
if [ -f ~/go/bin/aquatone ]
then
  echo "${magenta} [+] Screenshotting Alive subs ${reset}"
  cat ~/recon/$DOM/Visual_Recon/all-unique-alive-subs.txt | aquatone -out ~/recon/$DOM/Visual_Recon/screenshots
else
  echo "${blue} [+] Installing Aquatone ${reset}"
  go get github.com/michenriksen/aquatone
  echo "${magenta} [+] Screenshotting Alive subs ${reset}"
  cat ~/recon/$DOM/Visual_Recon/all-unique-alive-subs.txt | aquatone -out ~/recon/$DOM/Visual_Recon/screenshots
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved to screenshots"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
