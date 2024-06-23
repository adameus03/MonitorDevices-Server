# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/protobuf"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/protobuf-build"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/tmp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/src/protobuf-populate-stamp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/src"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/src/protobuf-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/src/protobuf-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/src/protobuf-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
