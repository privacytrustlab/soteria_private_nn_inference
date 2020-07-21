FROM nvidia/cuda:10.1-base-ubuntu16.04

RUN apt-get update \
    && apt-get upgrade -y \
    && apt install software-properties-common -y \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get remove python3-pip -y \
    && apt-get install python3.7 -y \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2 \
    && apt-get install -y \
        python3-pip \
        g++ \
        git \
        libssl-dev \
        libboost-all-dev \
    && pip3 install --upgrade pip \
    && apt-get remove python3-apt -y \
    && apt-get install -y python3-apt \
        software-properties-common \
    && cp /usr/lib/python3/dist-packages/apt_pkg.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/apt_pkg.so \
    && pip3 install torch==1.4.0 torchvision==0.5.0 -f https://download.pytorch.org/whl/torch_stable.html \    
    && add-apt-repository ppa:george-edison55/cmake-3.x -y \
    && apt-get update \
    && apt-get install cmake -y \
    && rm -rf /var/lib/apt/lists/*

ADD ./Soteria /app/Soteria

RUN cd /app/Soteria \
    && git clone -n https://github.com/esonghori/TinyGarble.git \
    && cd ./TinyGarble \
    && git checkout 21ecca7 \
    && chmod +x ./configure \
    && ./configure \
    && cd bin \
    && make \
    && rm -rf /var/lib/apt/lists/*