#!/usr/bin/env bash

set -euf -o pipefail
pushd "$(dirname "${BASH_SOURCE[0]}")/.." >/dev/null
mkdir -p .bin

# TODO: add similar task to zoekt alpine

NAME="scip-syntax"
TARGET="$PWD/.bin/${NAME}"

if [ $# -ne 0 ]; then
  if [ "$1" == "which" ]; then
    echo "$TARGET"
    exit 0
  fi
fi

function ctrl_c() {
  printf "[-] Installation cancelled.\n"
  exit 1
}

trap ctrl_c INT

function build_scip_syntax {
  cd docker-images/syntax-highlighter/crates/scip-syntax
  cargo build --bin scip-syntax --target-dir target
  cp ./target/debug/scip-syntax "$TARGET"
}

build_scip_syntax

popd >/dev/null
