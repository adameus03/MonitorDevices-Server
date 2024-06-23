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

# Include any dependencies generated for this target.
include _deps/xnnpack-build/CMakeFiles/microparams-init.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include _deps/xnnpack-build/CMakeFiles/microparams-init.dir/compiler_depend.make

# Include the progress variables for this target.
include _deps/xnnpack-build/CMakeFiles/microparams-init.dir/progress.make

# Include the compile flags for this target's objects.
include _deps/xnnpack-build/CMakeFiles/microparams-init.dir/flags.make

_deps/xnnpack-build/CMakeFiles/microparams-init.dir/src/microparams-init.c.o: _deps/xnnpack-build/CMakeFiles/microparams-init.dir/flags.make
_deps/xnnpack-build/CMakeFiles/microparams-init.dir/src/microparams-init.c.o: xnnpack/src/microparams-init.c
_deps/xnnpack-build/CMakeFiles/microparams-init.dir/src/microparams-init.c.o: _deps/xnnpack-build/CMakeFiles/microparams-init.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object _deps/xnnpack-build/CMakeFiles/microparams-init.dir/src/microparams-init.c.o"
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/xnnpack-build && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT _deps/xnnpack-build/CMakeFiles/microparams-init.dir/src/microparams-init.c.o -MF CMakeFiles/microparams-init.dir/src/microparams-init.c.o.d -o CMakeFiles/microparams-init.dir/src/microparams-init.c.o -c /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/xnnpack/src/microparams-init.c

_deps/xnnpack-build/CMakeFiles/microparams-init.dir/src/microparams-init.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/microparams-init.dir/src/microparams-init.c.i"
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/xnnpack-build && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/xnnpack/src/microparams-init.c > CMakeFiles/microparams-init.dir/src/microparams-init.c.i

_deps/xnnpack-build/CMakeFiles/microparams-init.dir/src/microparams-init.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/microparams-init.dir/src/microparams-init.c.s"
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/xnnpack-build && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/xnnpack/src/microparams-init.c -o CMakeFiles/microparams-init.dir/src/microparams-init.c.s

microparams-init: _deps/xnnpack-build/CMakeFiles/microparams-init.dir/src/microparams-init.c.o
microparams-init: _deps/xnnpack-build/CMakeFiles/microparams-init.dir/build.make
.PHONY : microparams-init

# Rule to build all files generated by this target.
_deps/xnnpack-build/CMakeFiles/microparams-init.dir/build: microparams-init
.PHONY : _deps/xnnpack-build/CMakeFiles/microparams-init.dir/build

_deps/xnnpack-build/CMakeFiles/microparams-init.dir/clean:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/xnnpack-build && $(CMAKE_COMMAND) -P CMakeFiles/microparams-init.dir/cmake_clean.cmake
.PHONY : _deps/xnnpack-build/CMakeFiles/microparams-init.dir/clean

_deps/xnnpack-build/CMakeFiles/microparams-init.dir/depend:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/xnnpack /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/xnnpack-build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/xnnpack-build/CMakeFiles/microparams-init.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : _deps/xnnpack-build/CMakeFiles/microparams-init.dir/depend

