#!/bin/bash

function remove() {
  if [ -f "$1" ]; then
    rm "$1"
  fi
}

dataPath=$(bash ini.sh getValue defaultUpvPath)
if [ -n "$1" ]; then
  dataPath=$1
fi

if [ -d "$dataPath" ]; then
  cd "$dataPath" || exit 1
else
  echo "file not found"
  exit 1
fi

shopt -s nullglob
for folder in $(printf '%s\n' St96_CZ_*_* | sort); do
  [ -d "$folder" ] || continue
  [[ "$folder" =~ ^St96_CZ_([0-9]{4}-[0-9]{1,2})_[0-9]+$ ]] || continue
  period="${BASH_REMATCH[1]}"
  echo "$folder"
  remove "$folder/ep-patent-document-v1-5.dtd"
  remove "$folder/ST96CZ_A3_${period}_content.xml"
  remove "$folder/ST96CZ_B6_${period}_content.xml"
  remove "$folder/ST96CZ_U1_${period}_content.xml"
  mv "$folder"/* upv-export_cele_databaze-St96
  rm -rf "$folder"
  mv "${folder}.zip" upv-St96
done
