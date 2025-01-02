#!/usr/bin/env bash

SRC="../src"
TARGET=".devcontainer/features"

if [[ ! -L $TARGET || ! -e $TARGET ]]; then
  ln -sf $SRC $TARGET
fi
