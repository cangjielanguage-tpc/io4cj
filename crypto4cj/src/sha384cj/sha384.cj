/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides sha384
 */

package crypto4cj.sha384cj
import crypto4cj.utils.*
import encoding.hex.*

public let SHA384_DIGEST_LENGTH: Int64 = 48

/**
 * The class is SHA384CTX
 * @author guo_tingtingtekla
 * @since 0.32.5
 */
public class SHA384CTX {
    let ptr: CPointer<SHA512_CTX>

    /**
     * The Function is init SHA384CTX
     *
     * @since 0.32.5
     */
    public init() {
        /*
         * struct SHA256_CTX:
         * UInt64: 8 * 26 = 112
         * UInt8: 1 * 128 = 128
         * UInt32: 4 * 2 = 8
         * plus: 248
         */
        var ptr = unsafe { malloc(248) }
        var p = CPointer<SHA512_CTX>(ptr)
        this.ptr = p
        unsafe { SHA384_Init(p) }
    }

    ~init() {
        unsafe { free(ptr) }
    }
}

/**
 * The Function is sha384Update
 *
 * @param c - SHA384CTX
 * @param data - input data
 * @param len - input data length
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha384Update(c: SHA384CTX, data: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data can not be empty.")
    }
    cjSha384Update(c, data, Int32(data.size))
}

/**
 * The Function is sha384Final
 *
 * @param md - output data
 * @param c - SHA384CTX
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha384Final(md: Array<UInt8>, c: SHA384CTX): Unit {
    if(md.size != SHA384_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA384_DIGEST_LENGTH}.")
    }
    cjSha384Final(md, c)
}

/**
 * sha384
 *
 * @param data - input data
 * @param n - input data len
 * @param md - output data
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha384(data: Array<UInt8>, md: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    if(md.size != SHA384_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA384_DIGEST_LENGTH}.")
    }
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    unsafe {
        SHA384(p1.pointer, Int32(data.size), p2.pointer)
        releaseArrayRawData(p1)
        releaseArrayRawData(p2)
    }
}

func cjSha384Update(c: SHA384CTX, data: Array<UInt8>, len: Int32): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let ret = unsafe { SHA384_Update(c.ptr, p.pointer, len) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Update error")
    }
    unsafe { releaseArrayRawData(p) }
}

func cjSha384Final(md: Array<UInt8>, c: SHA384CTX): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    var ret = unsafe { SHA384_Final(p.pointer, c.ptr) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Final error")
    }
    unsafe { releaseArrayRawData(p) }
}
