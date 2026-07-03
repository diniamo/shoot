#!/bin/sh
set -eu
cd "$(dirname "$0")"

odin run bindgen/src -- .
sed -i \
	-e 's/\"LIBPNG_VER_STRING\"/" + LIBPNG_VER_STRING + "/' \
	-e '/^SIZE_MAX/c\SIZE_MAX :: max(c.size_t)' \
	png.odin
