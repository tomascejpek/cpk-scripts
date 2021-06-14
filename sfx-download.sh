#!/bin/bash

if [ -d "$1" ]; then
  cd $1
else
  printf "File not found!!!\n"
  exit 1
fi

for id in {'VKOL','SVKPL','SVKHK','NKP','MZK','MSVK','MKP','KVKLI','KMHK','KKFB','JVKCB','KKKV','KKVysociny','UZEI'}; do
  echo $id
  wget "https://sfx.knihovny.cz/sfxlcl3/cgi/public/get_file.cgi?file=institutional_holding-$id.xml"
done

wget "https://sfx.knihovny.cz/sfxlcl3/cgi/public/get_file.cgi?file=institutional_holding.xml"
wget "http://sfx.techlib.cz/sfxlcl41/cgi/public/get_file.cgi?file=institutional_holding-NTK.xml"
