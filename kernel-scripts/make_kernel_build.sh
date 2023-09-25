#!/bin/bash

echo "configure build output path..."
KERNEL_TOP_PATH="$(cd "$(dirname "$0")"; pwd -P)"
OUTPUT_PATH="$KERNEL_TOP_PATH/arm_kernel_out" # use custom build artifact path
echo "Output Path: ${OUTPUT_PATH}"

BUILD_LOG_PATH="$KERNEL_TOP_PATH/kernel_build.log"

echo "move to kernel source tree..."
cd linux-kernel-arm

echo "make kernel build..."
make O=$OUTPUT_PATH ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc) 2>&1 | tee $BUILD_LOG_PATH
