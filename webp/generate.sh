#!/bin/sh
set -eu
cd "$(dirname "$0")"

odin run bindgen/src -- .
sed -i '/Forward declarations/,/^$/d' mux.odin
