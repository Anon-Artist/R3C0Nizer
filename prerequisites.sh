#!/bin/bash

RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
RESET=`tput sgr0`
	echo -e "\t\t\t${BLUE}
 =================================================
|   ____  _____  ____ ___  _   _ _                |
|  |  _ \|___ / / ___/ _ \| \ | (_)_______ _ __   |
|  | |_) | |_ \| |  | | | |  \| | |_  / _ \ '__|  |
|  |  _ < ___) | |__| |_| | |\  | |/ /  __/ |     |
|  |_| \_\____/ \____\___/|_| \_|_/___\___|_|     |
|                                                 |
 ================== Anon-Artist ==================
${RESET}\n"

python_install(){
    if [ ! -x "$(command -v python)" ]; then
        echo -e "${RED}[+] Python is Installing...${RESET}"
        sudo apt-get install -y python -qq > /dev/null
	echo -e "${RED}[+] Python is Installed...${RESET}"
    else   
        echo -e "${RED}[+] Python is installed...${RESET}"
    fi
}

python3_install(){
    if [ ! -x "$(command -v python3)" ]; then
        echo -e "${RED}[+] Python3 is Installing...${RESET}"
        sudo apt-get install -y python3 -qq > /dev/null
	echo -e "${RED}[+] Python3 is Installed...${RESET}"
    else   
        echo -e "${RED}[+] Python3 is installed...${RESET}"
    fi
}

go_install(){
	echo -e "${RED}[+] GO is Installing...${RESET}"
	sudo apt-get install -y golang -qq > /dev/null
	echo -e "${RED}[+] GO is Installed...${RESET}"
	echo "export PATH=$PATH:~/go/bin" | sudo tee -a ~/.bashrc
	source ~/.bashrc
}

chromium_install(){
    if [ ! -x "$(command -v chromium)" ]; then
        echo -e "${RED}[+] Chromium is Installing...${RESET}"
        sudo apt install -y chromium -qq > /dev/null
	echo -e "${RED}[+] Chromium is Installed...${RESET}"
    else
        echo -e "${RED}[+] Chromium is installed...${RESET}"
    fi
}

docker_install(){
    if [ ! -x "$(command -v docker)" ]; then
	echo -e "${RED}[+] Docker is Installing...${RESET}"   
	curl -s -L https://get.docker.com/ | bash
	echo -e "${RED}[+] Docker is Installed...${RESET}"
    else   
	echo -e "${RED}[+] Docker is installed...${RESET}"
    fi
}

dependencies_install(){
    echo -e "${RED}[+] Other Dependencies are installing...${RESET}"
    dependecies="git gcc g++ make curl python-pip python3-pip libldns-dev libpcap-dev xsltproc apt-transport-https ca-certificates gnupg-agent software-properties-common"
    for i in $dependencies; do
        sudo apt-get install -y $i -qq > /dev/null
    done
    echo -e "${RED}[+] Other Dependencies are installed...${RESET}"
}

python_install
python3_install
go_install
chromium_install
docker_install
dependencies_install

echo -e "${BLUE}\n === Happy Hacking === ${RESET}"
