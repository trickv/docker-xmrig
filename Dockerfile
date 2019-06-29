FROM debian:9-slim

LABEL maintainer "trick@vanstaveren.us"

WORKDIR /src
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    cmake \
    build-essential \
    libuv1-dev \
    libmicrohttpd-dev \
    libssl-dev \
    && \
    git clone https://github.com/xmrig/xmrig.git && \
    cd xmrig && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cp xmrig /bin && \
    rm -Rf /src && \
    apt-get autoremove && \
    apt-get purge -y git cmake build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --system --uid 1005 -M --shell /usr/sbin/nologin miner
USER miner

ENTRYPOINT ["xmrig"]

