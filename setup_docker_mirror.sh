#!/bin/bash

# 定义要配置的镜像源列表
# 目前这些源在国内相对稳定，但情况随时可能变化
MIRRORS='[
    "https://docker.m.daocloud.io",
    "https://huecker.io",
    "https://dockerhub.timeweb.cloud",
    "https://noohub.ru"
]'

echo "正在配置 Docker 镜像加速器..."

# 检查 /etc/docker 目录是否存在
if [ ! -d "/etc/docker" ]; then
    sudo mkdir -p /etc/docker
fi

# 写入 daemon.json
# 注意：这会覆盖原有的 registry-mirrors 配置
# 如果你有其他配置（如 insecure-registries），请手动合并
echo "{
  \"registry-mirrors\": $MIRRORS
}" | sudo tee /etc/docker/daemon.json > /dev/null

echo "配置已写入 /etc/docker/daemon.json"
echo "正在重启 Docker 服务..."

sudo systemctl daemon-reload
sudo systemctl restart docker

echo "✅ Docker 服务已重启。"
echo "请尝试再次运行 ./build_training.sh"
