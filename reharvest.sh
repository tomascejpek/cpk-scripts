#!/bin/bash

rmPath=$(bash ini.sh getValue defaultRmPath)

if [ -z $rmPath ]; then
  exit 1
fi
cd $rmPath

ids=(300)

for id in "${ids[@]}"; do
  nohup java -Dlogback.configurationFile=logback.xml -DCONFIG_DIR=config/ -jar target/cz.mzk.recordmanager.cmdline-1.0.0-SNAPSHOT.jar -job oaiHarvestJob -configurationId $id -reharvest true -repeat 1 &
done
