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
 
if [ -d ~/recon/$DOM/feroxbuster ]
then
  echo " "
else
  mkdir ~/recon/$DOM/feroxbuster
 
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
echo "${blue} [+] Started Content Discovery Scanning ${reset}"
echo " "
 
#nuclei
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f /usr/bin/feroxbuster ]
then
 echo "${magenta} [+] Running Feroxbuster ${reset}"
 for url in $(cat ~/recon/$DOM/all-alive-subs.txt);do
 reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
 feroxbuster --url $url -w ~/tools/wordlists/common.txt -x php asp aspx jsp py txt conf config bak backup swp old db zip sql --threads 300 --output ~/recon/$DOM/Content_Discovery/content_discovery_result.txt
done
else
 echo "${blue} [+] Installing Feroxbuster ${reset}"
 wget https://github.com/epi052/feroxbuster/releases/latest/download/feroxbuster_amd64.deb.zip -P ~/tools/feroxbuster
 unzip ~/tools/feroxbuster/feroxbuster_amd64.deb.zip -d ~/tools/feroxbuster 
 sudo apt install ~/tools/feroxbuster/*.deb
 echo "${magenta} [+] Running Feroxbuster ${reset}"
 for url in $(cat ~/recon/$DOM/all-alive-subs.txt);do
 reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
 feroxbuster --url $url -w ~/tools/wordlists/common.txt -x php asp aspx jsp py txt conf config bak backup swp old db zip sql --threads 300 --output ~/recon/$DOM/Content_Discovery/content_discovery_result.txt
done
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"

