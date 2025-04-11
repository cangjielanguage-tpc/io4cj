/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * this file is rc2.
 */

package crypto4cj.rc2cj
import crypto4cj.utils.*

public let RC2_ENCRYPT: Int32 = 1
public let RC2_DECRYPT: Int32 = 0
public let RC2_BLOCK: Int32 = 8
public let RC2_KEY_LENGTH: Int32 = 16

var setKeyFlag: Int32 = 0

/**
 * Set Key
 *
 * @param key - RC2KEY
 * @param data - key value
 * @param bits - Number of bits of key data used
 *
 * @return Unit
 * @since 0.32.5
 */
public func rc2SetKey(key: RC2KEY, data: Array<UInt8>, bits: Int32): Unit {
    setKeyFlag = 1
    if(data.size <= 0) {
        throw CryptoException("The key cannot be empty.")
    }
    cjRc2SetKey(key, Int32(data.size), data, bits)
}

/**
 * Encryption and decryption
 *
 * @param inside - input data
 * @param out - output buffer, length of an encrypted block: 8
 * @param key - RC2KEY
 * @param enc - RC2_ENCRYPT / RC2_DECRYPT
 *
 * @return Type of Unit
 * @since 0.32.5
 */
public func rc2EcbEncrypt(inside: Array<UInt8>, out: Array<UInt8>, key: RC2KEY, enc: Int32): Unit {
    if(inside.size <= 0) {
        throw CryptoException("The inside or out cannot be empty.")
    }
    if(out.size != Int64(RC2_BLOCK)) {
        throw CryptoException("The out length should be ${RC2_BLOCK} byte.")
    }
    if(setKeyFlag != 1) {
        throw CryptoException("Please set the key first.")
    }
    cjRc2EcbEncrypt(inside, out, key, enc)
}
/**
 * Encryption and decryption
 *
 * @param inside - input data
 * @param out - output buffer, length of an encrypted block: 8
 * @param ks - RC2KEY
 * @param iv - Offset
 * @param enc - RC2_ENCRYPT / RC2_DECRYPT
 *
 * @return Unit
 * @since 0.32.5
 */
public func rc2CbcEncrypt(inside: Array<UInt8>, out: Array<UInt8>, ks: RC2KEY, iv: Array<UInt8>, enc: Int32): Unit {
    if(inside.size <= 0 || iv.size <= 0) {
        throw CryptoException("The inside or iv cannot be empty.")
    }
    if(setKeyFlag != 1) {
        throw CryptoException("Please set the key first.")
    }
    if(out.size != Int64(RC2_BLOCK)) {
        throw CryptoException("The out length should be ${RC2_BLOCK} byte.")
    }
    cjRc2CbcEncrypt(inside, out, inside.size, ks, iv, enc)
}

/**
 * The Function is rc2Ofb64Encrypt
 *
 * @param inside - input data
 * @param out - output buffer, length of an encrypted block: 8
 * @param schedule - RC2KEY
 * @param ivec - Offset
 *
 * @return Unit
 * @since 0.32.5
 */
public func rc2Ofb64Encrypt(inside: Array<UInt8>, out: Array<UInt8>, schedule: RC2KEY, ivec: Array<UInt8>, num: Int32): Unit {
    if(inside.size <= 0 || ivec.size <= 0) {
        throw CryptoException("The inside or iv cannot be empty.")
    }
    if(out.size != Int64(RC2_BLOCK)) {
        throw CryptoException("The out length should be ${RC2_BLOCK} byte.")
    }
    if(setKeyFlag != 1) {
        throw CryptoException("Please set the key first.")
    }
    if(num >= RC2_BLOCK || num < 0) {
        throw CryptoException("0 <= num < ${RC2_BLOCK}.")
    }
    cjRc2Ofb64Encrypt(inside, out, inside.size, schedule, ivec, num)
}

/**
 * The Function is rc2Cfb64Encrypt
 *
 * @param inside - input data
 * @param out - output buffer, length of an encrypted block: 8
 * @param schedule - RC2KEY
 * @param ivec - Offset
 * @param num - Offset index
 * @param enc - RC2_ENCRYPT / RC2_DECRYPT
 *
 * @return Unit
 * @since 0.32.5
 */
