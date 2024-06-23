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
include CMakeFiles/minimal.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/minimal.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/minimal.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/minimal.dir/flags.make

CMakeFiles/minimal.dir/main.cc.o: CMakeFiles/minimal.dir/flags.make
CMakeFiles/minimal.dir/main.cc.o: /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/main.cc
CMakeFiles/minimal.dir/main.cc.o: CMakeFiles/minimal.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/minimal.dir/main.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/minimal.dir/main.cc.o -MF CMakeFiles/minimal.dir/main.cc.o.d -o CMakeFiles/minimal.dir/main.cc.o -c /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/main.cc

CMakeFiles/minimal.dir/main.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/minimal.dir/main.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/main.cc > CMakeFiles/minimal.dir/main.cc.i

CMakeFiles/minimal.dir/main.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/minimal.dir/main.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/main.cc -o CMakeFiles/minimal.dir/main.cc.s

# Object files for target minimal
minimal_OBJECTS = \
"CMakeFiles/minimal.dir/main.cc.o"

# External object files for target minimal
minimal_EXTERNAL_OBJECTS =

minimal: CMakeFiles/minimal.dir/main.cc.o
minimal: CMakeFiles/minimal.dir/build.make
minimal: tensorflow-lite/libtensorflow-lite.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags_internal.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags_marshalling.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags_reflection.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags_config.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags_program_name.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags_private_handle_accessor.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags_commandlineflag.a
minimal: _deps/abseil-cpp-build/absl/flags/libabsl_flags_commandlineflag_internal.a
minimal: _deps/abseil-cpp-build/absl/container/libabsl_raw_hash_set.a
minimal: _deps/abseil-cpp-build/absl/container/libabsl_hashtablez_sampler.a
minimal: _deps/abseil-cpp-build/absl/hash/libabsl_hash.a
minimal: _deps/abseil-cpp-build/absl/hash/libabsl_city.a
minimal: _deps/abseil-cpp-build/absl/hash/libabsl_low_level_hash.a
minimal: _deps/abseil-cpp-build/absl/status/libabsl_status.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_cord.a
minimal: _deps/abseil-cpp-build/absl/types/libabsl_bad_optional_access.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_cordz_info.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_cord_internal.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_cordz_functions.a
minimal: _deps/abseil-cpp-build/absl/profiling/libabsl_exponential_biased.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_cordz_handle.a
minimal: _deps/abseil-cpp-build/absl/crc/libabsl_crc_cord_state.a
minimal: _deps/abseil-cpp-build/absl/crc/libabsl_crc32c.a
minimal: _deps/abseil-cpp-build/absl/crc/libabsl_crc_internal.a
minimal: _deps/abseil-cpp-build/absl/crc/libabsl_crc_cpu_detect.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_str_format_internal.a
minimal: _deps/abseil-cpp-build/absl/base/libabsl_strerror.a
minimal: _deps/abseil-cpp-build/absl/synchronization/libabsl_synchronization.a
minimal: _deps/abseil-cpp-build/absl/debugging/libabsl_stacktrace.a
minimal: _deps/abseil-cpp-build/absl/debugging/libabsl_symbolize.a
minimal: _deps/abseil-cpp-build/absl/debugging/libabsl_debugging_internal.a
minimal: _deps/abseil-cpp-build/absl/debugging/libabsl_demangle_internal.a
minimal: _deps/abseil-cpp-build/absl/synchronization/libabsl_graphcycles_internal.a
minimal: _deps/abseil-cpp-build/absl/synchronization/libabsl_kernel_timeout_internal.a
minimal: _deps/abseil-cpp-build/absl/base/libabsl_malloc_internal.a
minimal: _deps/abseil-cpp-build/absl/time/libabsl_time.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_strings.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_string_view.a
minimal: _deps/abseil-cpp-build/absl/strings/libabsl_strings_internal.a
minimal: _deps/abseil-cpp-build/absl/base/libabsl_throw_delegate.a
minimal: _deps/abseil-cpp-build/absl/base/libabsl_base.a
minimal: _deps/abseil-cpp-build/absl/base/libabsl_spinlock_wait.a
minimal: _deps/abseil-cpp-build/absl/numeric/libabsl_int128.a
minimal: _deps/abseil-cpp-build/absl/time/libabsl_civil_time.a
minimal: _deps/abseil-cpp-build/absl/time/libabsl_time_zone.a
minimal: _deps/abseil-cpp-build/absl/types/libabsl_bad_variant_access.a
minimal: _deps/abseil-cpp-build/absl/base/libabsl_raw_logging_internal.a
minimal: _deps/abseil-cpp-build/absl/base/libabsl_log_severity.a
minimal: _deps/farmhash-build/libfarmhash.a
minimal: _deps/fft2d-build/libfft2d_fftsg2d.a
minimal: _deps/fft2d-build/libfft2d_fftsg.a
minimal: _deps/flatbuffers-build/libflatbuffers.a
minimal: _deps/gemmlowp-build/libeight_bit_int_gemm.a
minimal: _deps/ruy-build/ruy/libruy_context_get_ctx.a
minimal: _deps/ruy-build/ruy/libruy_context.a
minimal: _deps/ruy-build/ruy/libruy_frontend.a
minimal: _deps/ruy-build/ruy/libruy_kernel_arm.a
minimal: _deps/ruy-build/ruy/libruy_kernel_avx.a
minimal: _deps/ruy-build/ruy/libruy_kernel_avx2_fma.a
minimal: _deps/ruy-build/ruy/libruy_kernel_avx512.a
minimal: _deps/ruy-build/ruy/libruy_apply_multiplier.a
minimal: _deps/ruy-build/ruy/libruy_pack_arm.a
minimal: _deps/ruy-build/ruy/libruy_pack_avx.a
minimal: _deps/ruy-build/ruy/libruy_pack_avx2_fma.a
minimal: _deps/ruy-build/ruy/libruy_pack_avx512.a
minimal: _deps/ruy-build/ruy/libruy_prepare_packed_matrices.a
minimal: _deps/ruy-build/ruy/libruy_trmul.a
minimal: _deps/ruy-build/ruy/libruy_ctx.a
minimal: _deps/ruy-build/ruy/libruy_allocator.a
minimal: _deps/ruy-build/ruy/libruy_prepacked_cache.a
minimal: _deps/ruy-build/ruy/libruy_system_aligned_alloc.a
minimal: _deps/ruy-build/ruy/libruy_have_built_path_for_avx.a
minimal: _deps/ruy-build/ruy/libruy_have_built_path_for_avx2_fma.a
minimal: _deps/ruy-build/ruy/libruy_have_built_path_for_avx512.a
minimal: _deps/ruy-build/ruy/libruy_thread_pool.a
minimal: _deps/ruy-build/ruy/libruy_blocking_counter.a
minimal: _deps/ruy-build/ruy/libruy_wait.a
minimal: _deps/ruy-build/ruy/libruy_denormal.a
minimal: _deps/ruy-build/ruy/libruy_block_map.a
minimal: _deps/ruy-build/ruy/libruy_tune.a
minimal: _deps/ruy-build/ruy/libruy_cpuinfo.a
minimal: _deps/ruy-build/ruy/profiler/libruy_profiler_instrumentation.a
minimal: _deps/xnnpack-build/libXNNPACK.a
minimal: pthreadpool/libpthreadpool.a
minimal: /usr/lib/x86_64-linux-gnu/libm.so
minimal: _deps/cpuinfo-build/libcpuinfo.a
minimal: CMakeFiles/minimal.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable minimal"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/minimal.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/minimal.dir/build: minimal
.PHONY : CMakeFiles/minimal.dir/build

CMakeFiles/minimal.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/minimal.dir/cmake_clean.cmake
.PHONY : CMakeFiles/minimal.dir/clean

CMakeFiles/minimal.dir/depend:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles/minimal.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/minimal.dir/depend

