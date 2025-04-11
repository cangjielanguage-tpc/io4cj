/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is aes.
 */

package crypto4cj.aescj
import crypto4cj.utils.*

public let AES_ENCRYPT: Int32 = 1
public let AES_DECRYPT: Int32 = 0
public let AES_BLOCK_SIZE: Int32 = 16
let default_iv: Array<UInt8> = [0xA6, 0xA6, 0xA6, 0xA6, 0xA6, 0xA6, 0xA6, 0xA6]
var enFlag: Int32 = 0
var deFlag: Int32 = 0

/**
 * set key
 *
 * @param userKey - key len is 16、24、32
 * @param bits -  128、192、256
 * @param key - AESKEY
 *
 * @return Int32
 * @since 0.32.5
 */
public func aesSetEncryptKey(userKey: Array<UInt8>, bits: Int32, key: AESKEY): Unit {
    enFlag = 1
    var userSetDecryptKey: CPointerHandle<UInt8> = CPointerHandle<UInt8>()
    var ret: Int32 = 0
    if(userKey.size == 0) {
        ret = unsafe { AES_set_encrypt_key(CPointer<UInt8>(), bits, key.ptr) }
    } else {
        userSetDecryptKey = unsafe { acquireArrayRawData(userKey) }
        ret = unsafe { AES_set_encrypt_key(userSetDecryptKey.pointer, bits, key.ptr) }
    }
    unsafe { releaseArrayRawData(userSetDecryptKey) }
    if(ret == -1) {
        throw CryptoException("The userKey cannot be empty.")
    }
    if(ret == -2) {
        throw CryptoException("The value of bits should be 128、192、256.")
    }
}

/**
 * set key
 *
 * @param userKey - key len is 16、24、32
 * @param bits -  128、192、256
 * @param key - AESKEY
 *
 * @return Int32
 * @since 0.32.5
 */
public func aesSetDecryptKey(userKey: Array<UInt8>, bits: Int32, key: AESKEY): Unit {
    deFlag = 1
    var userSetDecryptKey: CPointerHandle<UInt8> = CPointerHandle<UInt8>()
    var ret: Int32 = 0
    if(userKey.size == 0) {
        ret = unsafe { AES_set_decrypt_key(CPointer<UInt8>(), bits, key.ptr) }
    } else {
        userSetDecryptKey = unsafe { acquireArrayRawData(userKey) }
        ret = unsafe { AES_set_decrypt_key(userSetDecryptKey.pointer, bits, key.ptr) }
    } 
    unsafe { releaseArrayRawData(userSetDecryptKey) }
    if(ret == -1) {
        throw CryptoException("The userKey cannot be empty.")
    }
    if(ret == -2) {
        throw CryptoException("The value of bits should be 128、192、256.")
    }
}

/**
 * Encrypt
 *
 * @param inside - input data, length of an encrypted block: 16
 * @param outside - output buffer, length of an encrypted block: 16
 * @param key - AESKEY
 *
 * @return Unit
 * @since 0.32.5
 */
public func aesEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY): Unit {
    if(inside.size <= 0) {
        throw CryptoException("The aesEncrypt of inside length is greater than 0.")
    }
    if(outside.size != Int64(AES_BLOCK_SIZE)) {
        throw CryptoException("outside length is ${AES_BLOCK_SIZE} byte.")
    }
    let encryptInside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let encryptOutside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    unsafe {
        AES_encrypt(encryptInside.pointer, encryptOutside.pointer, key.ptr)
        releaseArrayRawData(encryptInside)
        releaseArrayRawData(encryptOutside)
    }
}

/**
 * Decrypt
 *
 * @param inside - input data, length of an encrypted block: 16
 * @param outside - output buffer, length of an encrypted block: 16
 * @param key - AESKEY
 *
 * @return Unit
 * @since 0.32.5
 */
public func aesDecrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY): Unit {
    if(inside.size <= 0) {
        throw CryptoException("The inside length is greater than 0.")
    }
    if(outside.size != Int64(AES_BLOCK_SIZE)) {
        throw CryptoException("outside length is ${AES_BLOCK_SIZE} byte.")
    }
    let decryptInside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let decryptOutside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    unsafe {
        AES_decrypt(decryptInside.pointer, decryptOutside.pointer, key.ptr)
        releaseArrayRawData(decryptInside)
        releaseArrayRawData(decryptOutside)
    }
}

