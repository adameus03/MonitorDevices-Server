# Install script for directory: /home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/trace.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/platform.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/check_macros.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/opt_set.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/time.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_wait.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/wait.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/size_util.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_tune.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/tune.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_system_aligned_alloc.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/system_aligned_alloc.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_prepacked_cache.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/prepacked_cache.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_allocator.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/allocator.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/side_pair.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_block_map.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/block_map.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_blocking_counter.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/blocking_counter.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_thread_pool.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/thread_pool.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/cpu_cache_params.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_cpuinfo.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/cpuinfo.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/path.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_denormal.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/denormal.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/performance_advisory.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/matrix.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/mul_params.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/mat.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/asm_helpers.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_apply_multiplier.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/apply_multiplier.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/kernel_common.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/pack_common.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_kernel_arm.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/kernel_arm.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_pack_arm.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/pack_arm.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_kernel_avx512.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/kernel_x86.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_pack_avx512.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/pack_x86.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_have_built_path_for_avx512.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/have_built_path_for.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_kernel_avx2_fma.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/kernel_x86.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_pack_avx2_fma.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/pack_x86.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_have_built_path_for_avx2_fma.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/have_built_path_for.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_kernel_avx.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/kernel_x86.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_pack_avx.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/pack_x86.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_have_built_path_for_avx.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/have_built_path_for.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/kernel.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/pack.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/have_built_path_for.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_context.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/context.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_ctx.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES
    "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/ctx.h"
    "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/ctx_impl.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_context_get_ctx.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/context_get_ctx.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/trmul_params.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_trmul.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/trmul.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_prepare_packed_matrices.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/prepare_packed_matrices.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/create_trmul_params.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/validate.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/libruy_frontend.a")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/frontend.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES
    "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/context.h"
    "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/matrix.h"
    "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/mul_params.h"
    "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/path.h"
    "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/ruy.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/build/ruy/ruy" TYPE FILE FILES "/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/ruy/ruy/reference_mul.h")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/mundus/base/esp/esp32_cam_surv_ai/server/analysis/inference/build/_deps/ruy-build/ruy/profiler/cmake_install.cmake")

endif()

