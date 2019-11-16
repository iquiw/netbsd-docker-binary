#! /bin/sh

set -ex

VERSION=$(sed -n 's,.* netbsd/v\([0-9.]*\) .*,\1,p' .circleci/config.yml)
GITCOMMIT=$(git rev-parse --short HEAD)
BUILDTIME=$(date --utc --rfc-3339 ns 2> /dev/null | sed -e 's/ /T/')

LDFLAGS="-X github.com/docker/cli/cli/version.Version=$VERSION \
-X github.com/docker/cli/cli/version.GitCommit=$GITCOMMIT \
-X github.com/docker/cli/cli/version.BuildTime=$BUILDTIME"

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
