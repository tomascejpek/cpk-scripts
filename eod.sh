#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null

harvesterPath=$(bash ini.sh getValue defaultHarvesterPath)
cd $harvesterPath

bash harvester.sh --source=P1-UIBK --repeat=true &
bash harvester.sh --source=P2-UT --repeat=true &
bash harvester.sh --source=P3-NUK --repeat=true &
bash harvester.sh --source=P5-EMAU --repeat=true &
bash harvester.sh --source=P6-NLS --repeat=true &
bash harvester.sh --source=P7-NCU --repeat=true &
bash harvester.sh --source=P10-BNP --repeat=true &
bash harvester.sh --source=P11-NLE --repeat=true &
bash harvester.sh --source=P13-CVTISR --repeat=true &
bash harvester.sh --source=P14-UREG --repeat=true &
bash harvester.sh --source=P15-VU --repeat=true &
