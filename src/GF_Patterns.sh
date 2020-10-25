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

if [ -d ~/recon/$DOM/GF_Pattern ]
then
  echo " "
else
  mkdir ~/recon/$DOM/GF_Pattern

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
 cat  ~/recon/$DOM/all-alive-subs.txt | waybackurls >> ~/recon/$DOM/GF_Pattern/wayback.txt 
else
 echo "${blue} [+] Installing Waybackurls ${reset}"
 go get github.com/tomnomnom/waybackurls
 echo "${blue} [+] Started URL Fetching ${reset}"
 cat  ~/recon/$DOM/all-alive-subs.txt | waybackurls >> ~/recon/$DOM/GF_Pattern/wayback.txt 
fi
echo " "
echo "${blue} [+] Succesfully saved to wayback.txt ${reset}"
echo " "

#Gau
if [ -f ~/go/bin/gau ]
then
 echo "${magenta} [+] Running Gau ${reset}"
 cat  ~/recon/$DOM/all-alive-subs.txt | gau  >> ~/recon/$DOM/GF_Pattern/gau.txt
else
 echo "${blue} [+] Installing Gaus ${reset}"
 GO111MODULE=on go get -u -v github.com/lc/gau
 echo "${blue} [+] Started URL Fetching ${reset}"
 cat  ~/recon/$DOM/all-alive-subs.txt | gau >> ~/recon/$DOM/GF_Pattern/gau.txt
fi
echo " "
echo "${blue} [+] Succesfully saved to gau.txt ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] fetching unique URL ${reset}"
echo " "
cat ~/recon/$DOM/GF_Pattern/wayback.txt ~/recon/$DOM/GF_Pattern/gau.txt | sort -u >> ~/recon/$DOM/GF_Pattern/url.txt
echo "${blue} [+] Succesfully saved to url.txt ${reset}"
echo " "

#GFPattern
if [ -f ~/go/bin/gf ]
then
 echo "${magenta} [+] Running GF_Pattern ${reset}"
 cat  ~/recon/$DOM/GF_Pattern/url.txt | gf cors  >> ~/recon/$DOM/GF_Pattern/cors.txt
 cat  ~/recon/$DOM/GF_Pattern/url.txt | gf aws-keys  >> ~/recon/$DOM/GF_Pattern/aws-keys.txt
 cat  ~/recon/$DOM/GF_Pattern/url.txt | gf base64  >> ~/recon/$DOM/GF_Pattern/base64.txt
 cat  ~/recon/$DOM/GF_Pattern/url.txt | gf s3-buckets >> ~/recon/$DOM/GF_Pattern/s3-buckets.txt
else
 echo "${blue} [+] Installing GF_Pattern ${reset}"
 go get -u github.com/tomnomnom/gf
 #git clone https://github.com/1ndianl33t/Gf-Patterns
 mkdir ~/.gf
 sudo cp  ~/go/src/github.com/tomnomnom/gf/examples/*.json ~/.gf
 echo "${blue} [+] Started GF_Pattern ${reset}"
 cat  ~/recon/$DOM/GFPattern/url.txt | gf cors  >> ~/recon/$DOM/GF_Pattern/cors.txt
 cat  ~/recon/$DOM/GFPattern/url.txt | gf aws-keys  >> ~/recon/$DOM/GF_Pattern/aws-keys.txt
 cat  ~/recon/$DOM/GF_Pattern/url.txt | gf base64  >> ~/recon/$DOM/GF_Pattern/base64.txt
 cat  ~/recon/$DOM/GF_Pattern/url.txt | gf s3-buckets >> ~/recon/$DOM/GF_Pattern/s3-buckets.txt
fi
echo " "
echo "${blue} [+] Succesfully Finished GF_Pattern ${reset}"
echo " "
