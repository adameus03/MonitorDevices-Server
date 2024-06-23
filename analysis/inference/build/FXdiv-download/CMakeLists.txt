CMAKE_MINIMUM_REQUIRED(VERSION 3.5 FATAL_ERROR)

PROJECT(fxdiv-download NONE)

INCLUDE(ExternalProject)
ExternalProject_Add(fxdiv
	GIT_REPOSITORY https://github.com/Maratyszcza/FXdiv.git
	GIT_TAG master
	SOURCE_DIR "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FXdiv-source"
	BINARY_DIR "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/FXdiv"
	CONFIGURE_COMMAND ""
	BUILD_COMMAND ""
	INSTALL_COMMAND ""
	TEST_COMMAND ""
)
