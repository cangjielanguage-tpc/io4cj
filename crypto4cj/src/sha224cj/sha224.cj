/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides sha224
 */

package crypto4cj.sha224cj
import crypto4cj.utils.*
import encoding.hex.*

public let SHA224_DIGEST_LENGTH: Int64 = 28

/**
 * The class is SHA224CTX
 * @author guo_tingtingtekla
 * @since 0.32.5
 */
public class SHA224CTX {
    let ptr: CPointer<SHA256_CTX>

    /**
     * The Function is init SHA224CTX
     *
     * @since 0.32.5
     */
    public init() {
        /*
         * struct SHA256_CTX:
         * UInt32: 4 * 28 = 112
         * plus: 112
         */
        var ptr = unsafe { malloc(112) }
        var p = CPointer<SHA256_CTX>(ptr)
        this.ptr = p
        unsafe { SHA224_Init(p) }
    }

    ~init() {
        unsafe { free(ptr) }
    }
}

/**
 * The Function is sha224Update
 *
 * @param c - SHA224CTX
 * @param data - input data
 * @param len - input data length
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha224Update(c: SHA224CTX, data: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data can not be empty.")
    }
    cjSha224Update(c, data, Int32(data.size))
}

/**
 * The Function is sha224Final
 *
 * @param md - output data
 * @param c - SHA224CTX
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha224Final(md: Array<UInt8>, c: SHA224CTX): Unit {
    if(md.size != SHA224_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA224_DIGEST_LENGTH}.")
    }
    cjSha224Final(md, c)
}

/**
 * sha224
 *
 * @param data - input data
 * @param n - inpput data len
 * @param md - output data
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha224(data: Array<UInt8>, md: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    if(md.size != SHA224_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA224_DIGEST_LENGTH}.")
    }
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    unsafe {
        SHA224(p1.pointer, Int32(data.size), p2.pointer) 
        unsafe { releaseArrayRawData(p1) }
        unsafe { releaseArrayRawData(p2) }
    }

}

func cjSha224Update(c: SHA224CTX, data: Array<UInt8>, len: Int32): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let ret = unsafe { SHA224_Update(c.ptr, p.pointer, len) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Update error")
    }
    unsafe { releaseArrayRawData(p) }
}

func cjSha224Final(md: Array<UInt8>, c: SHA224CTX): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    var ret = unsafe { SHA224_Final(p.pointer, c.ptr) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Final error")
    }
    unsafe { releaseArrayRawData(p) }
}