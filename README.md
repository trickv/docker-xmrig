# XMRig container

[![Docker Pulls](https://img.shields.io/docker/pulls/trickv/xmrig.svg?style=plastic)](https://hub.docker.com/r/trickv/xmrig/)

[XMRig](https://github.com/xmrig/xmrig) is a high performance Monero (XMR) CPU miner originally based on
cpuminer-multi with heavy optimizations/rewrites and removing a lot of legacy
code, since version 1.0.0 completely rewritten from scratch on C++.

## Usage

Bellow an example usage for a **2 core** system (see the `-t 2` parameter) named
**miner01** (using the password field to set the miner name with `-p miner01`).
This also sets a container memory limit of 50M, and CPU shares to 512. YMMV.

```
docker run --restart unless-stopped --name xmrig -d --read-only -m 50M -c 512 \
    trickv/xmrig \
    -o stratum+tcp://pool.supportxmr.com:5555 -p miner01 \
    -t 2 \
    -u <Your Wallet Address>
```

## How to build

```
docker build -t myxmrig .
```
