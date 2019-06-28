FROM ubuntu:18.04

RUN apt-get update && apt-get install -y tzdata && apt-get install -y \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    fakeroot \
    g++ --no-install-recommends \
    gcc \
    gdb \
    git \
    java-common \
    libc6-dev \
    libisl15 \
    openjdk-11-jdk \
    make \
    libopencv-dev \
    python-all-dev \
    sudo \
    unzip \
    wget \
    zip \
    python3-dev \
    python3-pip \
    python3-setuptools \
    clang-format-6.0 \
  && rm -rf /var/lib/apt/lists/*

# Install toolchain
RUN curl -SL https://github.com/wpilibsuite/roborio-toolchain/releases/download/v2020-1/FRC-2020-Linux-Toolchain-7.3.0.tar.gz | sh -c 'mkdir -p /usr/local && cd /usr/local && tar xzf - --strip-components=2'

WORKDIR /
