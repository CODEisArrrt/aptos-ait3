#!/bin/bash

if [ ! -f "aptos.tar" ]; then
    wget https://github.com/CODEisArrrt/aptos-ait3/releases/download/v0.1.0/aptos.tar 
fi

rm -rf aptos

echo "解压数据中..."

tar -xzvf aptos.tar

cd aptos 

sudo ./run-testnet.sh $*
