#!/bin/sh
set -e
cd "$(dirname "$0")"

odin run generator -error-pos-style:unix -- protocols/*
