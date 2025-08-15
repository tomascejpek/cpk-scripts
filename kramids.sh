#!/bin/bash

source="$1"
i=0
count=5000

if [ -z $source ]; then
  printf "No source - mzk | nkp \n"
  exit 1
fi
source="kram-$1"

sourceUrl=$(bash ini.sh getValue $source)
logPath=$(bash ini.sh getValue defaultLogPath)
dataPath=$(bash ini.sh getValue defaultDataPath)$source

if [ -z $sourceUrl ]; then
  printf "No url for $source \n"
  exit 1
fi

if [ -d "$dataPath" ]; then
  rm $dataPath/*
else
  mkdir $dataPath
fi

cursorMark='*'
if [ "$source" == "kram-nkp" ]; then
  url="$sourceUrl/search/api/v5.0/search?q=*:*&fq=fedora.model:monograph+OR+fedora.model:periodical+OR+fedora.model:map+OR+fedora.model:archive+OR+fedora.model:manuscript+OR+fedora.model:sheetmusic+OR+fedora.model:soundrecording+OR+fedora.model:graphic+OR+fedora.model:convolute&fl=PID&rows=$count&sort=PID+asc"
elif [ "$source" == "kram-mzk" ]; then
  url="$sourceUrl/search/api/client/v7.0/search?q=*:*&fq=model:monograph+OR+model:periodical+OR+model:map+OR+model:archive+OR+model:manuscript+OR+model:sheetmusic+OR+model:soundrecording+OR+model:graphic+OR+model:convolute&fl=pid&wt=xml&rows=$count&sort=pid+asc"
fi

now=$(date)
error=0
echo "$now: Downloading URL: $url&cursorMark=$cursorMark" >$logPath'kram.log'
curl -s -k "$url&cursorMark=$cursorMark" >$dataPath/temp

while true; do
  now=$(date)
  echo "$now: Downloading URL: $url&cursorMark=$cursorMark" >>$logPath'kram.log'
  curl -s -k "$url&cursorMark=$cursorMark" >$dataPath/temp
  if grep "str name=\"PID\"" -i $dataPath/temp >/dev/null; then
    ((i += $count))
    cat $dataPath/temp >$dataPath/$i.xml
    cursorMark=$(grep -oP "nextCursorMark\">\K[^<]*" $dataPath/temp)
  else
    echo "$now: DONE" >>$logPath'kram.log'
    break
  fi
done

rm $dataPath/temp
