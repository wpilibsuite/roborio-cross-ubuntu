FROM ubuntu:18.04

RUN apt-get update && apt-get install -y tzdata && apt-get install -y \
    build-essential \
    ca-certificates \
    cmake \
    curl \
    g++ --no-install-recommends \
    gcc \
    gdb \
    git \
    java-common \
    libc6-dev \
    libisl15 \
    make \
    libopencv-dev \
    python-all-dev \
    sudo \
    unzip \
    wget \
    zip \
  && rm -rf /var/lib/apt/lists/*

# Install OpenJDK 11
WORKDIR /usr/lib/jvm
RUN curl -SL https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz | tar xzf -
COPY jdk-11.0.1.jinfo .jdk-11.0.1.jinfo
RUN bash -c "grep /usr/lib/jvm .jdk-11.0.1.jinfo | awk '{ print \"update-alternatives --install /usr/bin/\" \$2 \" \" \$2 \" \" \$3 \" 2\"; }' | bash " \
  && update-java-alternatives -s jdk-11.0.1

ENV JAVA_HOME /usr/lib/jvm/jdk-11.0.1

# Install toolchain
RUN curl -SL https://github.com/wpilibsuite/toolchain-builder/releases/download/v2019-3/FRC-2019-Linux-Toolchain-6.3.0.tar.gz | sh -c 'mkdir -p /usr/local && cd /usr/local && tar xzf - --strip-components=2'

WORKDIR /
