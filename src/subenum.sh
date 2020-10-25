#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter the Domain name : " DOM

if [ -d ~/reconizer/tools ]
then
  echo " "
else
  mkdir ~/reconizer/tools 
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
echo "${blue} [+] Started Subdomain Discovery ${reset}"
echo " "

#assefinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/assetfinder ]
then
  echo "${magenta} [+] Running Assetfinder ${reset}"
  assetfinder -subs-only $DOM  >> ~/reconizer/$DOM/Subdomains/assetfinder.txt 
else
  echo "${blue} [+] Installing Assetfinder ${reset}"
  go get -u github.com/tomnomnom/assetfinder
  echo "${magenta} [+] Running Assetfinder ${reset}"
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
  echo "${magenta} [+] Running Amass ${reset}"
  amass enum --passive -d $DOM > ~/reconizer/$DOM/Subdomains/amass.txt
else
  echo "${blue} [+] Installing Amass ${reset}"
  go get -u github.com/OWASP/Amass/...
  echo "${magenta} [+] Running Amass ${reset}"
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
  echo "${magenta} [+] Running Subfinder ${reset}"
  subfinder -d $DOM -o ~/reconizer/$DOM/Subdomains/subfinder.txt 
else
  echo "${blue} [+] Installing Subfinder ${reset}"
  go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
  echo "${magenta} [+] Running Subfinder ${reset}"
  subfinder -d $DOM -o ~/reconizer/$DOM/Subdomains/subfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as subfinder.txt  ${reset}"
echo " "

#find-domain
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/reconizer/tools/findomain/findomain-linux ]
then
  echo "${magenta} [+] Running Findomain ${reset}"
    findomain-linux --target $DOM -u ~/reconizer/$DOM/Subdomains/findomain.txt
else
  echo "${blue} [+] Installing Findomain ${reset}"
  wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -P ~/reconizer/tools/findomain/
  chmod +x ~/reconizer/tools/findomain/findomain-linux
  echo "${magenta} [+] Running Findomain ${reset}"
  findomain-linux --target $DOM -u ~/reconizer/$DOM/Subdomains/findomain.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as findomain.txt  ${reset}"
echo " "

#Sublister
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -d ~/reconizer/tools/Sublist3r/ ]
then
  echo "${magenta} [+] Running Sublist3r ${reset}"
  python ~/reconizer/tools/Sublist3r/sublist3r.py -d $DOM -t 10 -v -o ~/reconizer/$DOM/Subdomains/sublist3r.txt > /dev/null
else
  echo "${blue} [+] Installing Sublist3r ${reset}"
  echo "${magenta} [+] Running Sublist3r ${reset}"
  git clone https://github.com/aboul3la/Sublist3r.git ~/reconizer/tools/Sublist3r/
  python ~/reconizer/tools/Sublist3r/sublist3r.py -d $DOM -t 10 -v -o ~/reconizer/$DOM/Subdomains/sublist3r.txt > /dev/null
fi
echo " "
echo "${blue} [+] Succesfully saved as sublist3r.txt  ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Fetching unique domains ${reset}"
echo " "
cat ~/reconizer/$DOM/Subdomains/assetfinder.txt ~/reconizer/$DOM/Subdomains/amass.txt ~/reconizer/$DOM/Subdomains/subfinder.txt ~/reconizer/$DOM/Subdomains/findomain.txt ~/reconizer/$DOM/Subdomains/sublist3r.txt | sort -u >> ~/reconizer/$DOM/Subdomains/unique.txt
echo "${blue} [+] Succesfully saved as unique.txt ${reset}"
echo " "

#sorting alive subdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/httpx ]
then
  echo "${magenta} [+] Sorting Alive Subdomains ${reset}"
cat ~/reconizer/$DOM/Subdomains/unique.txt | httpx >> ~/reconizer/$DOM/Subdomains/all-alive-subs.txt
else
  echo "${blue} [+] Installing Httpx ${reset}"
  go get -u github.com/projectdiscovery/httpx/cmd/httpx
  echo "${magenta} [+] Sorting Alive Subdomains ${reset}"
  cat ~/reconizer/$DOM/Subdomains/unique.txt | httpx >> ~/reconizer/$DOM/Subdomains/all-alive-subs.txt
fi
echo " "
echo "${blue} [+] Successfully saved as all-alive-subs.txt"
echo " "

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
