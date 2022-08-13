#!/bin/bash

# this script is for using nuclei scan

mkdir nuclei-scan
cd nuclei-scan
cp ../vhost/http_probe.txt .

nuclei -l http_probe.txt -t ../nuclei-templates/ -silent 

# git add nuclei-result.txt 
git add -A
git config --global user.email "max9036461@gmail.com"
git config --global user.name "osamatest1"
git commit -a -m "nuclei scan Done"
git push -u origin main
echo "Nuclei scan is Done "

