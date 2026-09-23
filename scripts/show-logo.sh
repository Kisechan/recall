#!/bin/sh

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

exec chafa \
    --format=symbols \
    --colors=none \
    --symbols=block \
    --invert \
    --size=32x16 \
    "$script_dir/../docs/recall-logo.png"
