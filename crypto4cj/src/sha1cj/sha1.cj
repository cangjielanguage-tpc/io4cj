/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides sha1
 */

package crypto4cj.sha1cj
import crypto4cj.utils.*
import encoding.hex.*

public let SHA_DIGEST_LENGTH: Int64 = 20

/**
 * The Function is sha1Update
 *
 * @param c - SHACTX
 * @param data - input data
 * @param len - input data length
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha1Update(c: SHACTX, data: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data can not be empty.")
    }
    cjSha1Update(c, data, Int32(data.size))
}

/**
 * The Function is sha1Final
 *
 * @param md - output data
 * @param c - SHACTX
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha1Final(md: Array<UInt8>, c: SHACTX): Unit {
    if(md.size != SHA_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA_DIGEST_LENGTH}.")
    }
    cjSha1Final(md, c)
}

/**
 * sha1
 *
 * @param data - input data
 * @param n - input data length
 * @param md - output data length
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha1(data: Array<UInt8>, md: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    if(md.size != SHA_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA_DIGEST_LENGTH}.")
    }
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    unsafe { 
        SHA1(p1.pointer, Int32(data.size), p2.pointer) 
        unsafe { releaseArrayRawData(p1) }
        unsafe { releaseArrayRawData(p2) }

    }
    
}

func cjSha1Update(c: SHACTX, data: Array<UInt8>, len: Int32): Unit {    
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let ret = unsafe { SHA1_Update(c.ptr, p.pointer, len) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Update error")
    }
    unsafe { releaseArrayRawData(p) }
}

func cjSha1Final(md: Array<UInt8>, c: SHACTX): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    var ret = unsafe { SHA1_Final(p.pointer, c.ptr) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Final error")
    }
    unsafe { releaseArrayRawData(p) }
}
