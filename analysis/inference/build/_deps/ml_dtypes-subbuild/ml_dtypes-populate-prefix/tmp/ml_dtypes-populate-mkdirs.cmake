# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ml_dtypes"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-build"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/tmp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src"
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp${cfgdir}") # cfgdir has leading slash
endif()
