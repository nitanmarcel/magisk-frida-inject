#!/usr/bin/env bash

set -euo pipefail

declare -a commands=("wget" "xz")

for command in "${commands[@]}"; do
    if ! command -v $command &> /dev/null
    then
        echo "$command could not be found. Please install it."
        exit
    fi
done

build_mode="${1:-release}"

cd "$(dirname "$0")"

pushd native
rm -fr libs obj
debug_mode=1
if [[ "$build_mode" == "release" ]]; then
    debug_mode=0
fi
ndk-build -j4 NDK_DEBUG=$debug_mode
popd

rm -rf out
mkdir -p out
cp -af magisk-module out
mv -fT native/libs out/magisk-module/libs

FRIDA_VERSION="16.1.2"
TEMP_DIR=$(mktemp -d)
OUT_DIR="out/magisk-module/libs"

declare -A arch_dirs=(["arm"]="armeabi-v7a" ["arm64"]="arm64-v8a" ["x86"]="x86" ["x86_64"]="x86_64")

for arch in "${!arch_dirs[@]}"; do
    wget -P "${TEMP_DIR}" "https://github.com/frida/frida/releases/download/$FRIDA_VERSION/frida-inject-$FRIDA_VERSION-android-$arch.xz"
    xz -d "${TEMP_DIR}/frida-inject-$FRIDA_VERSION-android-$arch.xz"
    mv "${TEMP_DIR}/frida-inject-$FRIDA_VERSION-android-$arch" "${OUT_DIR}/${arch_dirs[$arch]}/frida-inject"
done

# zip -r9 out/magisk-module-release.zip out/magisk-module