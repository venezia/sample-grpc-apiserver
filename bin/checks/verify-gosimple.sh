#!/bin/bash


# from http://github.com/kubernetes/kubernetes/hack/verify-gofmt.sh

set -o errexit
set -o nounset
set -o pipefail

ROOT=$(dirname "${BASH_SOURCE}")/../..

cd "${ROOT}"

gosimple=$(which gosimple)
if [[ ! -x "${gosimple}" ]]; then
  echo "could not find gosimple, please verify your GOPATH"
  exit 1
fi

source "${ROOT}/bin/common.sh"

errors=$( echo `packages` | xargs ${gosimple} 2>&1) || true
if [[ -n "${errors}" ]]; then
  echo "${errors}"
  exit 1
fi