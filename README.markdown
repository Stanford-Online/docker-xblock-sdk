# docker-xblock-sdk
Create a Docker container to host the OpenEdx XBlock SDK

## Prerequisites
```shell
apt-get install docker.io
```

## Installation
```shell
git clone https://github.com/Stanford-Online/docker-xblock-sdk.git
```

## Usage
```shell
cd docker-xblock-sdk
make
# open browser to http://localhost:8002
```

### How do I...

#### run the default server?
```shell
make run
# or simply
make
```

#### create a new XBlock?
```shell
make xblock
# answer the prompts
```

#### run with my own XBlocks?
```shell
make run XBLOCKS=/path/to/directory/of/xblocks
# ls /path/to/directory/of/xblocks
# > xblock1
# > xblock2
```

#### run the server on another port?
```shell
make run PORT=80
```

#### run the server interactively?
```shell
make shell
```

#### run the server as a background daemon?
```shell
make daemon
```

#### stop a background daemon?
```shell
make stop
```

#### run the server with a local copy of the SDK?
```shell
make SDK=/path/to/xblock-sdk.git
```

#### run the server with a local copy of the grunt-init template?
```shell
make TEMPLATE=/path/to/.grunt-init/template.git
```
