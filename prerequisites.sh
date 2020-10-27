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

go_install(){
    if [ ! -x "$(command -v go)" ]; then
	echo -e "${RED}[+] Downloading latest Go...${RESET}"
	url="$(wget -qO- https://golang.org/dl/ | grep -oP 'https:\/\/dl\.google\.com\/go\/go([0-9\.]+)\.linux-amd64\.tar\.gz' | head -n 1 )"
	wget --quiet --continue --show-progress "${url}"
	unset url  
    else   
        echo -e "${RED}[+] GO is already installed...${RESET}"
    fi
}

python_install(){
    if [ ! -x "$(command -v python)" ]; then
        sudo apt-get install -y python
    else   
        echo -e "${RED}[+] Python is already installed...${RESET}"
    fi
}

python3_install(){
    if [ ! -x "$(command -v python3)" ]; then
        sudo apt-get install -y python3
    else   
        echo -e "${RED}[+] Python3 is already installed...${RESET}"
    fi
}

chromium_install(){
    if [ ! -x "$(command -v chromium-browser || chromium )" ]; then
    if [ "ubuntu" == "$(cat /etc/os-release | grep ^ID= | cut -d '=' -f2)" ]; then
        sudo add-apt-repository ppa:canonical-chromium-builds/stage -y
        sudo apt update -y
        sudo apt install -y chromium-browser
    else
        sudo apt install -y chromium
    fi
    else
        echo -e "${RED}[+] Chromium is already installed...${RESET}"
    fi
}

docker_install(){
    if [ ! -x "$(command -v docker)" ]; then
	sudo chmod +x /src/docker_install.sh       
	bash /src/docker_install.sh
    else   
        echo -e "${RED}[+] Docker is already installed...${RESET}"
    fi
}

fewmoretools_install(){
    few="git gcc g++ make curl"
    for i in $few; do
    if [ ! -x "$(command -v $few)" ]; then
        sudo apt-get install -y $i -qq > /dev/null
    else   
        echo -e "${RED}[+] All tools are already installed...${RESET}"
    fi
    done
    echo -e "${RED}[+] All tools are already installed...${RESET}"
}

dependencies_install(){
    dependecies="python-pip python3-pip libldns-dev libpcap-dev xsltproc apt-transport-https ca-certificates gnupg-agent software-properties-common"
    for i in $dependencies; do
        sudo apt-get install -y $i -qq > /dev/null
    done
    echo -e "${RED}[+] All Dependencies are already installed...${RESET}"
}

update
go_install
python_install
python3_install
chromium_install
docker_install
fewmoretools_install
dependencies_install

echo -e "${BLUE}\n === Happy Hacking === ${RESET}"
