# aptos-ait3

aptos node executable binary file extracted from aptos offical docker image.

You can download from here.

```wget https://github.com/CODEisArrrt/aptos-ait3/releases/download/v0.1.0/aptos.tar```

Then unzip it.

```tar -zxvf aptos.tar && cd aptos```

After download and unzip, you can use it in command line whenever you need a aptos or aptos-node cmd.

Example: 
```./bin/aptos genesis generate-keys --output-dir YOUR_WORK_PATH```

Example:
```./bin/aptos-node -f YOUR_WORK_PATH/validator.yaml```


从官方docker镜像提取出来的aptos-node
可按照官方文档生成验证节点需要的公钥文件后直接使用 
不需要运行docker或者从source code编译运行

例如：```./bin/aptos genesis generate-keys --output-dir $WORKDIR```

公钥和节点配置文件准备就绪后运行

```./bin/aptos-node -f $WORKDIR/validator.yaml```


## 在新开服务器纯净系统中快速运行验证节点 (以下命令只在ubuntu 20.04版本下测试过 其余系统与版本未做测试)
```bash <(curl -s https://raw.githubusercontent.com/CODEisArrrt/aptos-ait3/main/run-validator-node.sh) aptos-test```

或者

```wget https://raw.githubusercontent.com/CODEisArrrt/aptos-ait3/main/run-validator-node.sh && chmod +x run-validator-node.sh && sudo ./run-validator-node.sh aptos-test```

以上两个命令末尾的 aptos-test 可以修改为其他非中文的节点名称 

### 运行成功后请妥善保管 aptos/testnet/keys 目录下的 private-keys.yaml 文件

### 问题排查
使用 ```netstat -lantp | grep aptos``` 命令 来检查aptos节点程序是否正常运行中 若正常运行 这个命令可以看到节点程序监听的8080 6180 9101等端口 否则运行失败

若判断为运行失败 可在aptos/testnet/目录下 查看run.log和error.log日志检查原因 使用```tail -f run.log```可以查看程序实时运行输出的日志信息

若节点程序正常运行 但是连接不上 请检查本地防火墙 或者 服务器运营商的防火墙 是否放行8080 6180 9101端口

