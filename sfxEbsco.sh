#!/bin/bash

if ! [ -f "$1" ]; then
  printf "File not found!!!\n"
  exit 1
fi

token=$(bash ini.sh getValue ebsco)

sed 's/<to\/>/<to><\/to>/g' $1 | xml_pp >knihovnycz-googlescholar.xml

curl -T knihovnycz-googlescholar.xml ftp://ftp.epnet.com/full/ --user $token

if [ -f "knihovnycz-googlescholar.xml" ]; then
  rm knihovnycz-googlescholar.xml
fi
