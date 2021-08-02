#!/bin/bash

function remove() {
  if [ -f "1" ]; then
    rm "$1"
  fi
}

dataPath=$(bash ini.sh getValue defaultUpvPath)
if [ -n "$1" ]; then
  dataPath=$1
fi

if [ -d "$dataPath" ]; then
  cd $dataPath
else
  echo "file not found"
  exit
fi

for i in $(ls | grep -P "^St36_CZ_[0-9]{4}-[0-9]{1,2}$" | grep -oP "[0-9]{4}" | sort | uniq); do
  for j in {1..53}; do
    folder="St36_CZ_$i-$j"
    if ! [ -d $folder ]; then
      continue
    else
      echo $folder
    fi
    remove "$folder/ep-patent-document-v1-5.dtd"
    remove "$folder/St36_CZ_A3_$i-$j.xml"
    remove "$folder/St36_CZ_B6_$i-$j.xml"
    remove "$folder/St36_CZ_U1_$i-$j.xml"
    mv $folder/* upv-export_cele_databaze
    rm -rf $folder
  done
done
