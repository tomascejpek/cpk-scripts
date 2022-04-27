#!/bin/bash

if [ -d "$1" ]; then
  cd $1
else
  printf "File not found!!!\n"
  exit 1
fi

for id in {'VKOL','SVKPL','SVKHK','NKP','MZK','MSVK','MKP','KVKLI','KMHK','KKFB','JVKCB','KKKV','KKVysociny','UZEI','SVKUL','NLK','SVKKL'}; do
  echo $id
  wget --no-check-certificate "https://sfx.knihovny.cz/sfxlcl3/cgi/public/get_file.cgi?file=institutional_holding-$id.xml"
done

wget --no-check-certificate "https://sfx.knihovny.cz/sfxlcl3/cgi/public/get_file.cgi?file=institutional_holding.xml"
wget --no-check-certificate "https://sfx.techlib.cz/sfxlcl41/cgi/public/get_file.cgi?file=institutional_holding-NTK.xml"
