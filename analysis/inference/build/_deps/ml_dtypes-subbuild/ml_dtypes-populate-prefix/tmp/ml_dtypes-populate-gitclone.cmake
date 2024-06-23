# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

if(EXISTS "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/ml_dtypes-populate-gitclone-lastrun.txt" AND EXISTS "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/ml_dtypes-populate-gitinfo.txt" AND
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/ml_dtypes-populate-gitclone-lastrun.txt" IS_NEWER_THAN "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/ml_dtypes-populate-gitinfo.txt")
  message(STATUS
    "Avoiding repeated git clone, stamp file is up to date: "
    "'/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/ml_dtypes-populate-gitclone-lastrun.txt'"
  )
  return()
endif()

execute_process(
  COMMAND ${CMAKE_COMMAND} -E rm -rf "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ml_dtypes"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to remove directory: '/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ml_dtypes'")
endif()

# try the clone 3 times in case there is an odd git clone issue
set(error_code 1)
set(number_of_tries 0)
while(error_code AND number_of_tries LESS 3)
  execute_process(
    COMMAND "/usr/bin/git" 
            clone --no-checkout --progress --config "advice.detachedHead=false" "https://github.com/jax-ml/ml_dtypes" "ml_dtypes"
    WORKING_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build"
    RESULT_VARIABLE error_code
  )
  math(EXPR number_of_tries "${number_of_tries} + 1")
endwhile()
if(number_of_tries GREATER 1)
  message(STATUS "Had to git clone more than once: ${number_of_tries} times.")
endif()
if(error_code)
  message(FATAL_ERROR "Failed to clone repository: 'https://github.com/jax-ml/ml_dtypes'")
endif()

execute_process(
  COMMAND "/usr/bin/git" 
          checkout "24084d9ed2c3d45bf83b7a9bff833aa185bf9172" --
  WORKING_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ml_dtypes"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to checkout tag: '24084d9ed2c3d45bf83b7a9bff833aa185bf9172'")
endif()

set(init_submodules TRUE)
if(init_submodules)
  execute_process(
    COMMAND "/usr/bin/git" 
            submodule update --recursive --init 
    WORKING_DIRECTORY "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ml_dtypes"
    RESULT_VARIABLE error_code
  )
endif()
if(error_code)
  message(FATAL_ERROR "Failed to update submodules in: '/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ml_dtypes'")
endif()

# Complete success, update the script-last-run stamp file:
#
execute_process(
  COMMAND ${CMAKE_COMMAND} -E copy "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/ml_dtypes-populate-gitinfo.txt" "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/ml_dtypes-populate-gitclone-lastrun.txt"
  RESULT_VARIABLE error_code
)
if(error_code)
  message(FATAL_ERROR "Failed to copy script-last-run stamp file: '/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ml_dtypes-subbuild/ml_dtypes-populate-prefix/src/ml_dtypes-populate-stamp/ml_dtypes-populate-gitclone-lastrun.txt'")
endif()
