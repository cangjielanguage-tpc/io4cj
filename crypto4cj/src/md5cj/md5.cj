/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is md5.
 */
package crypto4cj.md5cj

import crypto4cj.utils.*
import encoding.hex.*
import std.io.*

public let MD5_DIGEST_LENGTH: Int64 = 16

/**
 * Call this function circularly to add different data together to calculate MD5. If successful, 1 will be returned. If unsuccessful, 0 will be returned
 *
 * @param MD5CTX - init MD5CTX
 * @param data - data to be encrypted
 * @param len - length of data to be encrypted
 *
 * @return Int32 - success: 1, failure: 0
 * @since 0.32.5
 */
public func md5Update(c: MD5CTX, data: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    cjMd5Update(c, data, Int32(data.size))
}

/**
 * The Function is md5Final
 *
 * @param md - encrypted data
 * @param c - init MD5CTX
 *
 * @return Int32 - success: 1, failure: 0
 * @since 0.32.5
 */
public func md5Final(md: Array<UInt8>, c: MD5CTX): Unit {
    if(md.size < 16) {
        throw CryptoException("md5Final: The length of md is greater than or equal to ${MD5_DIGEST_LENGTH}.")
    }
    cjMd5Final(md, c)
}

/**
 * md5
 *
 * @param data -data to be encrypted
 * @param n - length of data to be encrypted
 * @param md - encrypted data
 *
 * @return Type of Array<UInt8>
 * @since 0.32.5
 */
public func md5(data: Array<UInt8>, md: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    if(md.size < 16) {
        throw CryptoException("md5: The length of md is greater than or equal to ${MD5_DIGEST_LENGTH}.")
    }
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    unsafe { 
        MD5(p1.pointer, Int32(data.size), p2.pointer) 
        releaseArrayRawData(p1)
        releaseArrayRawData(p2)
    }
}

/**
 * The Function is md5HexToString, len is 32
 *
 * @param md - data
 *
 * @return String - result
 * @since 0.32.5
 */
public func md5HexToString(md: Array<UInt8>): String {
    return toHexString(md)[..(MD5_DIGEST_LENGTH * 2)]
}


func cjMd5Update(c: MD5CTX, data: Array<UInt8>, len: Int32): Unit {    
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let ret = unsafe { MD5_Update(c.md5ptr, p.pointer, len) }
    unsafe { releaseArrayRawData(p) }
    if(ret != 1) {
        throw CryptoException("md5Update error")
    }
}

func cjMd5Final(md: Array<UInt8>, c: MD5CTX): Unit {
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    var ret = unsafe { MD5_Final(p1.pointer, c.md5ptr) }
    unsafe { releaseArrayRawData(p1) }
    if(ret != 1) {
        throw CryptoException("md5Final error")
    }
}