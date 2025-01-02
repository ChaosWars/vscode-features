#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
sudo -E apt-get -yq update
sudo -E apt-get -yq upgrade
sudo -E apt-get -yq install npm

sudo npm install -g @devcontainers/cli
