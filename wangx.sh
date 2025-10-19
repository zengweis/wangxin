#!/bin/bash

# 更新系统包索引
echo "正在执行 apt update..."
sudo apt update -y

# 安装 Docker
echo "正在安装 Docker..."
sudo apt install docker.io -y

# 确保 Docker 服务启动
echo "启动 Docker 服务..."
sudo systemctl start docker
sudo systemctl enable docker

# 创建目录
echo "创建 /root/wangx 目录..."
sudo mkdir -p /root/wangx

# 拉取指定 Docker 镜像
echo "正在拉取 wxedge 镜像..."
sudo docker pull images-cluster.xycloud.com/wxedge/wxedge:latest

# 运行 Docker 容器
echo "启动 wxedge 容器..."
sudo docker run -d \
  --name=wxedge \
  --restart=always \
  --privileged \
  --net=host \
  --tmpfs /run \
  --tmpfs /tmp \
  -v /root/wangx:/storage:rw \
  images-cluster.xycloud.com/wxedge/wxedge:latest

echo "所有操作完成！"
