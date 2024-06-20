#!/bin/bash

# [WARNING] Not tested, WIP. Better do those steps manually and adjust to the system.

# [TODO] Adjust the paths, handle errors, etc.

sudo apt-get install -y cmake g++ git libeigen3-dev libabsl-dev libgemmlowp-dev libneon2sse-dev libfarmhash-dev libpthreadpool-dev libruy-dev libpthreadpool-dev

# [TODO] Build and install flatbuffers and ruy

mkdir tflite_build
cd tflite_build
cmake ../base/esp/esp32_cam_surv_ai/server/analysis/tensorflow/tensorflow/lite -DTFLITE_ENABLE_INSTALL=ON \
  -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON \
  -DSYSTEM_FARMHASH=ON \
  -DSYSTEM_PTHREADPOOL=ON \
  -Dabsl_DIR=/usr/lib/x86_64-linux-gnu/cmake/absl \
  -DEigen3_DIR=/usr/share/eigen3/cmake \
  -DFlatBuffers_DIR=/usr/local/lib/cmake/flatbuffers \
  -Dgemmlowp_DIR=/usr/lib/x86_64-linux-gnu/cmake/gemmlowp \
  -DNEON_2_SSE_DIR=/usr/lib/cmake/NEON_2_SSE \
  -Dcpuinfo_DIR=/usr/bin/cpu-info \
  -Druy_DIR=/usr/local/lib/cmake/ruy

cmake --build -j16 .