FROM debian:10-slim

LABEL maintainer "trick@vanstaveren.us"

# URL: https://github.com/xmrig/xmrig/archive/v2.14.1.tar.gz
ENV VERSION=2.14.4
ENV URL=https://github.com/xmrig/xmrig/archive/v$VERSION.tar.gz

# install upstream build essentials in a different layer as it rarely will significantly change
# makes hacking faster
# annoying downside: image size increases from ~190M -> ~360M because we can't apt purge build-essential and cmake (well you can, but they're there, in the underlying layer)
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    libuv1-dev \
    libmicrohttpd-dev \
    libssl-dev

WORKDIR /src

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git \
    wget \
    && \
    wget -O - $URL | tar xfz - && \
    ln -s xmrig-$VERSION xmrig && \
    cd xmrig && \
    sed -i s:"DonateLevel = 1":"DonateLevel = 0":g src/donate.h && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cp xmrig /usr/local/bin && \
    cd / && \
    rm -Rf /src && \
    apt-get purge -y git && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER nobody

ENTRYPOINT ["xmrig"]
