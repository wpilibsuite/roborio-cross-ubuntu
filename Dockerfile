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

# Install toolchain
COPY --from=wpilib/roborio-toolchain:2019-18.04 /packages/*.deb /packages/
RUN dpkg -i /packages/*.deb && rm -rf /packages

# Install OpenJDK 11
WORKDIR /usr/lib/jvm
RUN curl -SL https://download.java.net/java/GA/jdk11/28/GPL/openjdk-11+28_linux-x64_bin.tar.gz | tar xzf -
COPY jdk-11.jinfo .jdk-11.jinfo
RUN bash -c "grep /usr/lib/jvm .jdk-11.jinfo | awk '{ print \"update-alternatives --install /usr/bin/\" \$2 \" \" \$2 \" \" \$3 \" 2\"; }' | bash " \
  && update-java-alternatives -s jdk-11

ENV JAVA_HOME /usr/lib/jvm/jdk-11

WORKDIR /
