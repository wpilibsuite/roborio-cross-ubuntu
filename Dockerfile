FROM ubuntu:17.10

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ --no-install-recommends \
    gcc \
    gdb \
    git \
    libc6-dev \
    make \
    openjdk-8-jdk-headless \
    python-all-dev \
    unzip \
    wget \
    zip \
  && rm -rf /var/lib/apt/lists/*

# Install toolchain
COPY --from=wpilib/roborio-toolchain:2018-17.10 /packages/*.deb /packages/
RUN dpkg -i /packages/*.deb && rm -rf /packages
