#!/bin/bash

while [ $# -gt 0 ]; do
  case "$1" in
  --source=*)
    source="${1#*=}"
    ;;
  *)
    printf "* Error: Invalid argument $1 *\n"
    exit 1
    ;;
  esac
  shift
done

export LC_ALL="cs_CZ.UTF-8"
export TZ="Europe/Prague"

cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null

rmPath=$(bash ini.sh getValue defaultRmPath)
logPath=$(bash ini.sh getValue defaultLogPath)
threadCountMax=$(bash ini.sh getValue reharvestThreadCount)
sources=$(bash ini.sh getValue reharvest$source)
job=$(bash ini.sh getValue reharvestJob$source)
async=$(bash ini.sh getValue reharvestAsync$source)

if [ -z $job ]; then
  job=$(bash ini.sh getValue reharvestJobDefault)
fi
if [ -z $rmPath ]; then
  printf "Empty rm dir\n"
  exit 1
fi
cd $rmPath

if [ -n "$sources" ]; then
  echo $sources | grep "[0-9]*" -o | while read -r id; do
    if [ "$async" == "no" ]; then
      nohup java -Dlogback.configurationFile=logback.xml -DCONFIG_DIR=config/ -jar target/cz.mzk.recordmanager.cmdline-1.0.0-SNAPSHOT.jar -job $job -configurationId $id -reharvest true -repeat 1 >$logPath$id.log
    else
      threadCount=$(ps aux | grep "cz.mzk.recordmanager" | grep "java" | wc -l)
      while [ $threadCount -ge $threadCountMax ]; do
        sleep 30
        threadCount=$(ps aux | grep "cz.mzk.recordmanager" | grep "java" | wc -l)
      done
      echo "run $id"
      nohup java -Dlogback.configurationFile=logback.xml -DCONFIG_DIR=config/ -jar target/cz.mzk.recordmanager.cmdline-1.0.0-SNAPSHOT.jar -job $job -configurationId $id -reharvest true -repeat 1 >$logPath$id.log &
    fi
  done
fi
