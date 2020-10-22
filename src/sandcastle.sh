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

if [ -d ~/recon/$DOM/sandcastle ]
then
  echo " "
else
  mkdir ~/recon/$DOM/sandcastle

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
echo "${blue} [+] Started sandcastle ${reset}"
echo " "
#sandcastle
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -d ~/tools/sandcastle/ ]
then
  echo "${magenta} [+] Running sandcastle ${reset}"
    python ~/tools/sandcastle/sandcastle.py -t $DOM -o ~/recon/$DOM/sandcastle/sandcastle.txt
else
  echo "${blue} [+] Installing sandcastle ${reset}"
  echo "${magenta} [+] Running sandcastle ${reset}"
  git clone https://github.com/0xSearches/sandcastle ~/tools/sandcastle/
  python ~/tools/sandcastle/sandcastle.py -t $DOM -o ~/recon/$DOM/sandcastle/sandcastle.txt
fi
echo " "
echo "${blue} [+] Succesfully saved to sandcastle.txt  ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
