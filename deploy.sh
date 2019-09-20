#! /bin/sh

set -ex

GHR_VERSION=0.13.0

curl -sLO https://github.com/tcnksm/ghr/releases/download/v$GHR_VERSION/ghr_v${GHR_VERSION}_linux_amd64.tar.gz

tar xvzf ghr_v${GHR_VERSION}_linux_amd64.tar.gz ghr_v${GHR_VERSION}_linux_amd64/ghr

./ghr_v${GHR_VERSION}_linux_amd64/ghr \
       -c "$CIRCLE_SHA1" \
       -u "$CIRCLE_PROJECT_USERNAME" \
       -r "$CIRCLE_PROJECT_REPONAME" \
       -n "$CIRCLE_TAG" \
       -b 'Docker CLI binaries for NetBSD.' \
       "$CIRCLE_TAG" /tmp/artifacts
