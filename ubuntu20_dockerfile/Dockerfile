# 构建镜像命令：sudo docker build -t xxx . 
FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

ARG USERNAME=mingxi
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN groupadd --gid "${USER_GID}" "${USERNAME}" && \
    useradd -s /bin/bash --uid "${USER_UID}" --gid "${USER_GID}" -m "${USERNAME}" && \
    apt-get update && apt-get install -y sudo && \
    mkdir -p /home/${USERNAME} && \
    chown -R ${USER_UID}:${USER_GID} /home/${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}

RUN echo "source /opt/ros/foxy/setup.bash" >> /home/${USERNAME}/.bashrc && \
    echo "export PATH=/usr/local/cuda/bin:\$PATH" >> /home/${USERNAME}/.bashrc && \
    echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\$LD_LIBRARY_PATH" >> /home/${USERNAME}/.bashrc

CMD ["/bin/bash"]
