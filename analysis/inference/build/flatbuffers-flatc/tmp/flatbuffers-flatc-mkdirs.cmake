# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers-flatc/src/flatbuffers-flatc-build"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers-flatc"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers-flatc/tmp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers-flatc/src/flatbuffers-flatc-stamp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers-flatc/src"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers-flatc/src/flatbuffers-flatc-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers-flatc/src/flatbuffers-flatc-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers-flatc/src/flatbuffers-flatc-stamp${cfgdir}") # cfgdir has leading slash
endif()
