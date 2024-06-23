# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.25.1)

# We name the project and the target for the ExternalProject_Add() call
# to something that will highlight to the user what we are working on if
# something goes wrong and an error message is produced.

project(flatbuffers-populate NONE)


# Pass through things we've already detected in the main project to avoid
# paying the cost of redetecting them again in ExternalProject_Add()
set(GIT_EXECUTABLE [==[/usr/bin/git]==])
set(GIT_VERSION_STRING [==[2.39.2]==])
set_property(GLOBAL PROPERTY _CMAKE_FindGit_GIT_EXECUTABLE_VERSION
  [==[/usr/bin/git;2.39.2]==]
)


include(ExternalProject)
ExternalProject_Add(flatbuffers-populate
                     "UPDATE_DISCONNECTED" "False" "GIT_REPOSITORY" "https://github.com/google/flatbuffers" "GIT_TAG" "e6463926479bd6b330cbcf673f7e917803fd5831" "GIT_SHALLOW" "FALSE" "GIT_PROGRESS" "TRUE"
                    SOURCE_DIR          "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/flatbuffers"
                    BINARY_DIR          "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/flatbuffers-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
                    USES_TERMINAL_PATCH     YES
)


