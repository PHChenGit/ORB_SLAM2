FROM nvidia/cudagl:11.2.1-devel-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        build-essential \
        make \
        git \
        vim \
        wget \
        curl \
        gcc \
        zip \
        unzip \
        tar \
        gdb

RUN wget https://github.com/Kitware/CMake/releases/download/v3.10.0/cmake-3.10.0-Linux-x86_64.tar.gz && \
    tar -zxvf cmake-3.10.0-Linux-x86_64.tar.gz && \
    mv cmake-3.10.0-Linux-x86_64 cmake-3.10.0 && \
    ln -sf /cmake-3.10.0/bin/* /usr/bin

### Install Opencv from source ##############
WORKDIR /

RUN apt-get update && \
    apt-get install -y \
        libgtk2.0-dev \
        libgtk-3-dev \
        pkg-config \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libpython2.7-dev \
        python-numpy \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libdc1394-22-dev \
        libglu1-mesa-dev \
        freeglut3-dev \
        mesa-common-dev \
        libgl1-mesa-dev \
        libglew-dev \
        libboost-dev \
        libboost-thread-dev \
        libboost-filesystem-dev \
        libx11-dev \
        doxygen \
        doxygen-gui \
        graphviz

WORKDIR /lib
RUN git clone --branch 3.4.20  --depth 1  https://github.com/opencv/opencv.git && \
    git clone --branch 3.4.20  --depth 1  https://github.com/opencv/opencv_contrib.git

WORKDIR /lib/opencv/
RUN mkdir /lib/opencv/build && \
    cd /lib/opencv/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE -DOPENCV_EXTRA_MODULES_PATH=/lib/opencv_contrib/modules .. && \
    make -j$(nproc) && \
    make install

### Install eigen 3 ##############

WORKDIR /
RUN wget https://gitlab.com/libeigen/eigen/-/archive/3.3.8/eigen-3.3.8.tar.gz && \
    tar -xf eigen-3.3.8.tar.gz && \
    cd /eigen-3.3.8/ && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install

### Install Pangolin ##############
WORKDIR /
RUN git clone --depth 1 --branch v0.5 https://github.com/stevenlovegrove/Pangolin.git Pangolin

WORKDIR /Pangolin/
RUN mkdir build && \
     cd build && \
     cmake -DCPP11_NO_BOOSR=1  .. && \
     make -j$(nproc) && \
     make install

WORKDIR /ORB_SLAM2/

CMD ["tail", "-f", "/dev/null"]