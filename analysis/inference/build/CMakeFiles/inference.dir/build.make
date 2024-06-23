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
include CMakeFiles/inference.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/inference.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/inference.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/inference.dir/flags.make

CMakeFiles/inference.dir/converter.c.o: CMakeFiles/inference.dir/flags.make
CMakeFiles/inference.dir/converter.c.o: /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/converter.c
CMakeFiles/inference.dir/converter.c.o: CMakeFiles/inference.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/inference.dir/converter.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/inference.dir/converter.c.o -MF CMakeFiles/inference.dir/converter.c.o.d -o CMakeFiles/inference.dir/converter.c.o -c /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/converter.c

CMakeFiles/inference.dir/converter.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/inference.dir/converter.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/converter.c > CMakeFiles/inference.dir/converter.c.i

CMakeFiles/inference.dir/converter.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/inference.dir/converter.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/converter.c -o CMakeFiles/inference.dir/converter.c.s

CMakeFiles/inference.dir/tl_infer_agent.cc.o: CMakeFiles/inference.dir/flags.make
CMakeFiles/inference.dir/tl_infer_agent.cc.o: /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/tl_infer_agent.cc
CMakeFiles/inference.dir/tl_infer_agent.cc.o: CMakeFiles/inference.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/inference.dir/tl_infer_agent.cc.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/inference.dir/tl_infer_agent.cc.o -MF CMakeFiles/inference.dir/tl_infer_agent.cc.o.d -o CMakeFiles/inference.dir/tl_infer_agent.cc.o -c /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/tl_infer_agent.cc

CMakeFiles/inference.dir/tl_infer_agent.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/inference.dir/tl_infer_agent.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/tl_infer_agent.cc > CMakeFiles/inference.dir/tl_infer_agent.cc.i

CMakeFiles/inference.dir/tl_infer_agent.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/inference.dir/tl_infer_agent.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/tl_infer_agent.cc -o CMakeFiles/inference.dir/tl_infer_agent.cc.s

CMakeFiles/inference.dir/main.c.o: CMakeFiles/inference.dir/flags.make
CMakeFiles/inference.dir/main.c.o: /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/main.c
CMakeFiles/inference.dir/main.c.o: CMakeFiles/inference.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/inference.dir/main.c.o"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/inference.dir/main.c.o -MF CMakeFiles/inference.dir/main.c.o.d -o CMakeFiles/inference.dir/main.c.o -c /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/main.c

CMakeFiles/inference.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/inference.dir/main.c.i"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/main.c > CMakeFiles/inference.dir/main.c.i

CMakeFiles/inference.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/inference.dir/main.c.s"
	/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/main.c -o CMakeFiles/inference.dir/main.c.s

# Object files for target inference
inference_OBJECTS = \
"CMakeFiles/inference.dir/converter.c.o" \
"CMakeFiles/inference.dir/tl_infer_agent.cc.o" \
"CMakeFiles/inference.dir/main.c.o"

# External object files for target inference
inference_EXTERNAL_OBJECTS =

