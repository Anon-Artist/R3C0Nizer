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

if [ -d ~/reconizer/$DOM/Archivescan ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Archivescan
fi

if [ -d ~/reconizer/$DOM/JSscan ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/JSscan
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
echo "${blue} [+] Started URL Fetching ${reset}"
echo " "


#wayback_URL
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/waybackurls ] 
then
 echo "${magenta} [+] Already installed Waybackurls ${reset}"
else
 echo "${blue} [+] Installing Waybackurls ${reset}"
 go get -u github.com/tomnomnom/waybackurls
fi
echo " "
if [ -f ~/reconizer/$DOM/Archivescan/waybackurls.txt]
then
 echo "${magenta} [+] Already done Waybackurls ${reset}"
else
 echo "${blue} [+] Running Waybackurls for finding archive based assets${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | waybackurls >> ~/reconizer/$DOM/Archivescan/waybackurls.txt 
 echo "${blue} [+] Succesfully saved as waybackurls.txt ${reset}"
fi
echo " "

#Gau
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/gau ]
then
 echo "${magenta} [+] Already installed Gau ${reset}"
else
 echo "${blue} [+] Installing Gau ${reset}"
 go get -u github.com/lc/gau
fi
echo " "
if [~/reconizer/$DOM/Archivescan/gau.txt ]
then
 echo "${magenta} [+] Already done Gau ${reset}"
else
 echo "${blue} [+] Running Gau for finding archive based assets${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | gau >> ~/reconizer/$DOM/Archivescan/gau.txt
 echo "${blue} [+] Succesfully saved as gau.txt ${reset}"
fi
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/reconizer/$DOM/Archivescan/sorted.txt ]
then
 echo " "
else
 cat ~/reconizer/$DOM/Archivescan/waybackurls.txt ~/reconizer/$DOM/Archivescan/gau.txt | sort -u >> ~/reconizer/$DOM/Archivescan/sorted.txt
 echo "${blue} [+] Succesfully saved as sorted.txt ${reset}"
 echo " "
fi

#Gathering Js Files
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Checking for dependencies ${reset}"
if [ -f ~/go/bin/httpx ]
  echo "${blue} [+] Installing httpx ${reset}"
  go get -u github.com/projectdiscovery/httpx/cmd/httpx
else
  echo "${magenta} [+] Already installed httpx ${reset}"
fi
if [ -f ~/go/bin/anew ]
  echo "${blue} [+] Installing anew ${reset}"
  go get -u github.com/tomnomnom/anew
else
  echo "${magenta} [+] Already installed anew ${reset}"
fi
if [ -f ~/go/bin/subjs ]
  echo "${blue} [+] Installing subjs ${reset}"
  go get -u github.com/lc/subjs
else
  echo "${magenta} [+] Already installed subjs ${reset}"
fi

echo " "
echo "${blue} [+] Started Gathering Live JsFiles-links ${reset}"
echo " "
cat ~/reconizer/$DOM/Archivescan/sorted.txt | grep -iE "\.js$" | uniq | sort >> ~/reconizer/$DOM/JSscan/mixed_jsfile_links_from_archives.txt
cat ~/reconizer/$DOM/JSscan/mixed_jsfile_links_from_archives.txt | httpx -silent >> ~/reconizer/$DOM/JSscan/jsfile_links_from_archives.txt
cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | httpx -silent | subjs | anew | tee -a ~/reconizer/$DOM/JSscan/jsfile_links_from_subjs.txt
rm -rf ~/reconizer/$DOM/JSscan/mixed_jsfile_links_from_archives.txt
cat ~/reconizer/$DOM/JSscan/jsfile_links_from_archives.txt ~/reconizer/$DOM/JSscan/jsfile_links_from_subjs.txt | sort -u jsfiles_result.txt

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
