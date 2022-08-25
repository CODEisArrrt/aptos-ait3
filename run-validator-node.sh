#!/bin/bash

sudo apt update && sudo apt install net-tools -y

if [ ! -f "aptos.tar" ]; then
    wget https://github.com/CODEisArrrt/aptos-ait3/releases/download/v0.1.0/aptos.tar 
fi

rm -rf aptos

echo "解压数据中..."

tar -xzvf aptos.tar

cd aptos

wget https://github.com/CODEisArrrt/aptos-ait3/releases/download/v0.1.0/status
chmod +x status

echo
echo -e "\e[91m**********************\e[0m"
echo -e "\e[91m**********************\e[0m"
echo -e "\e[91m***                ***\e[0m"
echo -e "\e[91m***  hetaodao.com  ***\e[0m"
echo -e "\e[91m***                ***\e[0m"
echo -e "\e[91m**********************\e[0m"
echo -e "\e[91m**********************\e[0m"
echo

username=$1

if [ ! -n "$username" ]; then
    echo -e "\e[91m您未提供节点名称\e[0m"
    exit 1
fi

echo "该脚本只在 ubuntu 20.04 系统下测试通过 3秒后继续 或 ctrl+c 退出"
sleep 3

pid=`ps -ef | grep "aptos-node" | grep -v "grep" | awk '{print $2}'`

if [ -n "$pid" ]; then
    kill -9 $pid
fi

ip=`curl -s ifconfig.me/ip`
dir=`pwd`

echo 
echo "您的节点名称：$username"
echo "您的公网IP：$ip"
echo

chmod +x bin/aptos
chmod +x bin/aptos-node

rm -rf testnet

mkdir testnet
mkdir testnet/data

cp framework.mrb testnet/

echo "正在生成节点与用户密钥..."
bin/aptos genesis generate-keys --output-dir $dir/testnet/keys
if [ ! $? -eq 0 ]; then
    echo -e "\e[91m密钥生成失败\e[0m"
    exit 1
fi
echo

echo "正在生成节点信息文件..."
bin/aptos genesis set-validator-configuration \
    --local-repository-dir $dir/testnet \
    --username $username \
    --owner-public-identity-file $dir/testnet/keys/public-keys.yaml \
    --validator-host $ip:6180 \
    --stake-amount 100000000000000
if [ ! $? -eq 0 ]; then
    echo -e "\e[91m节点信息文件生成失败\e[0m"
    exit 1
fi
echo

echo "正在生成测试链创世数据..."
cat > testnet/layout.yaml <<EOF
root_key: "D04470F43AB6AEAA4EB616B72128881EEF77346F2075FFE68E14BA7DEBD8095E"
users: ["$username"]
chain_id: 43
allow_new_validators: false
epoch_duration_secs: 7200
is_test: true
min_stake: 100000000000000
min_voting_threshold: 100000000000000
max_stake: 100000000000000000
recurring_lockup_duration_secs: 86400
required_proposer_stake: 100000000000000
rewards_apy_percentage: 10
voting_duration_secs: 43200
voting_power_increase_limit: 20
EOF
bin/aptos genesis generate-genesis --local-repository-dir $dir/testnet --output-dir $dir/testnet
if [ ! $? -eq 0 ]; then
    echo -e "\e[91m创世数据生成失败\e[0m"
    exit 1
fi
echo

echo "正在生成节点配置文件..."
cat > testnet/validator.yaml <<EOF
base:
  role: "validator"
  data_dir: "$dir/testnet/data"
  waypoint:
    from_file: "$dir/testnet/waypoint.txt"

consensus:
  safety_rules:
    service:
      type: "local"
    backend:
      type: "on_disk_storage"
      path: $dir/testnet/data/secure-data.json
      namespace: ~
    initial_safety_rules_config:
      from_file:
        waypoint:
          from_file: $dir/testnet/waypoint.txt
        identity_blob_path: $dir/testnet/keys/validator-identity.yaml
  quorum_store_poll_count: 1

execution:
  genesis_file_location: "$dir/testnet/genesis.blob"
  concurrency_level: 4

validator_network:
  discovery_method: "onchain"
  mutual_authentication: true
  identity:
    type: "from_file"
    path: $dir/testnet/keys/validator-identity.yaml

full_node_networks:
- network_id:
    private: "vfn"
  listen_address: "/ip4/0.0.0.0/tcp/6181"
  identity:
    type: "from_config"
    key: "b0f405a3e75516763c43a2ae1d70423699f34cd68fa9f8c6bb2d67aa87d0af69"
    peer_id: "00000000000000000000000000000000d58bc7bb154b38039bc9096ce04e1237"

api:
  enabled: true
  address: "0.0.0.0:8080"
EOF
echo

nohup bin/aptos-node -f testnet/validator.yaml 2>testnet/error.log > testnet/run.log &
nohup ./status 8081 $username $dir/testnet 2>testnet/status.log > testnet/status.log &

echo -e "验证节点运行成功 \n\n\e[91m请将以下参数填入aptos官网节点注册页面 https://aptoslabs.com/it3\e[0m"
cat testnet/keys/public-keys.yaml
echo -e "---\n\e[91m请将以上参数填入aptos官网节点注册页面 https://aptoslabs.com/it3\e[0m"
echo
echo -e "\e[91m**********************\e[0m"
echo -e "\e[91m**********************\e[0m"
echo -e "\e[91m***                ***\e[0m"
echo -e "\e[91m***  hetaodao.com  ***\e[0m"
echo -e "\e[91m***                ***\e[0m"
echo -e "\e[91m**********************\e[0m"
echo -e "\e[91m**********************\e[0m"
echo
