/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is bignum.
 */
package crypto4cj.bignumcj

import crypto4cj.utils.*
import std.io.*

/**
 * Create an empty large number object.
 *
 * return CPointer<BIGNUM>
 */
public func bnNew(): CPointer<BIGNUM> {
    return unsafe { BN_new() }
}

/**
 * Assign all items in a to 0, but the memory is not released.
 *
 * params a: CPointer<BIGNUM>
 */
public func bnClear(a: CPointer<BIGNUM>): Unit {
    unsafe { BN_clear(a) }
}

/**
 * Release large objects. Each created large object needs to be released
 *
 * @params a: CPointer<BIGNUM> - large numbers
 *
 * @return Unit
 */
public func bnFree(a: CPointer<BIGNUM>): Unit {
    var copy: CPointer<BIGNUM> = a
    unsafe { BN_clear(copy) }
    unsafe { BN_free(copy) }
    return copy = bnNew()  
}

/**
 * Equivalent to BN_ Free and BN_ Clear synthesis. Either assign a value of 0 or release space.
 *
 * @params a: CPointer<BIGNUM> - large numbers
 *
 * @return Unit
 */
public func bnClearFree(a: CPointer<BIGNUM>): Unit {
    var copy: CPointer<BIGNUM> = a
    unsafe { BN_clear_free(copy) }
    return copy = bnNew()
}

/**
 * Copy b to a, return a if correct.
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params b: CPointer<BIGNUM> - large numbers
 *
 * @return CPointer<BIGNUM> - success a , error null
 */
public func bnCopy(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): CPointer<BIGNUM> {
    return unsafe { BN_copy(a, b)}
}

/**
 * Create a new BIGNUM structure, copy a to the new structure.
 *
 * @params a: CPointer<BIGNUM> - large numbers
 *
 * @return CPointer<BIGNUM>
 */
public func bnDup(a: CPointer<BIGNUM>): CPointer<BIGNUM> {
    return unsafe { BN_dup(a) }
}

/**
 * Exchange a, b.
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params b: CPointer<BIGNUM> - large numbers
 *
 * @return Unit
 */
