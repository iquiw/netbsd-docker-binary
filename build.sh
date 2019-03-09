#! /bin/sh

set -ex

export VERSION=18.09.3
export GITCOMMIT=$(git rev-parse --short HEAD)
export BUILDTIME=$(date --utc --rfc-3339 ns 2> /dev/null | sed -e 's/ /T/')

export GOOS=netbsd

build() {
	GOARCH="$1" go build -v -o docker-"$1"
}

cd /go/src/github.com/docker/cli/cmd/docker

build amd64
build 386
