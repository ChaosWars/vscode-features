#!/bin/bash

set -eu

export ARCH=$(dpkg --print-architecture)
export APT_KEYRINGS="/etc/apt/keyrings"
export DEBIAN_FRONTEND=noninteractive
export LLVM_TOOLCHAIN_GPG="$APT_KEYRINGS/llvm-snapshot.gpg"
export LLVM_APT_LIST="/etc/apt/sources.list.d/llvm-snapshot.list"
export VERSION_CODENAME=$(. /etc/os-release && echo $VERSION_CODENAME)

function getVersion() {
    local version="${LLVM_VERSION/20}"  # Remove "20" from the version string.
    echo ${version:+-$version}  # If version is set, return "-$version", otherwise return an empty string.
}

_LLVM_VERSION=$(getVersion)

apt-get -yq update
apt-get -yq install --no-install-recommends ca-certificates curl gpg

mkdir -m 0755 -p "${APT_KEYRINGS}"
curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | gpg --dearmor -o $LLVM_TOOLCHAIN_GPG
chmod a+r $LLVM_TOOLCHAIN_GPG
echo "deb [arch="$ARCH" signed-by=$LLVM_TOOLCHAIN_GPG] http://apt.llvm.org/"$VERSION_CODENAME"/ llvm-toolchain-"${VERSION_CODENAME}${_LLVM_VERSION}" main" | tee "$LLVM_APT_LIST" > /dev/null
echo "deb-src [arch="$ARCH" signed-by=$LLVM_TOOLCHAIN_GPG] http://apt.llvm.org/"$VERSION_CODENAME"/ llvm-toolchain-"${VERSION_CODENAME}${_LLVM_VERSION}" main" | tee -a "$LLVM_APT_LIST" > /dev/null

cat $LLVM_APT_LIST

apt-get -yq update
apt-get -yq upgrade
apt-get -yq install --no-install-recommends \
    build-essential \
    clang"${_LLVM_VERSION}" \
    clang-format"${_LLVM_VERSION}" \
    clang-tidy"${_LLVM_VERSION}" \
    clang-tools"${_LLVM_VERSION}" \
    clangd"${_LLVM_VERSION}" \
    cmake \
    git \
    libc++-dev \
    libc++abi-dev \
    libclang-common-"${LLVM_VERSION}"-dev \
    libclang"${_LLVM_VERSION}"-dev \
    libclang-rt"${_LLVM_VERSION}"-dev \
    libclang1"${_LLVM_VERSION}" \
    libfuzzer-"${LLVM_VERSION}"-dev \
    libllvm"${_LLVM_VERSION}"-ocaml-dev \
    libllvm"${LLVM_VERSION}" \
    libpolly-"${LLVM_VERSION}"-dev \
    lld"${_LLVM_VERSION}" \
    lldb"${_LLVM_VERSION}" \
    llvm"${_LLVM_VERSION}" \
    llvm"${_LLVM_VERSION}"-dev \
    llvm"${_LLVM_VERSION}"-runtime \
    ninja-build \
    python3-clang"${_LLVM_VERSION}" \
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

echo "export PATH=\"/usr/lib/llvm-${LLVM_VERSION}/bin:\$PATH\"" > "${ENVIRONMENT_PATH}"
chmod +x "${ENVIRONMENT_PATH}"