public func bnSwap(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Unit {
    unsafe { BN_swap(a, b) }
}

/**
 * Returns the number of bits occupied by a.
 *
 * @params a: CPointer<BIGNUM> - large numbers
 *
 * @return Int32
 */
public func bnNumBits(a: CPointer<BIGNUM>): Int32 {
    return unsafe { BN_num_bits(a) }
}

/**
 * It returns the number of significant bits, for example, 0x00000111 is 9.
 *
 * @params a: UInt64
 *
 * @return Int32
 */
public func bnNumBitsWord(a: UInt64): Int32 {
    return unsafe { BN_num_bits_word(a) }
}

/**
 * Returns a large number of 1.
 *
 *
 * @return CPointer<BIGNUM>
 */
public func bnValueOne(): CPointer<BIGNUM> {
    return unsafe { BN_value_one() }
}

/**
 * Set Integer to Large Object
 *
 * @params a: CPointer<BIGNUM> - Large Object
 * @params w: UInt64 - UInt64
 *
 * @return Unit
 */
public func bnSetWord(a: CPointer<BIGNUM>, w: UInt64): Unit {
    unsafe { BN_set_word(a, w) }
}

/**
 * Extract integers from large numbers
 *
 * @params a: CPointer<BIGNUM> - large numbers
 *
 * @return UInt64 - result
 */
public func bnGetWord(a: CPointer<BIGNUM>): UInt64 {
    return unsafe { BN_get_word(a) }
}

/**
 * Compare two large numbers
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params b: CPointer<BIGNUM> - large numbers
 *
 * @return Int32 - a < b return -1
 *                 a == b return 0
 *                 a > b return 1
 */
public func bnCmp(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Int32 {
    return unsafe { BN_cmp(a, b) }
}

/**
 * Judge whether the absolute values of a and b are equal
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params b: CPointer<BIGNUM> - large numbers
 *
 * @return Int32 - |a| < |b| return -1
 *                 |a| == |b| return 0
 *                 |a| > |b| return 1
 */
public func bnUcmp(a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Int32 {
    return unsafe { BN_ucmp(a, b) }
}

/**
 * Judge whether a is 0
 *
 * @params a: CPointer<BIGNUM> - large numbers
 *
 * @return Bool
 */
public func bnIsZero(a: CPointer<BIGNUM>): Bool {
    let res = unsafe { BN_is_zero(a) }
    if(res == 1) {
       return true
    }
    return false
}

/**
 * Judge whether a is 1
 *
 * @params a: CPointer<BIGNUM> - large numbers
 *
 * @return Bool
 */
public func bnIsOne(a: CPointer<BIGNUM>): Bool {
    let res = unsafe { BN_is_one(a) }
    if(res == 1) {
       return true
    }
    return false
}

/**
 * Judge whether a is the value w
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params w: UInt64
 *
 * @return Bool
 */
public func bnIsWord(a: CPointer<BIGNUM>, w: UInt64): Bool {
    let res = unsafe { BN_is_word(a, w) }
    if(res == 1) {
       return true
    }
    return false
}

/**
 * Perform integer addition on large numbers
 *
 * @params r: CPointer<BIGNUM>  - and
 * @params a: CPointer<BIGNUM> - Addend
 * @params b: CPointer<BIGNUM> - Addend
 *
 * @return Unit
 */
public func bnAdd(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Unit {
    unsafe { BN_add(r, a, b) }
}

/**
 * Generating strong random large numbers for finger positioning
 *
 * @params rnd: CPointer<BIGNUM> - Random large number
 * @params bits: Int32 - Specify the number of digits ( > 0 )
 * @params top: Int32 -
 *      BN_RAND_TOP_ANY = -1  The highest bit is 0
 *      BN_RAND_TOP_ONE  = 0  The highest bit is 1
 *      BN_RAND_TOP_TWO  = 1  The highest order and the second highest order are 1
 * @params bottom: Int32 -
 *      BN_RAND_BOTTOM_ANY = 0 Random tail position
 *      BN_RAND_BOTTOM_ODD  = 1 Tail position 1, representing odd number
 *
 * @return Unit
 */
public func bnRand(rnd: CPointer<BIGNUM>, bits: Int32, top: Int32, bottom: Int32): Unit {
    if(bits < 0 || (bits == 1 && top > 0)) {
        throw CryptoException("Rand of bignum failed!")
    }
    unsafe { BN_rand(rnd, bits, top, bottom) }
}

/**
 * Generate large number of 0~range range
 *
 * @params rnd: CPointer<BIGNUM> - Generated random large number
 * @params range: CPointer<BIGNUM> - Range( 0 ~ range)
 *
 * @return Unit
 */
public func bnRandRange(rnd: CPointer<BIGNUM>, range: CPointer<BIGNUM>): Unit {
    unsafe { BN_rand_range(rnd, range) }
}

/**
 * Extract a decimal string from a large number.
 *
 * @params a: CPointer<BIGNUM> - large number
 *
 * @return String
 */
public func bnBn2dec(a: CPointer<BIGNUM>): String {
    return unsafe { BN_bn2dec(a).toString() }
}

/**
 * Judge whether a is an odd number
 *
 * @params a: CPointer<BIGNUM> - large numbers
 *
 * @return Bool
 */
public func bnIsOdd(a: CPointer<BIGNUM>): Bool {
    let res = unsafe { BN_is_odd(a) }
    if(res == 1) {
       return true
    }
    return false
}

/**
 * Perform integer addition on large numbers
 *
 * @params r: CPointer<BIGNUM>  - difference
 * @params a: CPointer<BIGNUM> - large numbers
 * @params b: CPointer<BIGNUM> - large numbers
 *
 * @return Unit
 */
public func bnSub(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>): Unit {
    unsafe { BN_sub(r, a, b) }
}

/**
 * The large number a plus w, the value is stored in a
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params w: UInt64
 *          a = a + w
 *
 * @return Unit
 */
public func bnAddWord(a: CPointer<BIGNUM>, w: UInt64): Unit {
    unsafe { BN_add_word(a, w) }
}

/**
 * Subtract w from a large number and store the value in a
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params w: UInt64
 *          a = a - w
 *
 * @return Unit
 */
public func bnSubWord(a: CPointer<BIGNUM>, w: UInt64): Unit {
    unsafe { BN_sub_word(a, w) }
}

/**
 * The large number a is multiplied by w, and the value is stored in a
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params w: UInt64
 *          a = a * w
 *
 * @return Unit
 */
public func bnMulWord(a: CPointer<BIGNUM>, w: UInt64): Unit {
    unsafe { BN_mul_word(a, w) }
}

/**
 * The large number a is divided by w, and the value is stored in a
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params w: UInt64
 *          a = a / w
 *
 * @return Unit
 */
public func bnDivWord(a: CPointer<BIGNUM>, w: UInt64): Unit {
    if(w == UInt64(0)) {
        throw CryptoException("The w cannot be 0.")
    }
    unsafe { BN_div_word(a, w) }
}

/**
 * The large number a is divided by w, and the value is stored in a
 *
 * @params a: CPointer<BIGNUM> - large numbers
 * @params w: UInt64
 *          a = a % w
 *
 * @return Unit
 */
public func bnModWord(a: CPointer<BIGNUM>, w: UInt64): UInt64 {
    if(w == UInt64(0)) {
        throw CryptoException("The w cannot be 0.")
    }
    unsafe { BN_mod_word(a, w) }
}

/**
 * Generating strong random large numbers for finger positioning
 *
 * @params rnd: CPointer<BIGNUM> - Random large number
 * @params bits: Int32 - Specify the number of digits ( > 0 )
 * @params top: Int32 -
 *      BN_RAND_TOP_ANY = -1  The highest bit is 0
 *      BN_RAND_TOP_ONE  = 0  The highest bit is 1
 *      BN_RAND_TOP_TWO  = 1  The highest order and the second highest order are 1
 * @params bottom: Int32 -
 *      BN_RAND_BOTTOM_ANY = 0 Random tail position
 *      BN_RAND_BOTTOM_ODD  = 1 Tail position 1, representing odd number
 *
 * @return Unit
 */
public func bnPseudoRand(rnd: CPointer<BIGNUM>, bits: Int32, top: Int32, bottom: Int32): Unit {
    if(bits < 0 || (bits == 1 && top > 0)) {
        throw CryptoException("Rand of bignum failed!")
    }
    unsafe { BN_pseudo_rand(rnd, bits, top, bottom) }
}

/**
 * Generate large number of 0~range range
 *
 * @params rnd: CPointer<BIGNUM> - Generated random large number
 * @params range: CPointer<BIGNUM> - Range( 0 ~ range)
 *
 * @return Unit
 */
public func bnPseudoRandRange(rnd: CPointer<BIGNUM>, range: CPointer<BIGNUM>): Unit {
    unsafe { BN_pseudo_rand_range(rnd, range) }
}

/**
 * Returns |a|  ASCLL and length
 *
 * @params a: CPointer<BIGNUM> - large number
 *
 * @return String - ASCLL
 * @return Int32 - length
 */
public func bnBn2bin(a: CPointer<BIGNUM>): (String, Int32) {
    var too = unsafe { LibC.mallocCString("") }
    var str: String = ""
    let res =  Int64(unsafe { BN_bn2bin(a, too) })
    let result = Array<UInt8>(res, repeat:0)
    var chars = too.getChars()
    unsafe {
        for(i in 0..res){
            result[i] = chars.read(i)
        }
        LibC.free(too)
    }
    str = unsafe { String.fromUtf8Unchecked(result)}
    return (str, Int32(res))
}

/**
 * Convert the positive integer of the preceding len bit in s to a large number and store it in ret
 *
 * @params s: String
 * @params len: Int32
 * @params ret: CPointer<BIGNUM>
 *
 * @return Unit
 */
public func bnBin2bin(data: String, len: Int32, ret: CPointer<BIGNUM>): CPointer<BIGNUM> {
    let datas: Array<UInt8> = data.toArray()
    let cStr = unsafe { LibC.mallocCString(" " * (datas.size)) }
    unsafe{
        let chars = cStr.getChars()
        for(i in 0..datas.size){
            chars.write(i, datas[i])
        }
    }
    unsafe { BN_bin2bn(cStr, len, ret) }
}

/**
 * Returns a string that converts a large number to hexadecimal
 *
 * @params a: CPointer<BIGNUM>
 *
 * @return String
 */
public func bnBn2hex(a: CPointer<BIGNUM>): String {
    unsafe { BN_bn2hex(a).toString() }
}

/**
 * Converts a hexadecimal string to a large number
 *
 * @params a: CPointer<BIGNUM>
 * @params str: String
 *
 * @return Unit
 */
public func bnHex2bn(a: CPointer<BIGNUM>, str: String): Unit {
    var s = unsafe { LibC.mallocCString(str) }
    let ptr = unsafe { malloc(24) }
    if (ptr.isNull()) {
        throw CryptoException("Malloc failed.")
    }
    let p = unsafe {CPointer<CPointer<BIGNUM>>(ptr)}
    unsafe { p.write(a)}
    var ret = unsafe { BN_hex2bn(p, s) }
    try {
        if(ret == 0) {
            throw CryptoException("Str is not a hexadecimal string!")
        }
    } finally {
        unsafe { LibC.free(s) }
        unsafe { free(p) }
    }
}

/**
 * Converts a decimal string to a large number
 *
 * @params a: CPointer<BIGNUM>
 * @params str: String
 *
 * @return Unit
 */
public func bnDec2bn(a: CPointer<BIGNUM>, str: String): Unit {
    var s = unsafe { LibC.mallocCString(str) }
    let ptr = unsafe { malloc(24) }
    if (ptr.isNull()) {
        throw CryptoException("Malloc failed.")
    }
    let p = unsafe {CPointer<CPointer<BIGNUM>>(ptr)}
    unsafe { p.write(a)}
    var ret = unsafe { BN_dec2bn(p, s) }
    try {
        if(ret == 0) {
            throw CryptoException("Str is not a decimal string!")
        }
    } finally {
        unsafe { LibC.free(s) }
        unsafe { free(p) }
    }
}


/**
 * Set the nth bit in a to 1. If a is less than n bits, it will be expanded
 *
 * @params a: CPointer<BIGNUM>
 * @params n: Int32
 *
 * @return Unit
 */
public func bnSetBit(a: CPointer<BIGNUM>, n: Int32): Unit {
    let ret = unsafe { BN_set_bit(a, n) }
    if(ret == 0) {
        throw CryptoException("Setting failed!")
    }
}

/**
 * Set the nth value in a to 0, if a is less than n, bit a remains unchanged
 *
 * @params a: CPointer<BIGNUM>
 * @params n: Int32
 *
 * @return Unit
 */
public func bnClearBit(a: CPointer<BIGNUM>, n: Int32): Unit {
    let ret = unsafe { BN_clear_bit(a, n) }
    if(ret == 0) {
        throw CryptoException("Clearing failed!")
    }
}

/**
 * Test whether the nth bit in a has been set
 *
 * @params a: CPointer<BIGNUM>
 * @params n: Int32
 *
 * @return Bool - true: Set
 *                false: Not set
 */
public func bnIsBit(a: CPointer<BIGNUM>, n: Int32): Bool {
    let ret = unsafe { BN_is_bit_set(a, n) }
    if(ret == 1) {
        return true
    }
    return false
}

/**
 * Truncate a to n bits, n > a bits, a Keep unchanged.
 *
 * @params a: CPointer<BIGNUM>
 * @params n: Int32
 *
 * @return Unit
 */
public func bnMaskBit(a: CPointer<BIGNUM>, n: Int32): Unit {
    let ret = unsafe { BN_mask_bits(a, n) }
    if(ret == 0) {
        throw CryptoException("Masking failed!")
    }
}

/**
 * A is shifted 1 bit to the left, and the result is stored in r.
 *
 * @params r: CPointer<BIGNUM>
 * @params a: CPointer<BIGNUM>
 *
 * @return Unit
 */
public func bnLshift1(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>): Unit {
    unsafe { BN_lshift1(r, a) }
}

/**
 * A Shift 1 bit to the right, and the result is stored in r.
 *
 * @params r: CPointer<BIGNUM>
 * @params a: CPointer<BIGNUM>
 *
 * @return Unit
 */
public func bnRshift1(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>): Unit {
    unsafe { BN_rshift1(r, a) }
}

/**
 * A shifts n bits to the left, and the result is stored in r.
 *
 * @params r: CPointer<BIGNUM>
 * @params a: CPointer<BIGNUM>
 *
 * @return Unit
 */
public func bnLshift(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, n: Int32): Unit {
    let ret = unsafe { BN_lshift(r, a, n) }
    if(ret == 0) {
        throw CryptoException("Shift ${n} bit left failed!")
    }
}

/**
 * A shifts n bits to the right, and the result is stored in r.
 *
 * @params r: CPointer<BIGNUM>
 * @params a: CPointer<BIGNUM>
 *
 * @return Unit
 */
public func bnRshift(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, n: Int32): Unit {
    let ret = unsafe { BN_rshift(r, a, n) }
    if(ret == 0) {
        throw CryptoException("Shift ${n} bit right failed!")
    }
}

/**
 * Request a new context structure.
 *
 * @return CPointer<BN_CTX>
 */
public func bnCtxNew(): CPointer<BN_CTX> {
    return unsafe { BN_CTX_new() }
}

/**
 * Release context structure.
 *
 * @params c - CPointer<BN_CTX>
 *
 * @return Unit
 */
public func bnCtxFree(c: CPointer<BN_CTX>): Unit {
    unsafe { BN_CTX_free(c) }
}

/**
 * product
 *
 * @params r: CPointer<BIGNUM>  - product
 * @params a: CPointer<BIGNUM> - bignum
 * @params b: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnMul(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    unsafe { BN_mul(r, a, b, ctx) }
}

/**
 * Calculate the square of a, and store the value in r, r = a * a
 *
 * @params r: CPointer<BIGNUM>  - square
 * @params a: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnSqr(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    unsafe { BN_sqr(r, a, ctx) }
}

/**
 * Calculate the quotient of a and d. The value is stored in dv, and the remainder is stored in rem.
 * dv = m/d rem = m % d
 *
 * @params dv: CPointer<BIGNUM>  - merchant
 * @params rem: CPointer<BIGNUM> - remainder
 * @params m: CPointer<BIGNUM> - bignum
 * @params d: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnDiv(dv: CPointer<BIGNUM>, rem: CPointer<BIGNUM>, m: CPointer<BIGNUM>, d: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    let dd: UInt64 = bnGetWord(d)
    if(dd == UInt64(0)) {
        throw CryptoException("The d cannot be 0.")
    }
    unsafe { BN_div(dv, rem, m, d, ctx) }
}

/**
 * Calculate the modulus of a and m, and if the result is less than 0, add m, and store the value in r,
 * r = ( (a % m) + m) % m
 *
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM> - bignum
 * @params m: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnNnmod(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    let mm: UInt64 = bnGetWord(m)
    if(mm == UInt64(0)) {
        throw CryptoException("The d cannot be 0.")
    }
    unsafe { BN_nnmod(r, a, m, ctx) }
}

/**
 * Calculate the sum of a and b, then model m, and store the value in r
 *  r = (a + b) % m
 *
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM>  - bignum
 * @params b: CPointer<BIGNUM> - bignum
 * @params m: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnModAdd(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    let mm: UInt64 = bnGetWord(m)
    if(mm == UInt64(0)) {
        throw CryptoException("The m cannot be 0.")
    }
    unsafe { BN_mod_add(r, a, b, m, ctx) }
}

/**
 * Calculate the difference between a and b, then model m, and store the value in r
 * r = (a - b) % m
 *
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM>  - bignum
 * @params b: CPointer<BIGNUM> - bignum
 * @params m: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnModSub(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    let mm: UInt64 = bnGetWord(m)
    if(mm == UInt64(0)) {
        throw CryptoException("The m cannot be 0.")
    }
    unsafe { BN_mod_sub(r, a, b, m, ctx) }
}

/**
 * Calculate the product of a and b, then model m, store the value in r
 * r = (a * b) % m
 *
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM>  - bignum
 * @params b: CPointer<BIGNUM> - bignum
 * @params m: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnModMul(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    let mm: UInt64 = bnGetWord(m)
    if(mm == UInt64(0)) {
        throw CryptoException("The m cannot be 0.")
    }
    unsafe { BN_mod_mul(r, a, b, m, ctx) }
}

/**
 * Calculate the square of a, then modulus m, and store the value in r
 * r = (a * a) % m
 *
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM>  - bignum
 * @params m: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnModSqr(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    let mm: UInt64 = bnGetWord(m)
    if(mm == UInt64(0)) {
        throw CryptoException("The m cannot be 0.")
    }
    unsafe { BN_mod_sqr(r, a, m, ctx) }
}

/**
 * Calculate the power p of a, and store the value in r
 * r = a^p
 *
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM>  - bignum
 * @params p: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnExp(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, p: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    unsafe { BN_exp(r, a, p, ctx) }
}

/**
 * Calculate the power p of a, then modulus m, and store the value in r
 * r = (a ^ p) % m
 *
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM>  - bignum
 * @params p: CPointer<BIGNUM> - bignum
 * @params m: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnModExp(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, p: CPointer<BIGNUM>, m: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    let mm: UInt64 = bnGetWord(m)
    if(mm == UInt64(0)) {
        throw CryptoException("The m cannot be 0.")
    }
    unsafe { BN_mod_exp(r, a, p, m, ctx) }
}

/**
 * Calculate the maximum common divisor of a and b, and store the value in r
 * r = gcd(a,b)
 *
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM>  - bignum
 * @params b: CPointer<BIGNUM> - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnGcd(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    unsafe { BN_gcd(r, a, b, ctx) }
}

/**
 * Calculate the inverse of a modulo n places the result in r ((a*r)%n==1)
 * r = (a ^ -1) % n
 * 
 * @params r: CPointer<BIGNUM>  - value
 * @params a: CPointer<BIGNUM>  - bignum
 * @params n: CPointer<BIGNUM>  - bignum
 * @params ctx: CPointer<BN_CTX> - BN_CTX
 *
 * @return Unit
 */
public func bnModInverse(r: CPointer<BIGNUM>, a: CPointer<BIGNUM>, n: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Unit {
    unsafe { BN_mod_inverse(r, a, n, ctx) }
}

public func bnToArray(a: CPointer<BIGNUM>): Array<UInt8> {
    let len = Int64(unsafe{ bnNumBits(a) / 8 })
    var too = unsafe { LibC.mallocCString(" " * (len + 1))}
    let retLen =  Int64(unsafe { BN_bn2bin(a, too) })
    let result = Array<UInt8>(retLen, repeat:0)
    var chars = too.getChars()
    unsafe {
        for(i in 0..retLen){
            result[i] = chars.read(i)
        }
        LibC.free(too)
    }
    return result
}


public func arrayToBn(data: Array<UInt8>): CPointer<BIGNUM> {
    let cStr = unsafe { LibC.mallocCString(" " * (data.size)) }
    unsafe{
        let chars = cStr.getChars()
        for(i in 0..data.size){
            chars.write(i, data[i])
        }
    }
    let ret: CPointer<BIGNUM> = bnNew()
    return unsafe { BN_bin2bn(cStr, Int32(data.size), ret) }    
}