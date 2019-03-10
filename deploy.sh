#! /bin/sh

set -ex

HUB_VERSION=2.10.0

curl -sLO https://github.com/github/hub/releases/download/v$HUB_VERSION/hub-linux-amd64-$HUB_VERSION.tgz

tar xvzf hub-linux-amd64-$HUB_VERSION.tgz hub-linux-amd64-$HUB_VERSION/bin/hub

./hub-linux-amd64-$HUB_VERSION/bin/hub \
	release create \
	-a "/tmp/artifacts/docker-netbsd-amd64.xz" \
	-a "/tmp/artifacts/docker-netbsd-386.xz" \
	-m 'Docker CLI binaries for NetBSD.' \
	"$CIRCLE_TAG"
