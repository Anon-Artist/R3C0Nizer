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

if [ -d ~/reconizer/$DOM/Broken_Links ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Broken_Links
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
echo "${blue} [+] Started Scanning for Broken Links ${reset}"
echo " "

#blc
if [ -f /usr/local/bin/blc ]
then
  echo "${magenta} [+] Running BLC for checking Broken links ${reset}"
  for domains in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);
  do
  blc $domains -ro > ~/reconizer/$DOM/Broken_Links/blc.txt && cat ~/reconizer/$DOM/Broken_Links/blc.txt | grep BROKEN > ~/reconizer/$DOM/Broken_Links/Broken_Links.txt
  done
else
  echo "${blue} [+] Installing BLC ${reset}"
  sudo apt-get install npm
  npm install broken-link-checker -g
  echo "${magenta} [+] Running BLC for checking Broken links${reset}"
  for domains in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);
  do
  blc $domains -ro > ~/reconizer/$DOM/Broken_Links/blc.txt && cat ~/reconizer/$DOM/Broken_Links/blc.txt | grep BROKEN > ~/reconizer/$DOM/Broken_Links/Broken_Links.txt
  done
fi

echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