/**
 * The Function is aesEcbEncrypt
 *
 * @param inside - input data, length of an encrypted block: 16
 * @param outside - output buffer, length of an encrypted block: 16
 * @param key - AESKEY
 * @param enc - AES_ENCRYPT/AES_DECRYPT
 *
 * @return Type of Unit
 * @since 0.32.5
 */
public func aesEcbEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, enc: Int32): Unit {
    if(inside.size <= 0) {
        throw CryptoException("The inside length is greater than 0.")
    }
    if(outside.size != Int64(AES_BLOCK_SIZE)) {
        throw CryptoException("outside length is ${AES_BLOCK_SIZE} byte.")
    }
    if(enFlag == 0 && enc == AES_ENCRYPT) {
        throw CryptoException("Please set the encrypto key first.")
    }
    if(deFlag == 0 && enc == AES_DECRYPT) {
        throw CryptoException("Please set the decrypto key first.")
    }
    let ecbInside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let ecbOutside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    unsafe {
        AES_ecb_encrypt(ecbInside.pointer, ecbOutside.pointer, key.ptr, enc)
        releaseArrayRawData(ecbInside)
        releaseArrayRawData(ecbOutside)
    }
}

/**
 * The Function is aesCbcEncrypt
 *
 * @param inside - input data, length of an encrypted block: 16
 * @param outside - output buffer, length of an encrypted block: 16
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 * @param enc - AES_ENCRYPT/AES_DECRYPT
 *
 * @return Type of Unit
 * @since 0.32.5
 */
public func aesCbcEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit {
    if(inside.size <= 0) {
        throw CryptoException("The inside length is greater than 0.")
    }
    if(outside.size != Int64(AES_BLOCK_SIZE)) {
        throw CryptoException("outside length is ${AES_BLOCK_SIZE} byte.")
    }
    if(ivec.size != Int64(AES_BLOCK_SIZE)) {
        throw CryptoException("The length of ivec must be ${AES_BLOCK_SIZE} bytes.")
    }
    if(enFlag == 0 && enc == AES_ENCRYPT) {
        throw CryptoException("Please set the encrypto key first.")
    }
    if(deFlag == 0 && enc == AES_DECRYPT) {
        throw CryptoException("Please set the decrypto key first.")
    }
    let cbcInside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let cbcOutside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let cbcIvec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    unsafe {
        AES_cbc_encrypt(cbcInside.pointer, cbcOutside.pointer, Int32(inside.size), key.ptr, cbcIvec.pointer, enc)
        releaseArrayRawData(cbcInside)
        releaseArrayRawData(cbcOutside)
        releaseArrayRawData(cbcIvec)
    }
}

