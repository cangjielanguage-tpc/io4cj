/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */

package crypto4cj.bignumcj

@C
public struct BIGNUM {
    var d: CPointer<UInt64> = CPointer<UInt64>()
    var top: Int32 = 0
    var dmax: Int32 = 0
    var neg: Int32 = 0
    var flags: Int32 = 0
} 

@C
struct BN_POOL_ITEM {
    /* The bignum values */
    var vals0: BIGNUM = BIGNUM()
    var vals1: BIGNUM = BIGNUM()
    var vals2: BIGNUM = BIGNUM()
    var vals3: BIGNUM = BIGNUM()
    var vals4: BIGNUM = BIGNUM()
    var vals5: BIGNUM = BIGNUM()
    var vals6: BIGNUM = BIGNUM()
    var vals7: BIGNUM = BIGNUM()
    var vals8: BIGNUM = BIGNUM()
    var vals9: BIGNUM = BIGNUM()
    var vals10: BIGNUM = BIGNUM()
    var vals11: BIGNUM = BIGNUM()
    var vals12: BIGNUM = BIGNUM()
    var vals13: BIGNUM = BIGNUM()
    var vals14: BIGNUM = BIGNUM()
    var vals15: BIGNUM = BIGNUM()

    /* Linked-list admin */
    var prev: CPointer<BN_POOL_ITEM> = CPointer<BN_POOL_ITEM>()
    var next: CPointer<BN_POOL_ITEM> = CPointer<BN_POOL_ITEM>()
    //struct bignum_pool_item *prev, *next
}
@C
struct BN_POOL {
    /* Linked-list admin */
    var head: CPointer<BN_POOL_ITEM> = CPointer<BN_POOL_ITEM>()
    var current: CPointer<BN_POOL_ITEM> = CPointer<BN_POOL_ITEM>()
    var tail: CPointer<BN_POOL_ITEM> = CPointer<BN_POOL_ITEM>()

    /* Stack depth and allocation size */
    var used: UInt32 = 0
    var size: UInt32 = 0
}
@C
struct BN_STACK {
    /* Array of indexes into the bignum stack */
    var indexes: CPointer<UInt32> = CPointer<UInt32>()

    /* Number of stack frames, and the size of the allocated array */
    var depth: UInt32 = 0
    var size: UInt32 = 0
}
@C 
public struct BN_CTX {
   /* The bignum bundles */
    var pool: BN_POOL = BN_POOL()

    /* The "stack frames", if you will */
    var stack: BN_STACK = BN_STACK()

    /* The number of bignums currently assigned */
    var used: UInt32 = 0

    /* Depth of stack overflow */
    var err_stack: Int32 = 0

    /* Block "gets" until an "end" (compatibility behaviour) */
    var too_many: Int32 = 0

    /* Flags. */
    var flags: Int32 = 0

    /* The library context */
    //OSSL_LIB_CTX *libctx
}

foreign func BN_new(): CPointer<BIGNUM>

foreign func BN_clear(a: CPointer<BIGNUM>): Unit

foreign func BN_free(a: CPointer<BIGNUM>): Unit

foreign func BN_clear_free(a: CPointer<BIGNUM>): Unit

foreign func BN_copy(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): CPointer<BIGNUM>

foreign func BN_dup(a: CPointer<BIGNUM>): CPointer<BIGNUM>

foreign func BN_swap(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Unit

foreign func BN_num_bits(a: CPointer<BIGNUM>): Int32

foreign func BN_num_bits_word(w: UInt64): Int32

foreign func BN_value_one(): CPointer<BIGNUM>

foreign func BN_set_word(a: CPointer<BIGNUM>, w: UInt64): Int32

foreign func BN_get_word(a: CPointer<BIGNUM>): UInt64

foreign func BN_cmp(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Int32

foreign func BN_ucmp(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Int32

foreign func BN_is_zero(a: CPointer<BIGNUM>): Int32

foreign func BN_is_one(a: CPointer<BIGNUM>): Int32

foreign func BN_is_word(a: CPointer<BIGNUM>, w: UInt64): Int32

foreign func BN_rand(rnd: CPointer<BIGNUM>, bits: Int32, top: Int32, bottom: Int32): Int32

foreign func BN_rand_range(rnd: CPointer<BIGNUM>, range: CPointer<BIGNUM>): Int32

foreign func BN_bn2dec(a: CPointer<BIGNUM>): CString

foreign func BN_is_odd(a: CPointer<BIGNUM>): Int32

foreign func BN_add(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Int32

foreign func BN_sub(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Int32

foreign func BN_add_word(a: CPointer<BIGNUM>, w: UInt64): Int32

foreign func BN_sub_word(a: CPointer<BIGNUM>, w: UInt64): Int32

foreign func BN_mul_word(a: CPointer<BIGNUM>, w: UInt64): Int32

foreign func BN_div_word(a: CPointer<BIGNUM>, w: UInt64): UInt64

foreign func BN_mod_word(a: CPointer<BIGNUM>, w: UInt64): UInt64

foreign func BN_pseudo_rand(rnd: CPointer<BIGNUM>, bits: Int32, top: Int32, bottom: Int32): Int32

foreign func BN_pseudo_rand_range(rnd: CPointer<BIGNUM>, range: CPointer<BIGNUM>): Int32

foreign func BN_bn2bin(a: CPointer<BIGNUM>, to: CString): Int32

foreign func BN_bin2bn(s: CString, len: Int32, ret: CPointer<BIGNUM>): CPointer<BIGNUM>

foreign func BN_bn2hex(a: CPointer<BIGNUM>): CString

foreign func BN_hex2bn(a: CPointer<CPointer<BIGNUM>>, str: CString): Int32

foreign func BN_dec2bn(a: CPointer<CPointer<BIGNUM>>, str: CString): Int32

foreign func BN_set_bit(a: CPointer<BIGNUM>, n: Int32): Int32

foreign func BN_clear_bit(a: CPointer<BIGNUM>, n: Int32): Int32

foreign func BN_is_bit_set(a: CPointer<BIGNUM>, n: Int32): Int32

foreign func BN_mask_bits(a: CPointer<BIGNUM>, n: Int32): Int32

foreign func BN_lshift1(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>): Int32

foreign func BN_rshift1(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>): Int32

foreign func BN_lshift(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, n: Int32): Int32

foreign func BN_rshift(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, n: Int32): Int32

foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(p: CPointer<CPointer<BIGNUM>>): Unit

foreign func BN_CTX_new(): CPointer<BN_CTX>

foreign func BN_CTX_free(c: CPointer<BN_CTX>): Unit

foreign func BN_mul(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_sqr(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_div(dv: CPointer<BIGNUM>, rem: CPointer<BIGNUM>, m: CPointer<BIGNUM>, d: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_nnmod(r: CPointer<BIGNUM>, m: CPointer<BIGNUM>, d: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_mod_add(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_mod_sub(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_mod_mul(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_mod_sqr(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_exp(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, p: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_mod_exp(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, p: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_gcd(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32

foreign func BN_mod_inverse(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, n: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32
