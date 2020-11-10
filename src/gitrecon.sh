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

if [ -d ~/reconizer/$DOM/Git_Recon ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Git_Recon

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
echo "${blue} [+] Started Github Recon ${reset}"
echo " "

#github_recon
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/git-hound ]
then
  echo "${magenta} [+] Running Git-Hound for github recon ${reset}"
  echo "$DOM" | git-hound --subdomain-file ~/reconizer/$DOM/Subdomains/unique.txt | tee -a git_results.txt
else
  echo "${blue} [+] Installing Git-Hound ${reset}"
  go get github.com/tillson/git-hound
  echo "${magenta} [+] Running Git-Hound for github recon ${reset}"
  echo "$DOM" | git-hound --subdomain-file ~/reconizer/$DOM/Subdomains/unique.txt | tee -a git_results.txt
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
