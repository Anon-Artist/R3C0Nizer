#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter the Domain name : " DOM

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
  assetfinder -subs-only $DOM  >> ~/recon/$DOM/assetfinder.txt 
else
  echo "${blue} [+] Installing Assetfinder ${reset}"
  go get -u github.com/tomnomnom/assetfinder
  echo "${magenta} [+] Running Assetfinder ${reset}"
  assetfinder -subs-only $DOM  >> ~/recon/$DOM/assetfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved to assetfinder.txt  ${reset}"
echo " "

#amass
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/amass ]
then
  echo "${magenta} [+] Running Amass ${reset}"
  amass enum --passive -d $DOM > ~/recon/$DOM/amass.txt
else
  echo "${blue} [+] Installing Amass ${reset}"
  go get -u github.com/OWASP/Amass/...
  echo "${magenta} [+] Running Amass ${reset}"
  amass enum --passive -d $DOM > ~/recon/$DOM/amass.txt
fi
echo " "
echo "${blue} [+] Succesfully saved to amass.txt  ${reset}"
echo " "

#subfinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/subfinder ]
then
  echo "${magenta} [+] Running Subfinder ${reset}"
    subfinder -d $DOM -o ~/recon/$DOM/subfinder.txt 
else
  echo "${blue} [+] Installing Subfinder ${reset}"
  go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
  echo "${magenta} [+] Running Subfinder ${reset}"
  subfinder -d $DOM -o ~/recon/$DOM/subfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved to subfinder.txt  ${reset}"
echo " "

#find-domain
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/tools/findomain/findomain-linux ]
then
  echo "${magenta} [+] Running Findomain ${reset}"
    findomain-linux --target $DOM -u ~/recon/$DOM/findomain.txt
else
  echo "${blue} [+] Installing Findomain ${reset}"
  wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -P ~/tools/findomain/
  chmod +x ~/tools/findomain/findomain-linux
  echo "${magenta} [+] Running Findomain ${reset}"
  findomain-linux --target $DOM -u ~/recon/$DOM/findomain.txt
fi
echo " "
echo "${blue} [+] Succesfully saved to findomain.txt  ${reset}"
echo " "

#Sublister
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -d ~/tools/Sublist3r/ ]
then
  echo "${magenta} [+] Running Sublist3r ${reset}"
    python ~/tools/Sublist3r/sublist3r.py -d $DOM -t 10 -v -o ~/recon/$DOM/sublist3r.txt > /dev/null
else
  echo "${blue} [+] Installing Sublist3r ${reset}"
  echo "${magenta} [+] Running Sublist3r ${reset}"
  sudo git clone https://github.com/aboul3la/Sublist3r.git ~/tools/Sublist3r/
  python ~/tools/Sublist3r/sublist3r.py -d $DOM -t 10 -v -o ~/recon/$DOM/sublist3r.txt > /dev/null
fi
echo " "
echo "${blue} [+] Succesfully saved to sublist3r.txt  ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] fetching unique domains ${reset}"
echo " "
cat ~/recon/$DOM/assetfinder.txt ~/recon/$DOM/amass.txt ~/recon/$DOM/subfinder.txt ~/recon/$DOM/findomain.txt ~/recon/$DOM/sublist3r.txt | sort -u >> ~/recon/$DOM/unique.txt
echo "${blue} [+] Succesfully saved to unique.txt ${reset}"
echo " "

#sorting alive subdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/httpx ]
then
  echo "${magenta} [+] Sorting Alive Subdomains ${reset}"
cat ~/recon/$DOM/unique.txt | httpx >> ~/recon/$DOM/all-alive-subs.txt
else
  echo "${blue} [+] Installing Httpx ${reset}"
  go get -u github.com/projectdiscovery/httpx/cmd/httpx
  echo "${magenta} [+] Sorting Alive Subdomains ${reset}"
  cat ~/recon/$DOM/unique.txt | httpx >> ~/recon/$DOM/all-alive-subs.txt
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Successfully saved to all-alive-subs.txt"
echo " "

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
