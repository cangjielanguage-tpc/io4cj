/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is HMAC.
 */
package crypto4cj.hmaccj

import crypto4cj.utils.*

/**
 * Summary Type
 *
 * @since 0.34.3
 */
public enum AlgorithmType <: ToString{
    | Sha1
    | Sha224
    | Sha256
    | Sha384
    | Sha512
    | Md5

    public func toString(): String {
        match (this) {
            case Sha1 => "Sha1"
            case Sha224 => "Sha224"
            case Sha256 => "Sha256"
            case Sha384 => "Sha384"
            case Sha512 => "Sha512"
            case Md5 => "Md5"
        }
    }
    public func getBits(): Int32 {
        match (this) {
            case Sha1 => 20
            case Sha224 => 28
            case Sha256 => 32
            case Sha384 => 48
            case Sha512 => 64
            case Md5 => 16
        }
    }

}

/**
 * hmacInit、hmacUpdate、hmacFinal Combined use for digest encryption.
 *
 * @since 0.34.3
 */
public class HMACCJ {
    var ctxPtr: UInt64 = 0
    var algorithmPtr: AlgorithmType = AlgorithmType.Md5

    /*
     * Initialize HMACCJ
     */
    public init() {
        var ctxPtr = unsafe { HMAC_CTX_new() }
        // ctxPtr = 0, malloc failed
        if (ctxPtr == 0) {
            throw CryptoException("error: hmac malloc failed")
        }
        this.ctxPtr = ctxPtr
    }

    ~init() {
        unsafe { HMAC_CTX_free(this.ctxPtr) }
    }

    /*
     * Hmac digest calculation initialization
     *
     * @params key - secret key
     * @params algorithm - Summary Type
     *
     * @return Unit
     */
    public func hmacInit(key: Array<UInt8>, algorithm: AlgorithmType): Unit {
        if(key.size <= 0) {
            throw CryptoException("The key cannot be empty.")
        }
        this.algorithmPtr = algorithm
        hmacInitC(this.ctxPtr, key, Int32(key.size), this.algorithmPtr.toString())
    }

    /*
     * Perform summary calculation. This function can be run multiple times to summarize multiple data.
     *
     * @params data - Data requiring HMAC operation
     *
     * @return Unit
     */
    public func hmacUpdate(data: Array<UInt8>): Unit {
        if(data.size <= 0) {
            throw CryptoException("The data cannot be empty.")
        }
        hmacUpdateC(this.ctxPtr, data, Int32(data.size))
    }

    /*
     * Perform summary calculation and use it together with hmacInit and hmacUpdate.
     *
     * @params md - Store HMAC values
     *
     * @return Unit
     */
    public func hmacFinal(md: Array<UInt8>): Unit {
        if(md.size != Int64(this.algorithmPtr.getBits())) {
            throw CryptoException("The md size should be ${this.algorithmPtr.getBits()}.")
        }
        hmacFinalC(this.ctxPtr, md, 0)
    }

}

/*
 * Total digest algorithm
 *
 * @params algorithm - Summary Type
 * @params key - secret key
 * @params data - Data requiring HMAC operation
 * @params md - Store HMAC values
 *
 * @return Unit
 */
public func hmac(algorithm: AlgorithmType, key: Array<UInt8>, data: Array<UInt8>, md: Array<UInt8>): Unit {
    if(key.size <= 0) {
        throw CryptoException("The key cannot be empty.")
    }
    if(data.size <= 0) {
        throw CryptoException("The data cannot be empty.")
    }
    if(md.size != Int64(algorithm.getBits())) {
        throw CryptoException("The md size should be ${algorithm.getBits()}.")
    }
    hmacC(algorithm, key, Int32(key.size), data, UIntNative(data.size), md)
}

func hmacInitC(ctx: UInt64, key: Array<UInt8>, len: Int32, algorithm: String): Int32 {
    let keyptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(key) }
    let md: UInt64 = unsafe { EVP_get_digestbyname(LibC.mallocCString(algorithm.toString())) }
    let res = unsafe { HMAC_Init(ctx, keyptr.pointer, len, md, 0) }
    unsafe { releaseArrayRawData(keyptr) }
    return res
}

func hmacUpdateC(ctx: UInt64, data: Array<UInt8>, len: Int32): Int32 {
    let dataptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let res = unsafe { HMAC_Update(ctx, dataptr.pointer, len) }
    unsafe { releaseArrayRawData(dataptr) }
    return res
}

func hmacFinalC(ctx: UInt64, md: Array<UInt8>, len: UInt32): Int32 {
    let mdptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    var res = unsafe { HMAC_Final(ctx, mdptr.pointer, len) }
    unsafe { releaseArrayRawData(mdptr) }
    return res
}

func hmacC(algorithm: AlgorithmType, key: Array<UInt8>, key_len: Int32,
                    data: Array<UInt8>, data_len: UIntNative,
                    md: Array<UInt8>): Unit {
    let keyptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(key) }
    let dataptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    let mdptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(md) }
    unsafe {
        let md: UInt64 = unsafe { EVP_get_digestbyname(LibC.mallocCString(algorithm.toString())) }
        HMAC(md, keyptr.pointer, key_len, dataptr.pointer, data_len, mdptr.pointer, CPointer<UInt32>())
        releaseArrayRawData(keyptr)
        releaseArrayRawData(dataptr)
        releaseArrayRawData(mdptr)
    }

}