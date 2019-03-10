#! /bin/sh

set -ex

export VERSION=18.09.3
export GITCOMMIT=$(git rev-parse --short HEAD)
export BUILDTIME=$(date --utc --rfc-3339 ns 2> /dev/null | sed -e 's/ /T/')

export GOOS=netbsd

ARTIFACTS_DIR=/tmp/artifacts

build() {
	arch=$1
	GOARCH="$arch" go build -v -o "$ARTIFACTS_DIR/docker-$GOOS-$arch"
	xz "$ARTIFACTS_DIR/docker-$GOOS-$arch"
}

cd /go/src/github.com/docker/cli/cmd/docker

mkdir "$ARTIFACTS_DIR"

build amd64
build 386
