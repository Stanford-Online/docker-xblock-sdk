#!/usr/bin/make -f

PORT=8002
TAG=xblock/sdk
NAME=workbench
DOCKER=sudo docker
XBLOCKS=/tmp/xblocks

ifdef SDK
_volumes:=${_volumes} -v ${SDK}:/root/sdk
endif

ifdef TEMPLATE
_volumes:=${_volumes} -v ${TEMPLATE}:/root/.grunt-init/xblock
endif

_volumes:=${_volumes} -v ${XBLOCKS}:/root/xblocks
_port_docker=80
_docker_run=${DOCKER} run -p ${PORT}:${_port_docker} ${_volumes}
_docker_run_quick=${_docker_run} -i -t --rm "${TAG}"
_docker_shell=/bin/bash
_docker_make_xblock=/usr/local/bin/xblock-make

.PHONY:
all: run

.PHONY:
run: build
	${_docker_run_quick}

.PHONY:
shell: build
	${_docker_run_quick} "${_docker_shell}"

.PHONY:
build: Dockerfile
	${DOCKER} build -t "${TAG}" .

.PHONY:
daemon: build
	${_docker_run} -d --name "${NAME}" "${TAG}"
	echo
	${DOCKER} ps

.PHONY:
stop:
	-${DOCKER} stop "${NAME}"

$(XBLOCKS):
	mkdir ${XBLOCKS}

.PHONY:
xblock: build $(XBLOCKS)
	${_docker_run_quick} ${_docker_make_xblock}
	find "${XBLOCKS}" -mindepth 1 -maxdepth 1 -print0 | \
		xargs -0 --no-run-if-empty \
			sudo chown ${USER}:
