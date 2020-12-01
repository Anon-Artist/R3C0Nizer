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

if [ -d ~/reconizer/$DOM/S3_Bucket_Recon ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/S3_Bucket_Recon

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
echo "${blue} [+] Started S3 Bucket Recon ${reset}"
echo " "

#screenshotting
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/reconizer/tools/S3Scanner/s3scanner.py ]
then
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python ~/reconizer/tools/S3Scanner/s3scanner.py ~/reconizer/$DOM/Subdomains/protoless-all-alive-subs.txt &> ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt
  cat ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt | grep "\[found\]" | cut -d" "  -f9- | tee -a ~/reconizer/$DOM/S3_Bucket_Recon/s3_result.txt
  rm -rf ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt
else
  echo "${blue} [+] Installing S3Scanner ${reset}"
  git clone https://github.com/sa7mon/S3Scanner ~/reconizer/tools/S3Scanner
  pip install -r ~/reconizer/tools/S3Scanner/requirements.txt
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python ~/reconizer/tools/S3Scanner/s3scanner.py ~/reconizer/$DOM/Subdomains/protoless-all-alive-subs.txt &> ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt
  cat ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt | grep "\[found\]" | cut -d" "  -f9- | tee -a ~/reconizer/$DOM/S3_Bucket_Recon/s3_result.txt
  rm -rf ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt
fi

echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
