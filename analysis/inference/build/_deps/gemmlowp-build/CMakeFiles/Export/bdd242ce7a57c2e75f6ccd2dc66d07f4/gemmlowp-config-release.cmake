#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "gemmlowp::eight_bit_int_gemm" for configuration "Release"
set_property(TARGET gemmlowp::eight_bit_int_gemm APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(gemmlowp::eight_bit_int_gemm PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libeight_bit_int_gemm.a"
  )

list(APPEND _cmake_import_check_targets gemmlowp::eight_bit_int_gemm )
list(APPEND _cmake_import_check_files_for_gemmlowp::eight_bit_int_gemm "${_IMPORT_PREFIX}/lib/libeight_bit_int_gemm.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
