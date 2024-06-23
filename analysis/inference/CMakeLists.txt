cmake_minimum_required(VERSION 3.16)
project(inference LANGUAGES C CXX)

set(TENSORFLOW_SOURCE_DIR "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/tensorflow" )
if(NOT TENSORFLOW_SOURCE_DIR)
  get_filename_component(TENSORFLOW_SOURCE_DIR
    "${CMAKE_CURRENT_LIST_DIR}/../../../../" ABSOLUTE)
endif()

add_subdirectory(
  "${TENSORFLOW_SOURCE_DIR}/tensorflow/lite"
  "${CMAKE_CURRENT_BINARY_DIR}/tensorflow-lite" EXCLUDE_FROM_ALL)


find_package(JPEG REQUIRED)
include_directories(${JPEG_INCLUDE_DIR})
message(STATUS "JPEG_INCLUDE_DIR: ${JPEG_INCLUDE_DIR}")
message(STATUS "JPEG_LIBRARIES: ${JPEG_LIBRARIES}")

find_package(libjpeg-turbo REQUIRED)
# include_directories(${libjpeg-turbo_INCLUDE_DIRS})
# message(STATUS "libjpeg-turbo_INCLUDE_DIRS: ${libjpeg-turbo_INCLUDE_DIRS}")
# message(STATUS "libjpeg-turbo_LIBRARIES: ${libjpeg-turbo_LIBRARIES}")
set(JPEG_TURBO_INCLUDE_DIR ${JPEG_INCLUDE_DIR})
set(JPEG_TURBO_LIBRARIES /usr/lib/x86_64-linux-gnu/libturbojpeg.so) # [TODO] find_package(libjpeg-turbo) wasn't filling this, so I did it manually
include_directories(${JPEG_TURBO_INCLUDE_DIR})

#include_directories(.) # for converter.h
#link_directories(.)


add_executable(inference converter.c tl_infer_agent.cc main.c)
target_link_libraries(inference tensorflow-lite ${JPEG_LIBRARIES} ${JPEG_TURBO_LIBRARIES})

