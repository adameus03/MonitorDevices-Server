cmake_minimum_required(VERSION 3.16)
project(inference C CXX)

set(TENSORFLOW_SOURCE_DIR "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/tensorflow" )
if(NOT TENSORFLOW_SOURCE_DIR)
  get_filename_component(TENSORFLOW_SOURCE_DIR
    "${CMAKE_CURRENT_LIST_DIR}/../../../../" ABSOLUTE)
endif()

add_subdirectory(
  "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/tensorflow/tensorflow/lite"
  "${CMAKE_CURRENT_BINARY_DIR}/tensorflow-lite" EXCLUDE_FROM_ALL)

add_executable(inference main.cc)
target_link_libraries(inference tensorflow-lite)
