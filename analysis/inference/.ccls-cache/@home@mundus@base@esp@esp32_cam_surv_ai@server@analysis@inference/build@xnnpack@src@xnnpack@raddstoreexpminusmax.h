// Copyright 2019 Google LLC
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.

#pragma once

#include <stddef.h>
#include <stdint.h>

#include <xnnpack/common.h>
#include <xnnpack/microparams.h>

#ifdef __cplusplus
extern "C" {
#endif

#define DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(fn_name) \
  XNN_INTERNAL void fn_name(                                       \
      size_t n,                                                    \
      const void* input,                                           \
      const void* max,                                             \
      void* output,                                                \
      void* sum,                                                   \
      const union xnn_f16_expminus_params params[XNN_RESTRICT XNN_MIN_ELEMENTS(1)]);

DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u16)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u16_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u32)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u32_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u32_acc4)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u40)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u40_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u40_acc5)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u48)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u48_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u48_acc3)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u64)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u64_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u64_acc4)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u72)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u72_acc3)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u80)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u80_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u80_acc5)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u96)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u96_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u96_acc3)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__avx2_rr1_p2_u96_acc6)

DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u32)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u32_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u32_acc4)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u40)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u40_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u40_acc5)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u48)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u48_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u48_acc3)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u64)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u64_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u64_acc4)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u72)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u72_acc3)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u80)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u80_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u80_acc5)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u96)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u96_acc2)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u96_acc3)
DECLARE_F16_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f16_raddstoreexpminusmax_ukernel__neonfp16arith_rr2_p2_u96_acc6)


#define DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(fn_name) \
  XNN_INTERNAL void fn_name(                                       \
      size_t n,                                                    \
      const float* input,                                          \
      const float* max,                                            \
      float* output,                                               \
      float* sum,                                                  \
      const union xnn_f32_expminus_params params[XNN_RESTRICT XNN_MIN_ELEMENTS(1)]);

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u8)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u8_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u12)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u12_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u12_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u16)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u16_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u16_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u20)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u20_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_p5_u20_acc5)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u8)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u8_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u12)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u12_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u12_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u16)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u16_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u16_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u20)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u20_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neon_rr2_lut64_p2_u20_acc5)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u8)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u8_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u12)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u12_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u12_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u16)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u16_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u16_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u20)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u20_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_p5_u20_acc5)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u8)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u8_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u12)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u12_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u12_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u16)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u16_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u16_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u20)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u20_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__neonfma_rr1_lut64_p2_u20_acc5)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__rvv_rr2_p6_u2v)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__rvv_rr2_p6_u4v)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u8)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u8_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u12)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u12_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u12_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u16)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u16_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u16_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u20)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u20_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__sse2_rr2_p5_u20_acc5)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u32)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u32_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u32_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u64)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u64_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u64_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u72)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u72_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u80)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u80_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u80_acc5)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u96)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u96_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u96_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx2_rr1_p5_u96_acc6)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u64)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u64_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u64_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u128)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u128_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u128_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u144)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u144_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u160)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u160_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u160_acc5)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u192)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u192_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u192_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__avx512f_rr1_p5_scalef_u192_acc6)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u8)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u8_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u12)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u12_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u12_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u16)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u16_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u16_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u20)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u20_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmsimd_rr2_p5_u20_acc5)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u8)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u8_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u12)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u12_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u12_acc3)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u16)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u16_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u16_acc4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u20)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u20_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__wasmrelaxedsimd_rr2_p5_u20_acc5)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_p5_u1)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_p5_u2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_p5_u2_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_p5_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_p5_u4_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_p5_u4_acc4)

DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_lut64_p2_u1)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_lut64_p2_u2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_lut64_p2_u2_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_lut64_p2_u4)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_lut64_p2_u4_acc2)
DECLARE_F32_RADDSTOREEXPMINUSMAX_UKERNEL_FUNCTION(xnn_f32_raddstoreexpminusmax_ukernel__scalar_rr2_lut64_p2_u4_acc4)

#ifdef __cplusplus
} /* extern "C" */
#endif
