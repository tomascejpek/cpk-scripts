#!/bin/bash

export LC_ALL="cs_CZ.UTF-8"
export TZ="Europe/Prague"

rmPath=$(bash ini.sh getValue defaultRmPath)
logPath=$(bash ini.sh getValue defaultLogPath)

if [ -z $rmPath ]; then
  echo "No RM2 in config.local.ini!!!"
  exit 1
fi
cd $rmPath

ids=(99003 99010 99011 99012 99013 99014 99015 99016 99017 99019 99023 99037)

for id in "${ids[@]}"; do
  nohup java -Dlogback.configurationFile=logback.xml -DCONFIG_DIR=config/ -jar target/cz.mzk.recordmanager.cmdline-1.0.0-SNAPSHOT.jar -job krameriusHarvestJob -configurationId $id -reharvest true -repeat 1 > >$logPath'kram-fulltext-reharvest'$id.log
done
