# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.25

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build

# Utility rule file for ContinuousTest.

# Include any custom commands dependencies for this target.
include _deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/compiler_depend.make

# Include the progress variables for this target.
include _deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/progress.make

_deps/abseil-cpp-build/CMakeFiles/ContinuousTest:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/abseil-cpp-build && /usr/bin/ctest -D ContinuousTest

ContinuousTest: _deps/abseil-cpp-build/CMakeFiles/ContinuousTest
ContinuousTest: _deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/build.make
.PHONY : ContinuousTest

# Rule to build all files generated by this target.
_deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/build: ContinuousTest
.PHONY : _deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/build

_deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/clean:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/abseil-cpp-build && $(CMAKE_COMMAND) -P CMakeFiles/ContinuousTest.dir/cmake_clean.cmake
.PHONY : _deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/clean

_deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/depend:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/abseil-cpp /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/abseil-cpp-build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : _deps/abseil-cpp-build/CMakeFiles/ContinuousTest.dir/depend

