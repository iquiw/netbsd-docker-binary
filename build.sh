#! /bin/sh

set -ex

VERSION=19.03.1
GITCOMMIT=$(git rev-parse --short HEAD)
BUILDTIME=$(date --utc --rfc-3339 ns 2> /dev/null | sed -e 's/ /T/')

LDFLAGS="-X github.com/docker/cli/cli.Version=$VERSION \
-X github.com/docker/cli/cli.GitCommit=$GITCOMMIT \
-X github.com/docker/cli/cli.BuildTime=$BUILDTIME"

export GOOS=netbsd

ARTIFACTS_DIR=/tmp/artifacts

build() {
	export GOARCH=$1
	go build -v \
	   -ldflags "$LDFLAGS" \
	   -o "$ARTIFACTS_DIR/docker-$GOOS-$GOARCH"
	xz "$ARTIFACTS_DIR/docker-$GOOS-$GOARCH"
}

cd /go/src/github.com/docker/cli/cmd/docker

mkdir "$ARTIFACTS_DIR"

build amd64
build 386
