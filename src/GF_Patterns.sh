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

if [ -d ~/reconizer/$DOM/GF_Pattern ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/GF_Pattern
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
 echo "${magenta} [+] Running Waybackurls ${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | waybackurls >> ~/reconizer/$DOM/GF_Pattern/waybackurls.txt 
else
 echo "${blue} [+] Installing Waybackurls ${reset}"
 go get -u github.com/tomnomnom/waybackurls
 echo "${blue} [+] Started URL Fetching ${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | waybackurls >> ~/reconizer/$DOM/GF_Pattern/waybackurls.txt 
fi
echo " "
echo "${blue} [+] Succesfully saved as waybackurls.txt ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
#Gau
if [ -f ~/go/bin/gau ]
then
 echo "${magenta} [+] Running Gau ${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | gau  >> ~/reconizer/$DOM/GF_Pattern/gau.txt
else
 echo "${blue} [+] Installing Gaus ${reset}"
 go get -u github.com/lc/gau
 echo "${blue} [+] Started URL Fetching ${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | gau >> ~/reconizer/$DOM/GF_Pattern/gau.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as gau.txt ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] fetching unique URL ${reset}"
echo " "
cat ~/reconizer/$DOM/GF_Pattern/wayback.txt ~/reconizer/$DOM/GF_Pattern/gau.txt | sort -u >> ~/reconizer/$DOM/GF_Pattern/sorted.txt
echo "${blue} [+] Succesfully saved as sorted.txt ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "

#GFPattern
if [ -f ~/go/bin/gf ]
then
 echo "${magenta} [+] Running GF_Pattern ${reset}"
 cat  ~/reconizer/$DOM/GF_Pattern/sorted.txt | gf cors  >> ~/reconizer/$DOM/GF_Pattern/cors.txt
 cat  ~/reconizer/$DOM/GF_Pattern/sorted.txt | gf aws-keys  >> ~/reconizer/$DOM/GF_Pattern/aws-keys.txt
 cat  ~/reconizer/$DOM/GF_Pattern/sorted.txt | gf base64  >> ~/reconizer/$DOM/GF_Pattern/base64.txt
 cat  ~/reconizer/$DOM/GF_Pattern/sorted.txt | gf s3-buckets >> ~/reconizer/$DOM/GF_Pattern/s3-buckets.txt
else
 echo "${blue} [+] Installing GF_Pattern ${reset}"
 go get -u github.com/tomnomnom/gf
 #git clone https://github.com/1ndianl33t/Gf-Patterns
 mkdir ~/.gf
 sudo cp ~/go/src/github.com/tomnomnom/gf/examples/*.json ~/.gf
 echo "${blue} [+] Started GF_Pattern ${reset}"
 cat  ~/reconizer/$DOM/GF_Pattern/sorted.txt | gf cors  >> ~/reconizer/$DOM/GF_Pattern/cors.txt
 cat  ~/reconizer/$DOM/GF_Pattern/sorted.txt | gf aws-keys  >> ~/reconizer/$DOM/GF_Pattern/aws-keys.txt
 cat  ~/reconizer/$DOM/GF_Pattern/sorted.txt | gf base64  >> ~/reconizer/$DOM/GF_Pattern/base64.txt
 cat  ~/reconizer/$DOM/GF_Pattern/sorted.txt | gf s3-buckets >> ~/reconizer/$DOM/GF_Pattern/s3-buckets.txt
fi
echo " "
echo "${blue} [+] Succesfully Finished GF_Pattern ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
