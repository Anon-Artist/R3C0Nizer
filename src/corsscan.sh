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

if [ -d ~/reconizer/$DOM/CORS_Scan ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/CORS_Scan

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
echo "${blue} [+] Started Scanning for CORS Misconfiguration${reset}"
echo " "

#corsy
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/reconizer/tools/Corsy/corsy.py ]
then
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/reconizer/tools/Corsy/corsy.py -i ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/reconizer/$DOM/CORS_Scan/CORS_result.json
else
  echo "${blue} [+] Installing S3Scanner ${reset}"
  git clone https://github.com/s0md3v/Corsy ~/reconizer/tools/Corsy
  pip install -r ~/reconizer/tools/Corsy/requirements.txt
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/reconizer/tools/Corsy/corsy.py -i ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/reconizer/$DOM/CORS_Scan/CORS_result.json
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
