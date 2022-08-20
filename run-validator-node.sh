#!/bin/bash
wget https://github.com/CODEisArrrt/aptos-ait3/releases/download/v0.1.0/aptos.tar 
tar -xzvf aptos.tar
cd aptos 
sudo ./run-testnet.sh $*
