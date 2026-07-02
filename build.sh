#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"

usage() {
	echo "Usage: $0 [release/debug [compiler flags]]" 1>&2
	exit 1
}

run() {
	echo "> $@"
	"$@"
}

subcommand="release"
if [[ "$#" > 0 ]]; then
	subcommand="$1"
	shift
fi

options=(
	-default-to-panic-allocator
	-disallow-do
	-error-pos-style:unix
	-out:shoot
)
case "$subcommand" in
	debug)
		options+=(
			-debug
			-linker:mold
		)
		;;
	release)
		options+=(
			-disable-assert
			-lto:thin
			-microarch:native
			-no-bounds-check
			-o:speed
		)
		;;
	*)
		usage
		;;
esac

run odin build . "${options[@]}" "$@"
