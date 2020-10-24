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
 
if [ -d ~/recon/$DOM/dirsearch ]
then
  echo " "
else
  mkdir ~/recon/$DOM/dirsearch
 
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
if [ -d ~/tools/dirsearch/ ]
then
  echo "${magenta} [+]  Content Discovery ${reset}"
  python3 ~/tools/dirsearch/dirsearch.py -u https://$DOM -e php,asp,aspx,jsp,py,txt,conf,config,bak,backup,swp,old,db,zip,sql -w ~/tools/wordlists/common.txt -x 429,400,503 -f --random-agents -t 300 -L ~/recon/$DOM/Content_discovery/directories.txt --max-retries=3 -b -r
else
  echo "${blue} [+] Installing dirsearch ${reset}"
  git clone https://github.com/maurosoria/dirsearch ~/tools/dirsearch
  wget https://raw.githubusercontent.com/v0re/dirb/master/wordlists/common.txt -P ~/tools/wordlists
  echo "${magenta} [+] Running Content Discovery ${reset}"
  python3 ~/tools/dirsearch/dirsearch.py -u https://$DOM -e php,asp,aspx,jsp,py,txt,conf,config,bak,backup,swp,old,db,zip,sql -w ~/tools/wordlists/common.txt -x 429,400,503 -f --random-agents -t 300 -L ~/recon/$DOM/Content_discovery/directories.txt --max-retries=3 -b -r
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"

