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
include _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/compiler_depend.make

# Include the progress variables for this target.
include _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/progress.make

# Include the compile flags for this target's objects.
include _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/flags.make

_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/tune.cc.o: _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/flags.make
_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/tune.cc.o: ruy/ruy/tune.cc
_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/tune.cc.o: _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/tune.cc.o"
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/tune.cc.o -MF CMakeFiles/ruy_tune.dir/tune.cc.o.d -o CMakeFiles/ruy_tune.dir/tune.cc.o -c /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/tune.cc

_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/tune.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ruy_tune.dir/tune.cc.i"
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/tune.cc > CMakeFiles/ruy_tune.dir/tune.cc.i

_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/tune.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ruy_tune.dir/tune.cc.s"
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/tune.cc -o CMakeFiles/ruy_tune.dir/tune.cc.s

# Object files for target ruy_tune
ruy_tune_OBJECTS = \
"CMakeFiles/ruy_tune.dir/tune.cc.o"

# External object files for target ruy_tune
ruy_tune_EXTERNAL_OBJECTS =

_deps/ruy-build/ruy/libruy_tune.a: _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/tune.cc.o
_deps/ruy-build/ruy/libruy_tune.a: _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/build.make
_deps/ruy-build/ruy/libruy_tune.a: _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX static library libruy_tune.a"
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy && $(CMAKE_COMMAND) -P CMakeFiles/ruy_tune.dir/cmake_clean_target.cmake
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ruy_tune.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/build: _deps/ruy-build/ruy/libruy_tune.a
.PHONY : _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/build

_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/clean:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy && $(CMAKE_COMMAND) -P CMakeFiles/ruy_tune.dir/cmake_clean.cmake
.PHONY : _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/clean

_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/depend:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : _deps/ruy-build/ruy/CMakeFiles/ruy_tune.dir/depend

