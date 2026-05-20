# 创建docker并进行的相关流程

1. 运行脚本setup_docker_mirror.sh脚本修改代理方便拉取镜像；
2. 运行build_training.sh脚本从原始的nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04构建自己的镜像；
3. 开启当前提供的容器并使用按照下边的命令：
```python
加载标准镜像：sudo docker load mx_server_v1.1.tar
开启新的容器：sudo docker run --gpus all -it --name mingxi mx_server:latest bash
进入已经创建好的容器：sudo docker start -ai mingxi
挂载硬盘初始化容器(可以不用，这样就和用户隔离)：sudo docker run --gpus all -it --rm  -v /home/mingxi/my_code:/workspace --name mingxi mx_server:latest bash

导出镜像命令：sudo docker export mingxi > /media/mingxi/Docker/mx_server_v1.1.tar
恢复导出镜像命令：见“5”
```

4. 新电脑安装docker以及调用指南：

```
更新软件源：sudo apt update
安装依赖：
sudo apt install ca-certificates curl gnupg
添加gpg key:
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

添加docker软件源：
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

安装docker：
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

设置开机自启动：
sudo systemctl enable docker
sudo systemctl start docker

验证是否安装成功：
docker version

将用户添加到用户组
sudo usermod -aG docker $USER
newgrp docker
```



5. 导入export导出的镜像文件系统：

```
导入命令：
sudo docker import /xxx/mx_server_v1.1.tar mx_server:v1.1
验证镜像：sudo docker images
```

6. 安装nvidia-container：

```
配置nvidia源：
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    
安装工具：
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit

配置docker并重启：
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

7. 打开镜像并设定初始化路径：

```
docker images 可以查看到容器之后
创建容器：
sudo docker run -u mingxi -w /home/mingxi --gpus all -it --name mingxi mx_server:v1.1 bash
如果需要把系统中的文件夹挂在进去则需要再命令中加入 -v /home/mingxi/my_code:/workspace

# ** 将docker中的内容显示到宿主机，并把当前的文件夹和docker共享
xhost +local:docker
sudo docker run -u mingxi -w /home/mingxi --gpus all -it --name mingxi   -v $(pwd):/home/mingxi/workspace   -v /tmp/.X11-unix:/tmp/.X11-unix:rw   -e DISPLAY=$DISPLAY   mx_claw:v1.4 bash
(注：$(pwd)可以更改为指定的目录，--network host 参数表示docker直接使用宿主机的网络)

进入容器：
sudo docker start -ai mingxi
重新开启终端并进入容器：
sudo docker exec -it mingxi bash

删除创建的容器：
sudo docker rm mingxi
```









