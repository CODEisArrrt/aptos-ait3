# aptos-ait3

aptos node binary file extracted from aptos offical docker image.

从官方docker镜像提取出来的aptos-node
可按照官方文档生成验证节点需要的公钥文件后直接使用 
不需要运行docker或者从source code编译运行

例如：```./bin/aptos genesis generate-keys --output-dir $WORKDIR```

公钥和节点配置文件准备就绪后运行

```./bin/aptos-node -f $WORKDIR/validator.yaml```


## 在新开服务器纯净系统中快速运行验证节点 (以下命令只在ubuntu 20.04版本下测试过 其余系统与版本未做测试)
```bash <(curl -s https://raw.githubusercontent.com/CODEisArrrt/aptos-ait3/main/run-validator-node.sh) aptos-test```

或者

```wget https://github.com/CODEisArrrt/aptos-ait3/releases/download/v0.1.0/aptos.tar && tar -xzvf aptos.tar && cd aptos && sudo ./run-testnet.sh aptos-test```

以上两个命令末尾的 aptos-test 可以修改为其他非中文的节点名称 
### 运行成功后请妥善保管 aptos/testnet/keys 目录下的 private-keys.yaml 文件
