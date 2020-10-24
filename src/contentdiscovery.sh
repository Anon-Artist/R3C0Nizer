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
  for url in $(cat ~/recon/$DOM/all-alive-subs.txt);do
  reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
  python3 ~/tools/dirsearch/dirsearch.py -u $url -e php,asp,aspx,jsp,py,txt,conf,config,bak,backup,swp,old,db,zip,sql -w ~/tools/wordlists/common.txt -x 429,400,503 -f --random-agents -t 300 --max-retries=3 -b -r --plain-text-report=~/tools/dirsearch/$reg.tmp
  if [ ! -s ~/tools/dirsearch/$reg.tmp ]; then
            rm ~/tools/dirsearch/$reg.tmp
        else
            cat ~/tools/dirsearch/$reg.tmp | sort -k 1 -n > ~/tools/dirsearch/$reg.txt
            rm ~/tools/dirsearch/$reg.tmp
        fi
    done
else
  echo "${blue} [+] Installing dirsearch ${reset}"
  git clone https://github.com/maurosoria/dirsearch ~/tools/dirsearch
  wget https://raw.githubusercontent.com/v0re/dirb/master/wordlists/common.txt -P ~/tools/wordlists
  echo "${magenta} [+] Running Content Discovery ${reset}"
  for url in $(cat ~/recon/$DOM/all-alive-subs.txt);do
  reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
  python3 ~/tools/dirsearch/dirsearch.py -u $url -e php,asp,aspx,jsp,py,txt,conf,config,bak,backup,swp,old,db,zip,sql -w ~/tools/wordlists/common.txt -x 429,400,503 -f --random-agents -t 300 --max-retries=3 -b -r --plain-text-report=~/tools/dirsearch/$reg.tmp
  if [ ! -s ~/tools/dirsearch/$reg.tmp ]; then
            rm ~/tools/dirsearch/$reg.tmp
        else
            cat ~/tools/dirsearch/$reg.tmp | sort -k 1 -n > ~/tools/dirsearch/$reg.txt
            rm ~/tools/dirsearch/$reg.tmp
        fi
    done
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"

