FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        apt-utils \
        wget \
        unzip \
        git \
        cmake


WORKDIR /tmp
ENV PCL_VERSION="1.12.1"

# PCL dependencies
RUN apt-get install -y \
    libeigen3-dev \
    libflann-dev \
    libglu1-mesa-dev \
    freeglut3-dev \
    mesa-common-dev \
    libboost-all-dev \
    libusb-1.0-0-dev \
    libusb-dev \
    libopenni-dev \
    libopenni2-dev \
    libpcap-dev \
    libpng-dev \
    mpi-default-dev \
    openmpi-bin \
    openmpi-common \
    libqhull-dev \
    libgtest-dev

RUN apt-get install -y \
    libvtk7-dev


RUN wget https://github.com/PointCloudLibrary/pcl/archive/pcl-${PCL_VERSION}.tar.gz \
    && tar -xf pcl-${PCL_VERSION}.tar.gz \
    && cd pcl-pcl-${PCL_VERSION} \
    && mkdir build \
    && cd build \
    && cmake .. -DCMAKE_BUILD_TYPE=Release \
    && make -j$(nproc)\
    && make install
WORKDIR /work
