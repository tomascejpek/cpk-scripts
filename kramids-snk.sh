#!/bin/bash

source="kram-snk"
type="$1"
i=0
count=5000

if [ -z $type ]; then
  printf "No type - meta | avai \n"
  exit 1
fi


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

if [ "$type" == "meta" ]; then
  url="$sourceUrl/search/api/client/v7.0/search?&q=model:article%20(licenses:paying_users%20OR%20licenses:public)&fl=pid&wt=xml&rows=$count&start="
elif [ "$type" == "avai" ]; then
  url="$sourceUrl/search/api/client/v7.0/search?&fl=accessibility,dnnt,pid,level,licenses&q=model:article%20(licenses:paying_users%20OR%20licenses:public)&fl=pid&wt=xml&rows=$count&start="
fi

now=$(date)
error=0
echo "$now: Downloading URL: $url$i" >$logPath'kram.log'
curl -s -k "$url$i" >$dataPath/temp

while true; do
  now=$(date)
  echo "$now: Downloading URL: $url$i" >>$logPath'kram.log'
  curl -s -k "$url$i" >$dataPath/temp
  if grep "str name=\"PID\"" -i $dataPath/temp >/dev/null; then
    ((i += $count))
    cat $dataPath/temp >$dataPath/$i.xml
  else
    echo "$now: DONE" >>$logPath'kram.log'
    break
  fi
done

rm $dataPath/temp
