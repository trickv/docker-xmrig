FROM debian:9-slim

LABEL maintainer "trick@vanstaveren.us"

ENV VERSION=v2.15.4-beta

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
    git checkout $VERSION && \
    echo && \
    echo "before:" && \
    cat src/donate.h | grep DonateLevel && \
    sed -i s:"DonateLevel = 1":"DonateLevel = 0":g src/donate.h && \
    echo && \
    echo "after:" && \
    cat src/donate.h | grep DonateLevel && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cp xmrig /bin && \
    rm -Rf /src && \
    apt-get purge -y git cmake build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd --system --uid 1005 -M --shell /usr/sbin/nologin miner
USER miner

ENTRYPOINT ["xmrig"]

