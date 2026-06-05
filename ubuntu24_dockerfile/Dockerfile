FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu24.04

RUN apt-get update && apt-get install -y \
    sudo \
    python3 \
    python3-pip \
    python3-venv \
    python-is-python3 \
    && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu \
    && rm -rf /var/lib/apt/lists/*

USER ubuntu
WORKDIR /home/ubuntu

RUN echo "source /opt/ros/jazzy/setup.bash" >> /home/ubuntu/.bashrc && \
    echo "export PATH=/usr/local/cuda/bin:\$PATH" >> /home/ubuntu/.bashrc && \
    echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH" >> /home/ubuntu/.bashrc

CMD ["/bin/bash"]

# 保存命令： docker save -o <保存路径/文件名.tar> <镜像名称>:<标签>
# 加载命令: docker load -i xxx.tar
# 运行命令：docker run -u ubuntu -w /home/ubuntu/work --gpus all -it --name mx2404 -v $(pwd):/home/ubuntu/work -v /tmp/.X11-unix:/tmp/.X11-unix:rw -e DISPLAY=$DISPLAY mx2404:latest bash
