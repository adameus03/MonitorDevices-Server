# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.25.1)

# We name the project and the target for the ExternalProject_Add() call
# to something that will highlight to the user what we are working on if
# something goes wrong and an error message is produced.

project(fft2d-populate NONE)



include(ExternalProject)
ExternalProject_Add(fft2d-populate
                     "UPDATE_DISCONNECTED" "False" "DOWNLOAD_EXTRACT_TIMESTAMP" "TRUE" "URL" "https://storage.googleapis.com/mirror.tensorflow.org/github.com/petewarden/OouraFFT/archive/v1.0.tar.gz" "URL_HASH" "SHA256=5f4dabc2ae21e1f537425d58a49cdca1c49ea11db0d6271e2a4b27e9697548eb"
                    SOURCE_DIR          "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/fft2d"
                    BINARY_DIR          "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/fft2d-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
                    USES_TERMINAL_DOWNLOAD  YES
                    USES_TERMINAL_UPDATE    YES
                    USES_TERMINAL_PATCH     YES
)


