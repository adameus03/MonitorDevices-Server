# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16-source"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16-download/fp16-prefix"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16-download/fp16-prefix/tmp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16-download/fp16-prefix/src/fp16-stamp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16-download/fp16-prefix/src"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16-download/fp16-prefix/src/fp16-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16-download/fp16-prefix/src/fp16-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FP16-download/fp16-prefix/src/fp16-stamp${cfgdir}") # cfgdir has leading slash
endif()