/**
 * The Function is aesCfb128Encrypt
 *
 * @param inside - input data
 * @param outside - output data
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 * @param enc - AES_ENCRYPT/AES_DECRYPT
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public func aesCfb128Encrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit {
    paramsConstraints(inside, outside, ivec)
    let cfb128Inside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let cfb128Outside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let cfb128Ivec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    let ptr = unsafe { malloc(4) }
    if (ptr.isNull()) {
        throw CryptoException("Malloc failed.")
    }
    let cfb128Num = unsafe {CPointer<Int32>(ptr)}
    let num: Int32 = 0
    unsafe {
        cfb128Num.write(num)
        AES_cfb128_encrypt(cfb128Inside.pointer, cfb128Outside.pointer, Int32(inside.size), key.ptr, cfb128Ivec.pointer, cfb128Num, enc)
        free(cfb128Num)
        releaseArrayRawData(cfb128Inside)
        releaseArrayRawData(cfb128Outside)
        releaseArrayRawData(cfb128Ivec)
    }
}

/**
 * The Function is aesCfb1Encrypt
 *
 * @param inside - input data
 * @param outside - output data
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 * @param enc - AES_ENCRYPT/AES_DECRYPT
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public func aesCfb1Encrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit {
    paramsConstraints(inside, outside, ivec)
    let cfb1Inside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let cfb1Outside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let cfb1Ivec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    let ptr = unsafe { malloc(4) }
    if (ptr.isNull()) {
        throw CryptoException("Malloc failed.")
    }
    let cfb1Num = unsafe {CPointer<Int32>(ptr)}
    let num: Int32 = 0
    unsafe {
        cfb1Num.write(num)
        AES_cfb1_encrypt(cfb1Inside.pointer, cfb1Outside.pointer, Int32(inside.size) * 8, key.ptr, cfb1Ivec.pointer, cfb1Num, enc)
        free(cfb1Num)
        releaseArrayRawData(cfb1Inside)
        releaseArrayRawData(cfb1Outside)
        releaseArrayRawData(cfb1Ivec)
    }
}

/**
 * The Function is aesCfb8Encrypt
 *
 * @param inside - input data
 * @param outside - output data
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 * @param enc - AES_ENCRYPT/AES_DECRYPT
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public func aesCfb8Encrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit {
    paramsConstraints(inside, outside, ivec)
    let cfb8Inside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let cfb8Outside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let cfb8Ivec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    let ptr = unsafe { malloc(4) }
    if (ptr.isNull()) {
        throw CryptoException("Malloc failed.")
    }
    let cfb8Num = unsafe {CPointer<Int32>(ptr)}
    let num: Int32 = 0
    unsafe {
        cfb8Num.write(num)
        AES_cfb8_encrypt(cfb8Inside.pointer, cfb8Outside.pointer, Int32(inside.size), key.ptr, cfb8Ivec.pointer, cfb8Num, enc)
        free(cfb8Num)
        releaseArrayRawData(cfb8Inside)
        releaseArrayRawData(cfb8Outside)
        releaseArrayRawData(cfb8Ivec)
    }
}

/**
 * The Function is aesOfb128Encrypt
 *
 * @param inside - input data
 * @param outside - output data
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public func aesOfb128Encrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>): Unit {
    paramsConstraints(inside, outside, ivec)
    let ofb128Inside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let ofb128Outside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let ofb128Ivec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    let ptr = unsafe { malloc(4) }
    if (ptr.isNull()) {
        throw CryptoException("Malloc failed.")
    }
    let ofb128Num = unsafe {CPointer<Int32>(ptr)}
    let num: Int32 = 0
    unsafe {
        ofb128Num.write(num)
        AES_ofb128_encrypt(ofb128Inside.pointer, ofb128Outside.pointer, Int32(inside.size), key.ptr, ofb128Ivec.pointer, ofb128Num)
        free(ofb128Num)
        releaseArrayRawData(ofb128Inside)
        releaseArrayRawData(ofb128Outside)
        releaseArrayRawData(ofb128Ivec)
    }
}

/**
 * The Function is aesIgeEncrypt
 *
 * @param inside - input data
 * @param outside - output data
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public func aesIgeEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit {
    if(outside.size != inside.size) {
        throw CryptoException("The outside length should be the same as the inside length.")
    }
    if(inside.size <= 0 || inside.size % Int64(AES_BLOCK_SIZE) != 0) {
        throw CryptoException("The length of inside must be an integral multiple of ${AES_BLOCK_SIZE}.")
    }
    if(ivec.size != Int64(AES_BLOCK_SIZE * 2)) {
        throw CryptoException("The length of ivec must be ${AES_BLOCK_SIZE * 2} bytes.")
    }
    if(enFlag == 0 && enc == AES_ENCRYPT) {
        throw CryptoException("Please set the encrypto key first.")
    }
    if(deFlag == 0 && enc == AES_DECRYPT) {
        throw CryptoException("Please set the decrypto key first.")
    }
    let igeInside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let igeOutside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let igeIvec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    unsafe {
        AES_ige_encrypt(igeInside.pointer, igeOutside.pointer, Int32(inside.size), key.ptr, igeIvec.pointer, enc)
        releaseArrayRawData(igeInside)
        releaseArrayRawData(igeOutside)
        releaseArrayRawData(igeIvec)
    }
}

/**
 * The Function is aesBiIgeEncrypt
 *
 * @param inside - input data
 * @param outside - output data
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public func aesBiIgeEncrypt(inside: Array<UInt8>, outside: Array<UInt8>, key: AESKEY, ivec: Array<UInt8>, enc: Int32): Unit {
    if(outside.size != inside.size) {
        throw CryptoException("The outside length should be the same as the inside length.")
    }
    if(ivec.size != Int64(AES_BLOCK_SIZE * 4)) {
        throw CryptoException("The length of ivec must be ${AES_BLOCK_SIZE * 4} bytes.")
    }
    if(inside.size <= 0 || inside.size % Int64(AES_BLOCK_SIZE) != 0) {
        throw CryptoException("The length of inside must be an integral multiple of ${AES_BLOCK_SIZE}.")
    }
    if(enFlag == 0 && enc == AES_ENCRYPT) {
        throw CryptoException("Please set the encrypto key first.")
    }
    if(deFlag == 0 && enc == AES_DECRYPT) {
        throw CryptoException("Please set the decrypto key first.")
    }
    let biIgeInside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let biIgeOutside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let biIgeIvec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    unsafe {
        AES_bi_ige_encrypt(biIgeInside.pointer, biIgeOutside.pointer, Int32(inside.size), key.ptr, key.ptr, biIgeIvec.pointer, enc)
        releaseArrayRawData(biIgeInside)
        releaseArrayRawData(biIgeOutside)
        releaseArrayRawData(biIgeIvec)
    }
}

/**
 * The Function is aesWrapEncrypt
 *
 * @param inside - input data
 * @param outside - output data
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public func aesWrapEncrypt(key: AESKEY, ivec: Array<UInt8>, outside: Array<UInt8>, inside: Array<UInt8>): Unit {
    if(outside.size < (inside.size + 8)) {
        throw CryptoException("The minimum outside is inside.size + 8.")
    }
    if(ivec.size != 8 && ivec.size != 0) {
        throw CryptoException("The length of ivec must be 8 bytes.")
    }
    if(inside.size < 16 || inside.size % 8 != 0) {
        throw CryptoException("The length of inside must be an integral multiple of 8 and inside.size >= 16.")
    }
    if(enFlag == 0) {
        throw CryptoException("Please set the encrypto key first.")
    }
    if(ivec.size == 0) {
        cjAesWrapEncrypt(key, default_iv, outside, inside, UInt32(inside.size))
        return
    }
    cjAesWrapEncrypt(key, ivec, outside, inside, UInt32(inside.size))
}

/**
 * The Function is aesWrapEncrypt
 *
 * @param inside - input data
 * @param outside - output data
 * @param key - AESKEY
 * @param ivec - Array<UInt8>
 *
 * @return Type of Unit
 * @since 0.33.3
 */
