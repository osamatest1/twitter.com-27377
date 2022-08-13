#!/bin/bash
# this script is for probbing domain list using httpx

mkdir httpx-probe
cd httpx-probe
cp ../output/final_list.txt .

echo " Running Httpx..."

cat final_list.txt | httpx -silent -tech-detect -status-code -vhost -method -follow-redirects  -no-color -rate-limit 250 -cname -x all -websocket -o httpx_result.txt

# git add httpx_result.txt
git add -A
git config --global user.email "max9036461@gmail.com"
git config --global user.name "osamatest1"
git commit -a -m "httpx is Done.."
git branch -M main
git push -u origin main
echo "httpx probbing is done.."