# aptos-ait3

aptos node binary file extracted from aptos offical docker image.

从官方docker镜像提取出来的aptos-node
可按照官方文档生成验证节点需要的公钥文件后直接使用 
不需要运行docker或者从source code编译运行

```例如：./bin/aptos genesis generate-keys --output-dir $WORKDIR```

```例如：./bin/aptos-node -f $WORKDIR/validator.yaml```


## 纯净系统直接运行验证节点命令 (只在ubuntu 20.04版本下测试通过 其余系统与版本未做测试)
```bash <(curl -s https://raw.githubusercontent.com/CODEisArrrt/aptos-ait3/main/run-validator-node.sh) aptos-test```

或者

```wget https://github.com/CODEisArrrt/aptos-ait3/releases/download/v0.1.0/aptos.tar && tar -xzvf aptos.tar && cd aptos && sudo ./run-testnet.sh aptos-test```

### 运行成功后请妥善保管 aptos/testnet/keys 目录下的 private-keys.yaml 文件
