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

#dnsprobe
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/dnsprobe ]
then
 echo "${magenta} [+] Running dnsprobe for resolving IP's${reset}"
 cat ~/reconizer/$DOM/Subdomains/unique.txt | dnsprobe | awk {'print $2'} | sort -u > ~/reconizer/$DOM/Port_Scan/resolved_ips.txt
else
 echo "${magenta} [+] Installing dnsprobe ${reset}"
 go get -u -v github.com/projectdiscovery/dnsprobe
 echo "${magenta} [+] Running dnsprobe for resolving IP's${reset}"
 cat ~/reconizer/$DOM/Subdomains/unique.txt | dnsprobe | awk {'print $2'} | sort -u > ~/reconizer/$DOM/Port_Scan/resolved_ips.txt
fi

#grepcidr
if [ ! -x "$(command -v grepcidr)" ]; then
	echo "${blue} [+] Installing grepcidr ${reset}"
	sudo apt-get install grepcidr
else
	echo ""
fi

#Removing IP behind Cloudflare
echo "${magenta} [+] Running grepcidr for removing hosts behind WAF${reset}"
cloudflare="173.245.48.0/20 103.21.244.0/22 103.22.200.0/22 103.31.4.0/22 141.101.64.0/18 108.162.192.0/18 190.93.240.0/20 188.114.96.0/20 197.234.240.0/22 198.41.128.0/17 162.158.0.0/15 104.16.0.0/12 172.64.0.0/13 131.0.72.0/22"
for ip in $(cat ~/reconizer/$DOM/Port_Scan/resolved_ips.txt); do
echo $ip | grepcidr "$cloudflare" >/dev/null && echo "${red} [!] $ip is protected by Cloudflare ${reset}" || echo "$ip" >> ~/reconizer/$DOM/Port_Scan/afterremovecloudflare.txt
done

#Removing IP behind Incapsula
incapsula="199.83.128.0/21 198.143.32.0/19 149.126.72.0/21 103.28.248.0/22 45.64.64.0/22 185.11.124.0/22 192.230.64.0/18 107.154.0.0/16 45.60.0.0/16 45.223.0.0/16"
for ip in $(cat ~/reconizer/$DOM/Port_Scan/afterremovecloudflare.txt); do
echo $ip | grepcidr "$incapsula" >/dev/null && echo "${red} [!] $ip is protected by Incapsula ${reset}" || echo "$ip" >> ~/reconizer/$DOM/Port_Scan/afterremoveincapsula.txt
done

#Removing IP behind Sucuri
sucuri="185.93.228.0/24 185.93.229.0/24 185.93.230.0/24 185.93.231.0/24 192.124.249.0/24 192.161.0.0/24 192.88.134.0/24 192.88.135.0/24 193.19.224.0/24 193.19.225.0/24 66.248.200.0/24 66.248.201.0/24 66.248.202.0/24 66.248.203.0/24"
for ip in $(cat ~/reconizer/$DOM/Port_Scan/afterremoveincapsula.txt); do
echo $ip | grepcidr "$sucuri" >/dev/null && echo "${red} [!] $ip is protected by Sucuri ${reset}" || echo "$ip" >> ~/reconizer/$DOM/Port_Scan/afterremovesucuri.txt
done

#Removing IP behind Akamai
akamai="104.101.221.0/24 184.51.125.0/24 184.51.154.0/24 184.51.157.0/24 184.51.33.0/24 2.16.36.0/24 2.16.37.0/24 2.22.226.0/24 2.22.227.0/24 2.22.60.0/24 23.15.12.0/24 23.15.13.0/24 23.209.105.0/24 23.62.225.0/24 23.74.29.0/24 23.79.224.0/24 23.79.225.0/24 23.79.226.0/24 23.79.227.0/24 23.79.229.0/24 23.79.230.0/24 23.79.231.0/24 23.79.232.0/24 23.79.233.0/24 23.79.235.0/24 23.79.237.0/24 23.79.238.0/24 23.79.239.0/24 63.208.195.0/24 72.246.0.0/24 72.246.1.0/24 72.246.116.0/24 72.246.199.0/24 72.246.2.0/24 72.247.150.0/24 72.247.151.0/24 72.247.216.0/24 72.247.44.0/24 72.247.45.0/24 80.67.64.0/24 80.67.65.0/24 80.67.70.0/24 80.67.73.0/24 88.221.208.0/24 88.221.209.0/24 96.6.114.0/24"
for ip in $(cat ~/reconizer/$DOM/Port_Scan/afterremovesucuri.txt); do
echo $ip | grepcidr "$akamai" >/dev/null && echo "${red} [!] $ip is protected by Akamai ${reset}" || echo "$ip" >> ~/reconizer/$DOM/Port_Scan/Final_IP_List.txt
done

#Removing Unnecassery files
rm -rf ~/reconizer/$DOM/Port_Scan/afterremovecloudflare.txt ~/reconizer/$DOM/Port_Scan/afterremoveincapsula.txt ~/reconizer/$DOM/Port_Scan/afterremovesucuri.txt

#rust scan
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Updating and running Rust Scan for scanning ports${reset}"
for url in $(cat ~/reconizer/$DOM/Port_Scan/Final_IP_List.txt);do
sudo docker run -it --rm --name rustscan cmnatic/rustscan:debian-buster rustscan $url -b 4000 -u 5000 --ports 81,161,300,591,593,832,981,1010,1311,2075,2076,2082,2087,2095,2096,2480,3000,3128,3306,3333,3366,3868,4000,4040,4044,4243,4567,4711,4712,4993,5000,5104,5108,5432,5673,5800,5900,6000,6443,6543,7000,7077,7080,7396,7443,7447,7474,8000,8001,8008,8014,8042,8069,8080,8081,8088,8089,8090,8091,8118,8181,8123,8172,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,9999,10000,12443,15672,16080,18091,18092,19000,19080,20720,28017 | tee ~/reconizer/$DOM/Port_Scan/$url.txt
done
cd ~/reconizer/$DOM/Port_Scan/
sed -i -n '/nmap.org/,$p' *.txt
find ~/reconizer/$DOM/Port_Scan/ -size 0 -delete
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
