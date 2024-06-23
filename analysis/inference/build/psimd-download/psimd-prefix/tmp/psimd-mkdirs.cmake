# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd-source"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd-download/psimd-prefix"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd-download/psimd-prefix/tmp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd-download/psimd-prefix/src/psimd-stamp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd-download/psimd-prefix/src"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd-download/psimd-prefix/src/psimd-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd-download/psimd-prefix/src/psimd-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/psimd-download/psimd-prefix/src/psimd-stamp${cfgdir}") # cfgdir has leading slash
endif()
