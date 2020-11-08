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

if [ -d ~/reconizer/$DOM/GF_Patterns ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/GF_Patterns
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
 echo "${blue} [+] Running Waybackurls ${reset}"
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
 echo "${blue} [+] Running Gau ${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | gau >> ~/reconizer/$DOM/Archivescan/gau.txt
 echo "${blue} [+] Succesfully saved as gau.txt ${reset}"
fi
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] fetching unique URL ${reset}"
echo " "
if [ -f ~/reconizer/$DOM/Archivescan/sorted.txt ]
then
 echo " "
else
 cat ~/reconizer/$DOM/Archivescan/waybackurls.txt ~/reconizer/$DOM/Archivescan/gau.txt | sort -u >> ~/reconizer/$DOM/Archivescan/sorted.txt
fi
echo " "

#GFPattern
if [ -f ~/.gf/redirect.json ]
then
 echo "${magenta} [+] Running GF_Pattern ${reset}"
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf cors  >> ~/reconizer/$DOM/GF_Pattern/cors.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf aws-keys  >> ~/reconizer/$DOM/GF_Pattern/aws-keys.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf base64  >> ~/reconizer/$DOM/GF_Pattern/base64.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf s3-buckets >> ~/reconizer/$DOM/GF_Pattern/s3-buckets.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf idor | tee -a ~/reconizer/$DOM/GF_Patterns/idor.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf lfi | tee -a ~/reconizer/$DOM/GF_Patterns/lfi.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf rce | tee -a ~/reconizer/$DOM/GF_Patterns/rce.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf redirect | tee -a ~/reconizer/$DOM/GF_Patterns/redirect.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf sqli | tee -a ~/reconizer/$DOM/GF_Patterns/sqli.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf ssrf | tee -a ~/reconizer/$DOM/GF_Patterns/ssrf.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf ssti | tee -a ~/reconizer/$DOM/GF_Patterns/ssti.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf interestingparams | tee -a ~/reconizer/$DOM/GF_Patterns/interesting_parameters.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf interestingsubs | tee -a ~/reconizer/$DOM/GF_Patterns/interesting_subs.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf xss | tee -a ~/reconizer/$DOM/GF_Patterns/xss.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf interestingEXT | tee -a ~/reconizer/$DOM/GF_Patterns/interesting_extensions.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf debug_logic | tee -a ~/reconizer/$DOM/GF_Patterns/debug_logic.txt
else
 echo "${blue} [+] Installing GF_Pattern ${reset}"
 go get -u github.com/tomnomnom/gf
 git clone https://github.com/1ndianl33t/Gf-Patterns ~/reconizer/tools/Gf-Patterns
 mkdir ~/.gf
 mv ~/reconizer/tools/Gf-Patterns/*.json ~/.gf
 cp ~/go/src/github.com/tomnomnom/gf/examples/*.json ~/.gf
 echo "${blue} [+] Started GF_Pattern ${reset}"
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf cors | tee -a ~/reconizer/$DOM/GF_Patterns/cors.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf aws-keys | tee -a ~/reconizer/$DOM/GF_Patterns/aws-keys.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf base64 | tee -a ~/reconizer/$DOM/GF_Patterns/base64.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf s3-buckets | tee -a ~/reconizer/$DOM/GF_Patterns/s3-buckets.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf idor | tee -a ~/reconizer/$DOM/GF_Patterns/idor.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf lfi | tee -a ~/reconizer/$DOM/GF_Patterns/lfi.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf rce | tee -a ~/reconizer/$DOM/GF_Patterns/rce.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf redirect | tee -a ~/reconizer/$DOM/GF_Patterns/redirect.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf sqli | tee -a ~/reconizer/$DOM/GF_Patterns/sqli.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf ssrf | tee -a ~/reconizer/$DOM/GF_Patterns/ssrf.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf ssti | tee -a ~/reconizer/$DOM/GF_Patterns/ssti.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf interestingparams | tee -a ~/reconizer/$DOM/GF_Patterns/interesting_parameters.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf interestingsubs | tee -a ~/reconizer/$DOM/GF_Patterns/interesting_subs.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf xss | tee -a ~/reconizer/$DOM/GF_Patterns/xss.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf interestingEXT | tee -a ~/reconizer/$DOM/GF_Patterns/interesting_extensions.txt
 cat  ~/reconizer/$DOM/Archivescan/sorted.txt | gf debug_logic | tee -a ~/reconizer/$DOM/GF_Patterns/debug_logic.txt
fi
echo " "
echo "${blue} [+] Succesfully Finished GF_Pattern Scan ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
