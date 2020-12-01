#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter the Domain name : " DOM

if [ -d ~/reconizer ]
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

if [ -d ~/reconizer/$DOM ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM 
fi

if [ -d ~/reconizer/$DOM/Subdomains ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Subdomains 
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
echo "${blue} [+] Started Subdomain Enumeration ${reset}"
echo " "

#assefinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/assetfinder ]
then
  echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
  assetfinder -subs-only $DOM  >> ~/reconizer/$DOM/Subdomains/assetfinder.txt 
else
  echo "${blue} [+] Installing Assetfinder ${reset}"
  go get -u github.com/tomnomnom/assetfinder
  echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
  assetfinder -subs-only $DOM  >> ~/reconizer/$DOM/Subdomains/assetfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as assetfinder.txt  ${reset}"
echo " "

#amass
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/amass ]
then
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -d $DOM > ~/reconizer/$DOM/Subdomains/amass.txt
else
  echo "${blue} [+] Installing Amass ${reset}"
  echo "${blue} [+] This may take few minutes hang tight... ${reset}"
  go get -u github.com/OWASP/Amass/...
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -d $DOM > ~/reconizer/$DOM/Subdomains/amass.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as amass.txt  ${reset}"
echo " "

#subfinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/subfinder ]
then
  echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
  subfinder -d $DOM -o ~/reconizer/$DOM/Subdomains/subfinder.txt 
else
  echo "${blue} [+] Installing Subfinder ${reset}"
  go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
  echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
  subfinder -d $DOM -o ~/reconizer/$DOM/Subdomains/subfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as subfinder.txt  ${reset}"
echo " "

#find-domain
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/findomain-linux ]
then
  echo "${magenta} [+] Running Findomain for subdomain enumeration${reset}"
    findomain-linux --target $DOM -u ~/reconizer/$DOM/Subdomains/findomain.txt
else
  echo "${blue} [+] Installing Findomain ${reset}"
  wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -P ~/go/bin/
  chmod +x ~/go/bin/findomain-linux
  echo "${magenta} [+] Running Findomain for subdomain enumeration${reset}"
  findomain-linux --target $DOM -u ~/reconizer/$DOM/Subdomains/findomain.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as findomain.txt  ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Fetching unique domains ${reset}"
echo " "
cat ~/reconizer/$DOM/Subdomains/*.txt | sort -u >> ~/reconizer/$DOM/Subdomains/unique.txt
echo "${blue} [+] Succesfully saved as unique.txt ${reset}"
echo " "

#sorting alive subdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/httpx ]
then
  echo "${magenta} [+] Running Httpx for sorting alive subdomains${reset}"
  cat ~/reconizer/$DOM/Subdomains/unique.txt | httpx >> ~/reconizer/$DOM/Subdomains/all-alive-subs.txt
  cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | sed 's/http\(.?*\)*:\/\///g' | sort -u > ~/reconizer/$DOM/Subdomains/protoless-all-alive-subs.txt
else
  echo "${blue} [+] Installing Httpx ${reset}"
  go get -u github.com/projectdiscovery/httpx/cmd/httpx
  echo "${magenta} [+] Running Httpx for sorting alive subdomains${reset}"
  cat ~/reconizer/$DOM/Subdomains/unique.txt | httpx >> ~/reconizer/$DOM/Subdomains/all-alive-subs.txt
  cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | sed 's/http\(.?*\)*:\/\///g' | sort -u > ~/reconizer/$DOM/Subdomains/protoless-all-alive-subs.txt
fi
echo " "
echo "${blue} [+] Successfully saved the results"
echo " "

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