public func rc2Cfb64Encrypt(inside: Array<UInt8>, out: Array<UInt8>, schedule: RC2KEY, ivec: Array<UInt8>, num: Int32, enc: Int32): Unit {
    if(inside.size <= 0 || ivec.size <= 0) {
        throw CryptoException("The inside or iv cannot be empty.")
    }
    if(out.size != Int64(RC2_BLOCK)) {
        throw CryptoException("The out length should be ${RC2_BLOCK} byte.")
    }
    if(num >= Int32(ivec.size) || num < 0) {
        throw CryptoException("The num is not in the index of ivec.")
    }
    if(setKeyFlag != 1) {
        throw CryptoException("Please set the key first.")
    }
    cjRc2Cfb64Encrypt(inside, out, inside.size, schedule, ivec, num, enc)
}

func cjRc2SetKey(key: RC2KEY, len: Int32, data: Array<UInt8>, bits: Int32): Unit {
    let datas: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    unsafe {
        RC2_set_key(key.rc2ptr, len, datas.pointer, bits)
        releaseArrayRawData(datas)
    }
}

func cjRc2EcbEncrypt(inside: Array<UInt8>, out: Array<UInt8>, key: RC2KEY, enc: Int32): Unit {
    let ecbInside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let ecbOut: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(out) }
    unsafe {
        RC2_ecb_encrypt(ecbInside.pointer, ecbOut.pointer, key.rc2ptr, enc)
        releaseArrayRawData(ecbInside)
        releaseArrayRawData(ecbOut)
    }
}

func cjRc2CbcEncrypt(inside: Array<UInt8>, out: Array<UInt8>, length: Int64, ks: RC2KEY, iv: Array<UInt8>, enc: Int32): Unit {
    let cbcInside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let cbcOut: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(out) }
    let cbcIv: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(iv) }
    unsafe {
        RC2_cbc_encrypt(cbcInside.pointer, cbcOut.pointer, length, ks.rc2ptr, cbcIv.pointer, enc)
        releaseArrayRawData(cbcInside)
        releaseArrayRawData(cbcOut)
        releaseArrayRawData(cbcIv)
    }
}

func cjRc2Cfb64Encrypt(inside: Array<UInt8>, out: Array<UInt8>, length: Int64, schedule: RC2KEY, ivec: Array<UInt8>, num: Int32, enc: Int32): Unit {
    let cfb64Inside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let cfb64Out: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(out) }
    let cfb64Ivec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    let ptr = unsafe { malloc(4) }
    if (ptr.isNull()) {
        unsafe {
            releaseArrayRawData(cfb64Inside)
            releaseArrayRawData(cfb64Out)
            releaseArrayRawData(cfb64Ivec)
        }
        throw CryptoException("Malloc failed.")
    }
    let cfb64Num = unsafe {CPointer<Int32>(ptr)}
    unsafe {
        cfb64Num.write(num)
        RC2_cfb64_encrypt(cfb64Inside.pointer, cfb64Out.pointer, length, schedule.rc2ptr, cfb64Ivec.pointer, cfb64Num, enc)
        free(cfb64Num)
        releaseArrayRawData(cfb64Inside)
        releaseArrayRawData(cfb64Out)
        releaseArrayRawData(cfb64Ivec)
    }
}

func cjRc2Ofb64Encrypt(inside: Array<UInt8>, out: Array<UInt8>, length: Int64, schedule: RC2KEY, ivec: Array<UInt8>, num: Int32): Unit {
    let ofb64Inside: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
    let ofb64Out: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(out) }
    let ofb64Ivec: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(ivec) }
    let ptr = unsafe { malloc(4) }
    if (ptr.isNull()) {
        unsafe {
            releaseArrayRawData(ofb64Inside)
            releaseArrayRawData(ofb64Out)
            releaseArrayRawData(ofb64Ivec)
        }
        throw CryptoException("Malloc failed.")
    }
    let ofb64Num = unsafe {CPointer<Int32>(ptr)}
    unsafe {
        ofb64Num.write(num)
        RC2_ofb64_encrypt(ofb64Inside.pointer, ofb64Out.pointer, length, schedule.rc2ptr, ofb64Ivec.pointer, ofb64Num)
        free(ofb64Num)
        releaseArrayRawData(ofb64Inside)
        releaseArrayRawData(ofb64Out)
        releaseArrayRawData(ofb64Ivec)
    }
}
