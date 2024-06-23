# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool-source"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool-download/pthreadpool-prefix"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool-download/pthreadpool-prefix/tmp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool-download/pthreadpool-prefix/src/pthreadpool-stamp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool-download/pthreadpool-prefix/src"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool-download/pthreadpool-prefix/src/pthreadpool-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool-download/pthreadpool-prefix/src/pthreadpool-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/pthreadpool-download/pthreadpool-prefix/src/pthreadpool-stamp${cfgdir}") # cfgdir has leading slash
endif()