inference: CMakeFiles/inference.dir/converter.c.o
inference: CMakeFiles/inference.dir/tl_infer_agent.cc.o
inference: CMakeFiles/inference.dir/main.c.o
inference: CMakeFiles/inference.dir/build.make
inference: tensorflow-lite/libtensorflow-lite.a
inference: /usr/lib/x86_64-linux-gnu/libjpeg.so
inference: /usr/lib/x86_64-linux-gnu/libturbojpeg.so
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags.a
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags_internal.a
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags_marshalling.a
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags_reflection.a
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags_config.a
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags_program_name.a
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags_private_handle_accessor.a
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags_commandlineflag.a
inference: _deps/abseil-cpp-build/absl/flags/libabsl_flags_commandlineflag_internal.a
inference: _deps/abseil-cpp-build/absl/container/libabsl_raw_hash_set.a
inference: _deps/abseil-cpp-build/absl/container/libabsl_hashtablez_sampler.a
inference: _deps/abseil-cpp-build/absl/hash/libabsl_hash.a
inference: _deps/abseil-cpp-build/absl/hash/libabsl_city.a
inference: _deps/abseil-cpp-build/absl/hash/libabsl_low_level_hash.a
inference: _deps/abseil-cpp-build/absl/status/libabsl_status.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_cord.a
inference: _deps/abseil-cpp-build/absl/types/libabsl_bad_optional_access.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_cordz_info.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_cord_internal.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_cordz_functions.a
inference: _deps/abseil-cpp-build/absl/profiling/libabsl_exponential_biased.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_cordz_handle.a
inference: _deps/abseil-cpp-build/absl/crc/libabsl_crc_cord_state.a
inference: _deps/abseil-cpp-build/absl/crc/libabsl_crc32c.a
inference: _deps/abseil-cpp-build/absl/crc/libabsl_crc_internal.a
inference: _deps/abseil-cpp-build/absl/crc/libabsl_crc_cpu_detect.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_str_format_internal.a
inference: _deps/abseil-cpp-build/absl/base/libabsl_strerror.a
inference: _deps/abseil-cpp-build/absl/synchronization/libabsl_synchronization.a
inference: _deps/abseil-cpp-build/absl/debugging/libabsl_stacktrace.a
inference: _deps/abseil-cpp-build/absl/debugging/libabsl_symbolize.a
inference: _deps/abseil-cpp-build/absl/debugging/libabsl_debugging_internal.a
inference: _deps/abseil-cpp-build/absl/debugging/libabsl_demangle_internal.a
inference: _deps/abseil-cpp-build/absl/synchronization/libabsl_graphcycles_internal.a
inference: _deps/abseil-cpp-build/absl/synchronization/libabsl_kernel_timeout_internal.a
inference: _deps/abseil-cpp-build/absl/base/libabsl_malloc_internal.a
inference: _deps/abseil-cpp-build/absl/time/libabsl_time.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_strings.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_string_view.a
inference: _deps/abseil-cpp-build/absl/strings/libabsl_strings_internal.a
inference: _deps/abseil-cpp-build/absl/base/libabsl_throw_delegate.a
inference: _deps/abseil-cpp-build/absl/base/libabsl_base.a
inference: _deps/abseil-cpp-build/absl/base/libabsl_spinlock_wait.a
inference: _deps/abseil-cpp-build/absl/numeric/libabsl_int128.a
inference: _deps/abseil-cpp-build/absl/time/libabsl_civil_time.a
inference: _deps/abseil-cpp-build/absl/time/libabsl_time_zone.a
inference: _deps/abseil-cpp-build/absl/types/libabsl_bad_variant_access.a
inference: _deps/abseil-cpp-build/absl/base/libabsl_raw_logging_internal.a
inference: _deps/abseil-cpp-build/absl/base/libabsl_log_severity.a
inference: _deps/farmhash-build/libfarmhash.a
inference: _deps/fft2d-build/libfft2d_fftsg2d.a
inference: _deps/fft2d-build/libfft2d_fftsg.a
inference: _deps/flatbuffers-build/libflatbuffers.a
inference: _deps/gemmlowp-build/libeight_bit_int_gemm.a
inference: _deps/ruy-build/ruy/libruy_context_get_ctx.a
inference: _deps/ruy-build/ruy/libruy_context.a
inference: _deps/ruy-build/ruy/libruy_frontend.a
inference: _deps/ruy-build/ruy/libruy_kernel_arm.a
inference: _deps/ruy-build/ruy/libruy_kernel_avx.a
inference: _deps/ruy-build/ruy/libruy_kernel_avx2_fma.a
inference: _deps/ruy-build/ruy/libruy_kernel_avx512.a
inference: _deps/ruy-build/ruy/libruy_apply_multiplier.a
inference: _deps/ruy-build/ruy/libruy_pack_arm.a
inference: _deps/ruy-build/ruy/libruy_pack_avx.a
inference: _deps/ruy-build/ruy/libruy_pack_avx2_fma.a
inference: _deps/ruy-build/ruy/libruy_pack_avx512.a
inference: _deps/ruy-build/ruy/libruy_prepare_packed_matrices.a
inference: _deps/ruy-build/ruy/libruy_trmul.a
inference: _deps/ruy-build/ruy/libruy_ctx.a
inference: _deps/ruy-build/ruy/libruy_allocator.a
inference: _deps/ruy-build/ruy/libruy_prepacked_cache.a
inference: _deps/ruy-build/ruy/libruy_system_aligned_alloc.a
inference: _deps/ruy-build/ruy/libruy_have_built_path_for_avx.a
inference: _deps/ruy-build/ruy/libruy_have_built_path_for_avx2_fma.a
inference: _deps/ruy-build/ruy/libruy_have_built_path_for_avx512.a
inference: _deps/ruy-build/ruy/libruy_thread_pool.a
inference: _deps/ruy-build/ruy/libruy_blocking_counter.a
inference: _deps/ruy-build/ruy/libruy_wait.a
inference: _deps/ruy-build/ruy/libruy_denormal.a
inference: _deps/ruy-build/ruy/libruy_block_map.a
inference: _deps/ruy-build/ruy/libruy_tune.a
inference: _deps/ruy-build/ruy/libruy_cpuinfo.a
inference: _deps/ruy-build/ruy/profiler/libruy_profiler_instrumentation.a
inference: _deps/xnnpack-build/libXNNPACK.a
inference: pthreadpool/libpthreadpool.a
inference: /usr/lib/x86_64-linux-gnu/libm.so
inference: _deps/cpuinfo-build/libcpuinfo.a
inference: CMakeFiles/inference.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable inference"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/inference.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/inference.dir/build: inference
.PHONY : CMakeFiles/inference.dir/build

CMakeFiles/inference.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/inference.dir/cmake_clean.cmake
.PHONY : CMakeFiles/inference.dir/clean

CMakeFiles/inference.dir/depend:
	cd /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/CMakeFiles/inference.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/inference.dir/depend

