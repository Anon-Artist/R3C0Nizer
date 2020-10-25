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

if [ -d ~/reconizer/$DOM/Param_mining ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Param_mining
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
echo "${blue} [+] Started Param Mining ${reset}"
echo " "
#ParamSpider
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -d ~/reconizer/tools/ParamSpider/ ]
then
  echo "${magenta} [+] Running ParamSpider ${reset}"
    python3 ~/tools/ParamSpider/paramspider.py -d $DOM -o ~/reconizer/$DOM/Param_mining/paramspider.txt
else
  echo "${blue} [+] Installing ParamSpider ${reset}"
  echo "${magenta} [+] Running ParamSpider ${reset}"
  sudo git clone https://github.com/devanshbatham/ParamSpider ~/reconizer/tools/ParamSpider/
  python3 ~/tools/ParamSpider/paramspider.py -d $DOM -o ~/reconizer/$DOM/Param_mining/paramspider.txt
fi
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved as paramspider.txt  ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
