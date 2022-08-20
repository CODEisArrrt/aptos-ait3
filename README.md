# aptos-ait3

aptos node binary file extracted from aptos offical docker image.

从官方docker镜像提取出来的aptos-node
可按照官方文档生成验证节点需要的公钥文件后直接使用 
```例如：./bin/aptos genesis generate-keys --output-dir $WORKDIR```
```例如：./bin/aptos-node -f $WORKDIR/validator.yaml```
不需要运行docker或者从source code编译运行
