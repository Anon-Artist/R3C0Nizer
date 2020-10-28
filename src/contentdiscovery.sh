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

if [ -d ~/reconizer/$DOM/Content_Discovery ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Content_Discovery
 
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
echo "${blue} [+] Started Content Discovery Scanning ${reset}"
echo " "

#wordlist
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/reconizer/tools/common.txt ]
then
 echo " "
else
 echo "${blue} [+] Downloading wordlists ${reset}"
 wget https://raw.githubusercontent.com/v0re/dirb/master/wordlists/common.txt -P ~/reconizer/tools/
fi

#feroxbuster
if [ -f /usr/bin/feroxbuster ]
then
 echo "${magenta} [+] Running Feroxbuster ${reset}"
 for url in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);do
 reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
 feroxbuster --url $url -w ~/reconizer/tools/common.txt -x php asp aspx jsp py txt conf config bak backup swp old db zip sql --depth 3 --threads 300 --output ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt
done
else
 echo "${blue} [+] Installing Feroxbuster ${reset}"
 wget https://github.com/epi052/feroxbuster/releases/latest/download/feroxbuster_amd64.deb.zip -P ~/reconizer/tools/feroxbuster
 unzip ~/reconizer/tools/feroxbuster/feroxbuster_amd64.deb.zip -d ~/reconizer/tools/feroxbuster 
 sudo apt install ~/reconizer/tools/feroxbuster/*.deb
 echo "${magenta} [+] Running Feroxbuster ${reset}"
 for url in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);do
 reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
 feroxbuster --url $url -w ~/reconizer/tools/common.txt -x php asp aspx jsp py txt conf config bak backup swp old db zip sql --depth 3 --threads 300 --output ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved as content_discovery_result.txt ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Sorting According to Status Codes ${reset}"
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 200 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_200.txt  
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 204 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_204.txt
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 301 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_301.txt
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 302 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_302.txt
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 307 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_307.txt
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 308 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_308.txt
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 401 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_401.txt
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 403 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_403.txt
cat ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt | grep 405 | awk '{print $2}' > ~/reconizer/$DOM/Content_Discovery/status_code_405.txt
echo " "
echo "${blue} [+] Succesfully saved according to status codes ${reset}"
echo " "
done
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"

