#!/bin/bash
set -e

BASE_URL="https://android.googlesource.com"
DEFAULT_REV="master-kernel-build-2022"

PREBUILTS_BASE="kernel_platform"

declare -A PREBUILTS=(
  ["prebuilts/clang/host/linux-x86"]="platform/prebuilts/clang/host/linux-x86"
  ["prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8"]="platform/prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.17-4.8"
  ["prebuilts/build-tools"]="platform/prebuilts/build-tools"
  ["prebuilts/kernel-build-tools"]="kernel/prebuilts/build-tools"
  ["prebuilts/bazel/linux-x86_64"]="platform/prebuilts/bazel/linux-x86_64"
  ["prebuilts/jdk/jdk11"]="platform/prebuilts/jdk/jdk11"
  ["prebuilts/ndk-r23"]="toolchain/prebuilts/ndk/r23"
)

echo "starting download of prebuilts..."

for path in "${!PREBUILTS[@]}"; do
  name="${PREBUILTS[$path]}"
  url="${BASE_URL}/${name}"
  
  echo "cloning ${name} into ${PREBUILTS_BASE}/${path}..."
  
  if [ -d "$PREBUILTS_BASE/$path" ]; then
    echo "> $PREBUILTS_BASE/$path already exists. skipping."
    continue
  fi
  
  git clone "${url}" "$PREBUILTS_BASE/$path" -b "${DEFAULT_REV}" --depth=1 --single-branch
  du -sh "$PREBUILTS_BASE/$path/.git"
  rm -rf "$PREBUILTS_BASE/$path/.git"
done

echo "all prebuilts downloaded successfully"
