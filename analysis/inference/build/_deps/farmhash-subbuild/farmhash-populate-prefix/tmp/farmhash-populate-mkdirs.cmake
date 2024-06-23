# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/farmhash"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/farmhash-build"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/farmhash-subbuild/farmhash-populate-prefix"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/farmhash-subbuild/farmhash-populate-prefix/tmp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/farmhash-subbuild/farmhash-populate-prefix/src/farmhash-populate-stamp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/farmhash-subbuild/farmhash-populate-prefix/src"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/farmhash-subbuild/farmhash-populate-prefix/src/farmhash-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/farmhash-subbuild/farmhash-populate-prefix/src/farmhash-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/farmhash-subbuild/farmhash-populate-prefix/src/farmhash-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
