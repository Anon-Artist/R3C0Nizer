#!/bin/bash

#colors
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
magenta=`tput setaf 5`
reset=`tput sgr0`

read -p "Enter the Domain name : " DOM

if [ -d ~/reconizer ]
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
if [ -d ~/reconizer/$DOM/Subdomains ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Subdomains 
fi
if [ -d ~/reconizer/$DOM/Subdomain_takeovers ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Subdomain_takeovers
fi
if [ -d ~/reconizer/$DOM/nuclei ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/nuclei
fi
if [ -d ~/reconizer/$DOM/Broken_Links ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Broken_Links
fi
if [ -d ~/reconizer/$DOM/Port_Scan ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Port_Scan
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
if [ -d ~/reconizer/$DOM/JSscan ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/JSscan
fi
if [ -d ~/reconizer/$DOM/S3_Bucket_Recon ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/S3_Bucket_Recon
fi
if [ -d ~/reconizer/$DOM/CORS_Scan ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/CORS_Scan
fi
if [ -d ~/reconizer/$DOM/Param_mining ]
then
  echo " "
else
  mkdir ~/reconizer/$DOM/Param_mining
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
echo "${blue} [+] Started Subdomain Enumeration ${reset}"
echo " "

#assefinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/assetfinder ]
then
  echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
  assetfinder -subs-only $DOM  >> ~/reconizer/$DOM/Subdomains/assetfinder.txt 
else
  echo "${blue} [+] Installing Assetfinder ${reset}"
  go get -u github.com/tomnomnom/assetfinder
  echo "${magenta} [+] Running Assetfinder for subdomain enumeration${reset}"
  assetfinder -subs-only $DOM  >> ~/reconizer/$DOM/Subdomains/assetfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as assetfinder.txt  ${reset}"
echo " "

#amass
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/amass ]
then
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -d $DOM > ~/reconizer/$DOM/Subdomains/amass.txt
else
  echo "${blue} [+] Installing Amass ${reset}"
  echo "${blue} [+] This may take few minutes hang tight... ${reset}"
  go get -u github.com/OWASP/Amass/...
  echo "${magenta} [+] Running Amass for subdomain enumeration${reset}"
  amass enum --passive -d $DOM > ~/reconizer/$DOM/Subdomains/amass.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as amass.txt  ${reset}"
echo " "

#subfinder
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/subfinder ]
then
  echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
  subfinder -d $DOM -o ~/reconizer/$DOM/Subdomains/subfinder.txt 
else
  echo "${blue} [+] Installing Subfinder ${reset}"
  go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
  echo "${magenta} [+] Running Subfinder for subdomain enumeration${reset}"
  subfinder -d $DOM -o ~/reconizer/$DOM/Subdomains/subfinder.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as subfinder.txt  ${reset}"
echo " "

#find-domain
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/findomain-linux ]
then
  echo "${magenta} [+] Running Findomain for subdomain enumeration${reset}"
    findomain-linux --target $DOM -u ~/reconizer/$DOM/Subdomains/findomain.txt
else
  echo "${blue} [+] Installing Findomain ${reset}"
  wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -P ~/go/bin/
  chmod +x ~/go/bin/findomain-linux
  echo "${magenta} [+] Running Findomain for subdomain enumeration${reset}"
  findomain-linux --target $DOM -u ~/reconizer/$DOM/Subdomains/findomain.txt
fi
echo " "
echo "${blue} [+] Succesfully saved as findomain.txt  ${reset}"
echo " "

#Sublister
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -d ~/reconizer/tools/Sublist3r/ ]
then
  echo "${magenta} [+] Running Sublist3r for subdomain enumeration${reset}"
  python ~/reconizer/tools/Sublist3r/sublist3r.py -d $DOM -t 10 -v -o ~/reconizer/$DOM/Subdomains/sublist3r.txt > /dev/null
else
  echo "${blue} [+] Installing Sublist3r ${reset}"
  echo "${magenta} [+] Running Sublist3r for subdomain enumeration${reset}"
  git clone https://github.com/aboul3la/Sublist3r.git ~/reconizer/tools/Sublist3r/
  python ~/reconizer/tools/Sublist3r/sublist3r.py -d $DOM -t 10 -v -o ~/reconizer/$DOM/Subdomains/sublist3r.txt > /dev/null
fi
echo " "
echo "${blue} [+] Succesfully saved as sublist3r.txt  ${reset}"
echo " "

#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Fetching unique domains ${reset}"
echo " "
cat ~/reconizer/$DOM/Subdomains/*.txt | sort -u >> ~/reconizer/$DOM/Subdomains/unique.txt
echo "${blue} [+] Succesfully saved as unique.txt ${reset}"
echo " "

#sorting alive subdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/httpx ]
then
  echo "${magenta} [+] Running Httpx for sorting alive subdomains${reset}"
  cat ~/reconizer/$DOM/Subdomains/unique.txt | httpx >> ~/reconizer/$DOM/Subdomains/all-alive-subs.txt
  cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | sed 's/http\(.?*\)*:\/\///g' | sort -u > ~/reconizer/$DOM/Subdomains/protoless-all-alive-subs.txt
else
  echo "${blue} [+] Installing Httpx ${reset}"
  go get -u github.com/projectdiscovery/httpx/cmd/httpx
  echo "${magenta} [+] Running Httpx for sorting alive subdomains${reset}"
  cat ~/reconizer/$DOM/Subdomains/unique.txt | httpx >> ~/reconizer/$DOM/Subdomains/all-alive-subs.txt
  cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | sed 's/http\(.?*\)*:\/\///g' | sort -u > ~/reconizer/$DOM/Subdomains/protoless-all-alive-subs.txt
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Successfully saved the results.txt"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
#nuclei
echo " "
if [ -f ~/go/bin/nuclei ]
then
  echo "${magenta} [+] Running nuclei for finding potential takeovers${reset}"
  nuclei -update-templates
  nuclei -l ~/reconizer/$DOM/Subdomains/unique.txt -t ~/nuclei-templates/subdomain-takeover/ -o ~/reconizer/$DOM/Subdomain_takeovers/takeover_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  go get -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  echo "${magenta} [+] Running nuclei for finding potential takeovers${reset}"
  nuclei -update-templates
  nuclei -l ~/reconizer/$DOM/Subdomains/unique.txt -t ~/nuclei-templates/subdomain-takeover/ -o ~/reconizer/$DOM/Subdomain_takeovers/takeover_results.txt
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Successfully saved the results.txt"
echo " "
#nuclei
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/go/bin/nuclei ]
then
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/reconizer/$DOM/nuclei/cves_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/reconizer/$DOM/nuclei/files_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/reconizer/$DOM/nuclei/vulnerabilities_results.txt
else
  echo "${blue} [+] Installing nuclei ${reset}"
  go get -u github.com/projectdiscovery/nuclei/v2/cmd/nuclei
  echo "${magenta} [+] Running nuclei ${reset}"
  nuclei -update-templates
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/cves/ -c 200 -o ~/reconizer/$DOM/nuclei/cves_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/files/ -c 200 -o ~/reconizer/$DOM/nuclei/files_results.txt
  nuclei -l ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t ~/nuclei-templates/vulnerabilities/ -c 200 -o ~/reconizer/$DOM/nuclei/vulnerabilities_results.txt
fi
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
#blc
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
if [ -f /usr/local/bin/blc ]
then
  echo "${magenta} [+] Running BLC for checking Broken links ${reset}"
  for domains in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);
  do
  blc $domains -ro > ~/reconizer/$DOM/Broken_Links/blc.txt && cat ~/reconizer/$DOM/Broken_Links/blc.txt | grep BROKEN > ~/reconizer/$DOM/Broken_Links/Broken_Links.txt
  done
else
  echo "${blue} [+] Installing BLC ${reset}"
  npm install broken-link-checker -g
  echo "${magenta} [+] Running BLC for checking Broken links${reset}"
  for domains in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);
  do
  blc $domains -ro > ~/reconizer/$DOM/Broken_Links/blc.txt && cat ~/reconizer/$DOM/Broken_Links/blc.txt | grep BROKEN > ~/reconizer/$DOM/Broken_Links/Broken_Links.txt
  done
fi
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results ${reset}"
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
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ ! -x "$(command -v grepcidr)" ]; then
	echo "${blue} [+] Installing grepcidr ${reset}"
	sudo apt-get install grepcidr
	echo " "
else
	echo "${blue} [+] grepcidr is already installed ${reset}"
fi
#Removing IP behind Cloudflare
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
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
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${magenta} [+] Updating and running Rust Scan for scanning ports${reset}"
for url in $(cat ~/reconizer/$DOM/Port_Scan/Final_IP_List.txt);do
sudo docker run -it --rm --name rustscan rustscan/rustscan:2.0.0 -a $url -b 4000 -u 5000 -p 81,161,300,591,593,832,981,1010,1311,2075,2076,2082,2087,2095,2096,2480,3000,3128,3306,3333,3366,3868,4000,4040,4044,4243,4567,4711,4712,4993,5000,5104,5108,5432,5673,5800,5900,6000,6443,6543,7000,7077,7080,7396,7443,7447,7474,8000,8001,8008,8014,8042,8069,8080,8081,8088,8089,8090,8091,8118,8181,8123,8172,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,9999,10000,12443,15672,16080,18091,18092,19000,19080,20720,28017 | tee ~/reconizer/$DOM/Port_Scan/$url.txt
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
 echo "${blue} [+] Running Waybackurls for finding archive based assets${reset}"
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
 echo "${blue} [+] Running Gau for finding archive based assets${reset}"
 cat  ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | gau >> ~/reconizer/$DOM/Archivescan/gau.txt
 echo "${blue} [+] Succesfully saved as gau.txt ${reset}"
fi
echo " "
#uniquesubdomains
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/reconizer/$DOM/Archivescan/sorted.txt ]
then
 echo " "
else
 cat ~/reconizer/$DOM/Archivescan/waybackurls.txt ~/reconizer/$DOM/Archivescan/gau.txt | sort -u >> ~/reconizer/$DOM/Archivescan/sorted.txt
 echo "${blue} [+] Succesfully saved as sorted.txt ${reset}"
 echo " "
fi
#GFPattern
if [ -f ~/.gf/redirect.json ]
then
 echo "${magenta} [+] Running GF for pattern based scanning${reset}"
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
 echo "${blue} [+] Installing GF_Patterns ${reset}"
 go get -u github.com/tomnomnom/gf
 git clone https://github.com/1ndianl33t/Gf-Patterns ~/reconizer/tools/Gf-Patterns
 mkdir ~/.gf
 mv ~/reconizer/tools/Gf-Patterns/*.json ~/.gf
 cp ~/go/src/github.com/tomnomnom/gf/examples/*.json ~/.gf
 echo "${blue} [+] Started GF for pattern based scanning${reset}"
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
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
#Gathering Js Files
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Checking for dependencies ${reset}"
if [ -f ~/go/bin/httpx ]
  echo "${blue} [+] Installing httpx ${reset}"
  go get -u github.com/projectdiscovery/httpx/cmd/httpx
else
  echo "${magenta} [+] Already installed httpx ${reset}"
fi
if [ -f ~/go/bin/anew ]
  echo "${blue} [+] Installing anew ${reset}"
  go get -u github.com/tomnomnom/anew
else
  echo "${magenta} [+] Already installed anew ${reset}"
fi
if [ -f ~/go/bin/subjs ]
  echo "${blue} [+] Installing subjs ${reset}"
  go get -u github.com/lc/subjs
else
  echo "${magenta} [+] Already installed subjs ${reset}"
fi
echo " "
echo "${blue} [+] Started Gathering Live JsFiles-links ${reset}"
echo " "
cat ~/reconizer/$DOM/Archivescan/sorted.txt | grep -iE "\.js$" | uniq | sort >> ~/reconizer/$DOM/JSscan/mixed_jsfile_links_from_archives.txt
cat ~/reconizer/$DOM/JSscan/mixed_jsfile_links_from_archives.txt | httpx -silent >> ~/reconizer/$DOM/JSscan/jsfile_links_from_archives.txt
cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt | httpx -silent | subjs | anew | tee -a ~/reconizer/$DOM/JSscan/jsfile_links_from_subjs.txt
rm -rf ~/reconizer/$DOM/JSscan/mixed_jsfile_links_from_archives.txt
cat ~/reconizer/$DOM/JSscan/jsfile_links_from_archives.txt ~/reconizer/$DOM/JSscan/jsfile_links_from_subjs.txt | sort -u jsfiles_result.txt
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results${reset}"
echo " "
#s3scanner
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/reconizer/tools/S3Scanner/s3scanner.py ]
then
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/reconizer/tools/S3Scanner/s3scanner.py ~/reconizer/$DOM/Subdomains/protoless-all-alive-subs.txt &> ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt
  cat ~/recon/$1/$1-s3scanner.txt | grep "\[found\]" | cut -d" "  -f9- | tee -a ~/reconizer/bentley.com/S3_Bucket_Recon/s3_result.txt
  rm -rf ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt
else
  echo "${blue} [+] Installing S3Scanner ${reset}"
  git clone https://github.com/sa7mon/S3Scanner ~/reconizer/tools/S3Scanner
  pip install -r ~/reconizer/tools/S3Scanner/requirements.txt
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/reconizer/tools/S3Scanner/s3scanner.py ~/reconizer/$DOM/Subdomains/protoless-all-alive-subs.txt &> ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt
  cat ~/recon/$1/$1-s3scanner.txt | grep "\[found\]" | cut -d" "  -f9- | tee -a ~/reconizer/bentley.com/S3_Bucket_Recon/s3_result.txt
  rm -rf ~/reconizer/$DOM/S3_Bucket_Recon/s3_temp_result.txt
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
#corsy
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -f ~/reconizer/tools/Corsy/corsy.py ]
then
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/reconizer/tools/Corsy/corsy.py -i ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/reconizer/$DOM/CORS_Scan/CORS_result.json
else
  echo "${blue} [+] Installing S3Scanner ${reset}"
  git clone https://github.com/s0md3v/Corsy ~/reconizer/tools/Corsy
  pip install -r ~/reconizer/tools/Corsy/requirements.txt
  echo "${magenta} [+] Running S3Scanner for S3 Bucket Enumeration${reset}"
  python3 ~/reconizer/tools/Corsy/corsy.py -i ~/reconizer/$DOM/Subdomains/all-alive-subs.txt -t 25 -o ~/reconizer/$DOM/CORS_Scan/CORS_result.json
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo ""
echo "${blue} [+] Successfully saved the results"
echo ""
#ParamSpider
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
if [ -d ~/reconizer/tools/ParamSpider/ ]
then
  echo "${magenta} [+] Running ParamSpider for mining endpoints${reset}"
  for url in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);do
  python3 ~/reconizer/tools/ParamSpider/paramspider.py -d $url -o ~/reconizer/$DOM/Param_mining/$url.txt
  done
else
  echo "${blue} [+] Installing ParamSpider ${reset}"
  git clone https://github.com/devanshbatham/ParamSpider ~/reconizer/tools/ParamSpider/
  echo "${magenta} [+] Running ParamSpider for mining endpoints${reset}"
  for url in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);do
  python3 ~/reconizer/tools/ParamSpider/paramspider.py -d $url -o ~/reconizer/$DOM/Param_mining/$url.txt
  done
fi
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved the results  ${reset}"
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
if [ -f ~/go/bin/feroxbuster ]
then
 echo "${magenta} [+] Running Feroxbuster for content discovery${reset}"
 for url in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);do
 reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
 feroxbuster --url $url -w ~/reconizer/tools/common.txt -x php asp aspx jsp py txt conf config bak backup swp old db zip sql --depth 3 --threads 300 --output ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt
done
else
 echo "${blue} [+] Installing Feroxbuster ${reset}"
 wget https://github.com/epi052/feroxbuster/releases/download/v1.5.2/x86_64-linux-feroxbuster.zip -P ~/reconizer/tools/feroxbuster
 unzip ~/reconizer/tools/feroxbuster/x86_64-linux-feroxbuster.zip -d ~/go/bin/
 chmod 777 ~/go/bin/feroxbuster
 echo "${magenta} [+] Running Feroxbuster for content discovery${reset}"
 for url in $(cat ~/reconizer/$DOM/Subdomains/all-alive-subs.txt);do
 reg=$(echo $url | sed -e 's;https\?://;;' | sed -e 's;/.*$;;')
 feroxbuster --url $url -w ~/reconizer/tools/common.txt -x php asp aspx jsp py txt conf config bak backup swp old db zip sql --depth 3 --threads 300 --output ~/reconizer/$DOM/Content_Discovery/content_discovery_result.txt
done
fi
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
echo " "
echo "${blue} [+] Succesfully saved as content_discovery_result.txt ${reset}"
echo " "
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
#CHAT_ID=$(cat ~/reconizer/.tgcreds | grep "chat_id" | awk {'print $3'})
#TOKEN=$(cat ~/reconizer/.tgcreds | grep "token" | awk {'print $3'})
#MESSAGE="Scanning finished for $DOM"
#URL="https://api.telegram.org/bot$TOKEN/sendMessage"
#curl -s -X POST $URL -d chat_id=$CHAT_ID -d text="$MESSAGE" > /dev/null
echo " "
echo "${red} [+] Thank you for using R3C0Nizer${reset}"
echo ""
echo "${yellow} ---------------------------------- xxxxxxxx ---------------------------------- ${reset}"
