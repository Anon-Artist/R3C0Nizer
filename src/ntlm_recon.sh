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

if [ -d ~/recon/$DOM/ntlm_recon ]
then
  echo " "
else
  mkdir ~/recon/$DOM/ntlm_recon

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
echo "${blue} [+] Started NTLM Recon ${reset}"
echo " "
#ntlm_recon
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -d ~/tools/ntlm_recon/ ]
then
  echo "${magenta} [+] Running ntlm_recon ${reset}"
  ntlmrecon --input -d $DOM -o ~/recon/$DOM/ntlm_recon/ntlm_recon.txt
else
  echo "${blue} [+] Installing ntlm_recon ${reset}"
  echo "${magenta} [+] Running ntlm_recon ${reset}"
  pip install ntlmrecon ~/tools/ntlm_recon/
  ntlmrecon --input -d $DOM -o ~/recon/$DOM/ntlm_recon/ntlm_recon.txt
fi
echo " "
echo "${blue} [+] Succesfully saved to ntlm_recon.txt  ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
