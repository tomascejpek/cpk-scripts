#!/bin/bash

export LC_ALL="cs_CZ.UTF-8"
export TZ="Europe/Prague"

cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null

rmPath=$(bash ini.sh getValue defaultRmPath)
logPath=$(bash ini.sh getValue defaultLogPath)
threadCount=$(bash ini.sh getValue reharvestThreadCount)

if [ -z $rmPath ]; then
  exit 1
fi
cd $rmPath

ids=(300)

for id in "${ids[@]}"; do
  number=$(ps aux | grep "cz.mzk.recordmanager" | wc -l)
  while [ $number -ge $((threadCount+1)) ]; do
    sleep 30
    number=$(ps aux | grep "cz.mzk.recordmanager" | wc -l)
  done
  echo "run $id"
  nohup java -Dlogback.configurationFile=logback.xml -DCONFIG_DIR=config/ -jar target/cz.mzk.recordmanager.cmdline-1.0.0-SNAPSHOT.jar -job oaiHarvestJob -configurationId $id -reharvest true -repeat 1 > $logPath$id.log &
done
