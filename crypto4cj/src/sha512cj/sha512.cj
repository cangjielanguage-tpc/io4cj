/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides sha512
 */

package crypto4cj.sha512cj
import crypto4cj.sha384cj.*
import crypto4cj.utils.*
import encoding.hex.*

public let SHA512_DIGEST_LENGTH: Int64 = 64

/**
 * The class is SHA512CTX
 * @author guo_tingtingtekla
 * @since 0.32.5
 */
public class SHA512CTX {
    let ptr: CPointer<SHA512_CTX>

    /**
     * The Function is init SHA512CTX
     *
     * @since 0.32.5
     */
    public init() {
        var ptr = unsafe { malloc(240) }
        var p = CPointer<SHA512_CTX>(ptr)
        this.ptr = p
        unsafe { SHA512_Init(p) }
    }

    ~init() {
        unsafe { free(ptr) }
    }
}

/**
 * The Function is sha512Update
 *
 * @param c - SHA512CTX
 * @param data - input data
 * @param len - input data len
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha512Update(c: SHA512CTX, data: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data can not be empty.")
    }
    cjSha512Update(c, data, Int32(data.size))
}

/**
 * The Function is sha512Final
 *
 * @param md - output data
 * @param c - SHA512CTX
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha512Final(md: Array<UInt8>, c: SHA512CTX): Unit {
    if(md.size != SHA512_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA512_DIGEST_LENGTH}.")
    }
    cjSha512Final(md, c)
}

/**
 * sha512
 *
 * @param data - input data
 * @param n -  input data length
 * @param md - output data
 *
 * @return Unit
 * @since 0.32.5
 */
public func sha512(data: Array<UInt8>, md: Array<UInt8>): Unit {
    if(data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    if(md.size != SHA512_DIGEST_LENGTH) {
        throw CryptoException("The length of md should be ${SHA512_DIGEST_LENGTH}4.")
    }
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    unsafe {
        SHA512(p1.pointer,  Int32(data.size), p2.pointer)
        releaseArrayRawData(p1)
        releaseArrayRawData(p2)
    }

}


func cjSha512Update(c: SHA512CTX, data: Array<UInt8>, len: Int32): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let ret = unsafe { SHA512_Update(c.ptr, p.pointer, len) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Update error")
    }
    unsafe { releaseArrayRawData(p) }
}

func cjSha512Final(md: Array<UInt8>, c: SHA512CTX): Unit {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    var ret = unsafe { SHA512_Final(p.pointer, c.ptr) }
    if(ret != 1) {
        unsafe { releaseArrayRawData(p) }
        throw CryptoException("Final error")
    }
    unsafe { releaseArrayRawData(p) }
}