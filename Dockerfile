FROM ubuntu:17.10

RUN apt-get update && apt-get install -y \
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
    make \
    python-all-dev \
    unzip \
    wget \
    zip \
  && rm -rf /var/lib/apt/lists/*

# Install toolchain
COPY --from=wpilib/roborio-toolchain:2018-future-17.10 /packages/*.deb /packages/
RUN dpkg -i /packages/*.deb && rm -rf /packages

# Install OpenJDK 10
WORKDIR /usr/lib/jvm
RUN curl -SL https://download.java.net/java/GA/jdk10/10/binaries/openjdk-10_linux-x64_bin.tar.gz | tar xzf -
COPY jdk-10.jinfo .jdk-10.jinfo
RUN bash -c "grep /usr/lib/jvm .jdk-10.jinfo | awk '{ print \"update-alternatives --install /usr/bin/\" \$2 \" \" \$2 \" \" \$3 \" 2\"; }' | bash " \
  && update-java-alternatives -s jdk-10

WORKDIR /
