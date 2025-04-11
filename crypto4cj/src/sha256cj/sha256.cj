/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides sha256
 */

package crypto4cj.sha256cj
import crypto4cj.sha224cj.*
import crypto4cj.utils.*
import encoding.hex.*

public let SHA256_DIGEST_LENGTH: Int64 = 32

/**
 * The class is SHA256CTX
 * @author guo_tingtingtekla
 * @since 0.32.5
 */
public class SHA256CTX {
    let ptr: CPointer<SHA256_CTX>

    /**
     * The Function is init SHA256CTX
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
        unsafe { SHA256_Init(p) }
    }

    ~init() {
        unsafe { free(ptr) }
    }
}

/**
 * The Function is sha256Update
 *
 * @param c - SHA256CTX
 * @param data - input data
 * @param len - input data len
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha256Update(c: SHA256CTX, data: Array<UInt8>): Unit {
    cjSha256Update(c, data, Int32(data.size))
}

/**
 * The Function is sha256Final
 *
 * @param md - output data
 * @param c - SHA256CTX
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha256Final(md: Array<UInt8>, c: SHA256CTX): Unit {
    if(md.size != SHA256_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA256_DIGEST_LENGTH}.")
    }
    cjSha256Final(md, c)
}

/**
 * sha256
 *
 * @param data - input data
 * @param n - input data len
 * @param md - output data
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha256(data: Array<UInt8>, md: Array<UInt8>): Unit {
    if(md.size != SHA256_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA256_DIGEST_LENGTH}.")
    }
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    unsafe {
        SHA256(p1.pointer, Int32(data.size), p2.pointer) 
        releaseArrayRawData(p1)
        releaseArrayRawData(p2)
    }
}

func cjSha256Update(c: SHA256CTX, data: Array<UInt8>, len: Int32): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let ret = unsafe { SHA256_Update(c.ptr, p.pointer, len) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Update error")
    }
    unsafe { releaseArrayRawData(p) }
}

func cjSha256Final(md: Array<UInt8>, c: SHA256CTX): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    var ret = unsafe { SHA256_Final(p.pointer, c.ptr) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Final error")
    }
    unsafe { releaseArrayRawData(p) }
}
