# Docker 使用说明

## ubuntu20_dockerfile/ubuntu22_dockerfile/ubuntu22_dockerfile_orin 是三种环境下创建Docker的文件，使用时需要转移到对应的文件夹内执行下列代码
```
sudo docker build -t {docker_name} .
构建完毕之后可以使用docker images查看是否下载成功
```
## setup_docker_mirror.sh是用来对新机器挂载vpn,运行完毕之后才能从官网下载镜像
