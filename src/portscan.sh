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

if [ -d ~/reconizer/$DOM ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM
fi
 
if [ -d ~/reconizer/$DOM/Port_Scan ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Port_Scan
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
echo "${blue} [+] Started Port Scanning ${reset}"
echo " "
 
#nuclei
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Running Rust Scan ${reset}"
for url in $(cat ~/reconizer/$DOM/Subdomains/unique.txt);do
sudo docker run -it --rm --name rustscan rustscan/rustscan:1.10.0 $url -b 4000 -u 5000 --ports  2075,2076,6443,3868,3366,8443,8080,9443,9091,3000,8000,5900,8081,6000,10000,8181,3306,5000,4000,8888,5432,15672,9999,161,4044,7077,4040,9000,8089,7447,7080,8880,8983,5673,7443,19000,19080,9200  | tee ~/reconizer/$DOM/Port_Scan/$url.txt
done
cd ~/reconizer/$DOM/Port_Scan/
sed -i -n '/Starting Nmap/,$p' *.txt
find ~/reconizer/$DOM/Port_Scan/ -size 0 -delete
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