public func aesUnWrapEncrypt(key: AESKEY, ivec: Array<UInt8>, outside: Array<UInt8>, inside: Array<UInt8>): Unit {
    if(outside.size < (inside.size - 8) ) {
        throw CryptoException("The minimum outside is inside.size - 8.")
    }
    if(ivec.size != 8 && ivec.size != 0) {
        throw CryptoException("The length of ivec must be 8 bytes.")
    }
    if(inside.size < 24 ||inside.size % 8 != 0) {
        throw CryptoException("The length of inside must be an integral multiple of 8 and inside.size >= 24.")
    }
    if(deFlag == 0) {
        throw CryptoException("Please set the decrypto key first.")
    }
    if(ivec.size == 0) {
        cjAesUnWrapEncrypt(key, default_iv, outside, inside, UInt32(inside.size))
        return
    }
    cjAesUnWrapEncrypt(key, ivec, outside, inside, UInt32(inside.size))
}

func cjAesWrapEncrypt(key: AESKEY, ivec: Array<UInt8>, outside: Array<UInt8>, inside: Array<UInt8>, length: UInt32): Unit {
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let p3: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    unsafe {
        AES_wrap_key(key.ptr, p1.pointer, p2.pointer, p3.pointer, length)
        releaseArrayRawData(p1)
        releaseArrayRawData(p2)
        releaseArrayRawData(p3)
    }
}

func cjAesUnWrapEncrypt(key: AESKEY, ivec: Array<UInt8>, outside: Array<UInt8>, inside: Array<UInt8>, length: UInt32): Unit {
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
    let p3: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    unsafe {
        AES_unwrap_key(key.ptr, p1.pointer, p2.pointer, p3.pointer, length)
        releaseArrayRawData(p1)
        releaseArrayRawData(p2)
        releaseArrayRawData(p3)
    }
}
func paramsConstraints(inside: Array<UInt8>, outside: Array<UInt8>, ivec: Array<UInt8>): Unit {
    if(inside.size <= 0) {
        throw CryptoException("The inside length is greater than 0.")
    }
    if(outside.size != inside.size) {
        throw CryptoException("The outside length should be the same as the inside length.")
    }
    if(ivec.size != Int64(AES_BLOCK_SIZE)) {
        throw CryptoException("The length of ivec must be ${AES_BLOCK_SIZE} bytes.")
    }
    if(enFlag != 1) {
        throw CryptoException("Please set the encrypto key first.")
    }
}