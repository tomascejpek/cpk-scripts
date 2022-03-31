#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null

bash reharvest.sh --source=Arl
bash reharvest.sh --source=Tritius
bash reharvest.sh --source=Clavius
bash reharvest.sh --source=Koha
bash reharvest.sh --source=Kramerius
bash reharvest.sh --source=Random
