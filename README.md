# XMRig container

[![Docker Pulls](https://img.shields.io/docker/pulls/trickv/xmrig.svg?style=plastic)](https://hub.docker.com/r/trickv/xmrig/)

[XMRig](https://github.com/xmrig/xmrig) is a high performance Monero (XMR) CPU miner originally based on
cpuminer-multi with heavy optimizations/rewrites and removing a lot of legacy
code, since version 1.0.0 completely rewritten from scratch on C++.

## Usage

Bellow an example usage for a **2 core** system (see the `-t 2` parameter) named
**Miner01** (using the password field to set the miner name with `-p Miner01`).

```
docker run --restart unless-stopped --name miner -d --read-only -m 50M -c 512 strm/xmrig \
   -a cryptonight -o stratum+tcp://pool.supportxmr.com:5555 -p Miner01 -k -t 2 \
   --donate-level=1 --cpu-priority 0 -u <Your Wallet Address>
```

## How to build

```
docker build -t myxmrig .
```
