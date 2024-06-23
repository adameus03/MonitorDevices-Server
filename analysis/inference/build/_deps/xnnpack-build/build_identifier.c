// Copyright 2024 Google LLC
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.

// Auto-generated file. Do not edit!
//   Generator: scripts/generate-build-identifier.py
//
// The following inputs were used to generate this file.
// - src/amalgam/gen/scalar.c
// - src/amalgam/gen/sse.c
// - src/amalgam/gen/sse2.c
// - src/amalgam/gen/ssse3.c
// - src/amalgam/gen/sse41.c
// - src/amalgam/gen/avx.c
// - src/amalgam/gen/f16c.c
// - src/amalgam/gen/fma3.c
// - src/amalgam/gen/avx2.c
// - src/amalgam/gen/avx512f.c
// - src/amalgam/gen/avx512skx.c
// - src/amalgam/gen/avx512vbmi.c
// - src/amalgam/gen/avx512vnni.c
// - src/amalgam/gen/avx512vnnigfni.c
// - src/amalgam/gen/avxvnni.c

#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <string.h>

static const uint8_t xnn_build_identifier[] = {
   48, 167, 178, 134, 153, 231, 246,  69,
  164,  94, 249, 220,  78, 137, 201, 240,
   14, 140,  39, 136, 153, 150, 240,  71,
   40, 193, 194, 248, 141, 252, 165, 175
};

size_t xnn_experimental_get_build_identifier_size() {
  return sizeof(xnn_build_identifier);
}

const void* xnn_experimental_get_build_identifier_data() {
  return xnn_build_identifier;
}

bool xnn_experimental_check_build_identifier(const void* data, const size_t size) {
  if(size != xnn_experimental_get_build_identifier_size()) {
    return false;
  }
  return !memcmp(data, xnn_build_identifier, size);
}
