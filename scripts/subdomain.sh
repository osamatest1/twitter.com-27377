#!/bin/bash

# this script is for subdoamin enumeration
mkdir output
cd output/
echo "starting subdomain enumeration...."
cp ../domains.txt .

## assetFinder
echo " aseet finder is running......"
cat domains.txt |assetfinder --subs-only | tee asset.txt 

## subfind
echo "subfind is running ......."
 subfinder -dL domains.txt -all -nC -oJ -silent -o subfind.json 
 cat subfind.json | jq| fgrep "host" | cut -d ':' -f 2| sed 's/"//g'| sed 's/,//g' | tee subfind.txt
 rm subfind.json
#amass

echo "amass is runnnign....."
amass enum -passive -df domains.txt -o amass.txt


cat asset.txt | anew subdomains.txt
cat subfind.txt | anew subdomains.txt
cat amass.txt | anew subdomains.txt
rm -rfd subfind* amass.txt 

# subdomains from CRT.Sh
while read -r line;
do 
    echo "finding for $line"
    ../scripts/crt-sh.py $line
done < "domains.txt"

cat crt.txt | anew subdomains.txt 

cat subdomains.txt | sed 's/ //g' | anew final_list.txt
rm asset.txt domains.txt subdomains.txt outofscope.txt crt.txt 

# git add final_list.txt 
git add -A
git config --global user.email "max9036461@gmail.com"
git config --global user.name "osamatest1"
git commit -m "Subdomain Enumeration completed"
git branch -M main 
git push -u origin main
echo " Subdomain Enumeraiton is Done.."
