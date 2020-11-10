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

if [ -d ~/reconizer/tools ]
then
  echo " "
else
  mkdir ~/reconizer/tools 
fi

if [ -d ~/reconizer/$DOM/Archivescan ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Archivescan
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
echo "${blue} [+] Started Archive based Scanning ${reset}"
echo " "

#wayback_URL
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/waybackurls ]
then
 echo "${magenta} [+] Running Waybackurls for finding archive based assets${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | waybackurls >> ~/reconizer/$DOM/Archivescan/waybackurls.txt 
else
 echo "${blue} [+] Installing Waybackurls ${reset}"
 go get -u github.com/tomnomnom/waybackurls
 echo "${blue} [+] Running Waybackurls for finding archive based assets${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | waybackurls >> ~/reconizer/$DOM/Archivescan/waybackurls.txt 
fi
echo " "
echo "${blue} [+] Succesfully saved as waybackurls.txt ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "

#Gau
if [ -f ~/go/bin/gau ]
then
 echo "${magenta} [+] Running Gau for finding archive based assets${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | gau  >> ~/reconizer/$DOM/Archivescan/gau.txt
else
 echo "${blue} [+] Installing Gaus ${reset}"
 go get -u github.com/lc/gau
 echo "${blue} [+] Running Gau for finding archive based assets${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | gau >> ~/reconizer/$DOM/Archivescan/gau.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as gau.txt ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] fetching unique URL ${reset}"
echo " "
cat ~/reconizer/$DOM/Archivescan/waybackurls.txt ~/reconizer/$DOM/Archivescan/gau.txt | sort -u >> ~/reconizer/$DOM/Archivescan/sorted.txt
echo "${blue} [+] Succesfully saved as sorted.txt ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
