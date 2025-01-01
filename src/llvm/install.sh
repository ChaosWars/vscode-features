#!/bin/bash

set -eu

export ARCH=$(dpkg --print-architecture)
export APT_KEYRINGS="/etc/apt/keyrings"
export LLVM_TOOLCHAIN_GPG="$APT_KEYRINGS/llvm-snapshot.gpg"
export LLVM_APT_LIST="/etc/apt/sources.list.d/llvm-snapshot.list"
export VERSION_CODENAME=$(. /etc/os-release && echo $VERSION_CODENAME)

mkdir -m 0755 -p "${APT_KEYRINGS}"
curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | sudo gpg --dearmor -o $LLVM_TOOLCHAIN_GPG
chmod a+r $LLVM_TOOLCHAIN_GPG
echo "deb [arch="$ARCH" signed-by=$LLVM_TOOLCHAIN_GPG] http://apt.llvm.org/"$VERSION_CODENAME"/ llvm-toolchain-"$VERSION_CODENAME"-19 main" | sudo tee "$LLVM_APT_LIST" > /dev/null
echo "deb-src [arch="$ARCH" signed-by=$LLVM_TOOLCHAIN_GPG] http://apt.llvm.org/"$VERSION_CODENAME"/ llvm-toolchain-"$VERSION_CODENAME"-19 main" | sudo tee -a "$LLVM_APT_LIST" > /dev/null

export DEBIAN_FRONTEND=noninteractive
apt-get -yq update
apt-get -yq upgrade
apt-get -yq install --no-install-recommends \
    build-essential \
    ccache \
    clang-19 \
    clang-format-19 \
    clang-tidy-19 \
    clang-tools-19 \
    clangd-19 \
    cmake \
    git \
    jq \
    kde-standard \
    libc++-dev \
    libc++abi-dev \
    libclang-common-19-dev \
    libclang-19-dev \
    libclang-rt-19-dev \
    libclang1-19 \
    libfuzzer-19-dev \
    libllvm-19-ocaml-dev \
    libllvm19 \
    libpolly-18-dev \
    lld-19 \
    lldb-19 \
    llvm-19 \
    llvm-19-dev \
    llvm-19-runtime \
    ninja-build \
    python3-clang-19 \
    python3-dbus \
    python3-setproctitle \
    python3-yaml \

apt-get -yq autoremove
apt-get -yq clean
rm -rf /var/lib/apt/lists/*

PROFILE_DIR="/etc/profile.d"

if [[ ! -d "${PROFILE_DIR}" ]]; then
    mkdir -p "${PROFILE_DIR}"
fi

ENVIRONMENT_FILE="99-llvm-snapshot.sh"
ENVIRONMENT_PATH="${PROFILE_DIR}/${ENVIRONMENT_FILE}"

echo "export PATH=\"/usr/lib/llvm-19/bin:\$PATH\"" > "${ENVIRONMENT_PATH}"
