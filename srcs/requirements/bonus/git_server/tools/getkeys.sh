#!/bin/sh

[ "$1" = "git" ] || exit 0

cat ~/.ssh/keys/*.pub
