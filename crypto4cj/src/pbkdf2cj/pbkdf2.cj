/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.pbkdf2cj

import crypto4cj.utils.*
import crypto4cj.digestcj.*

/*
 * Generate a specified length key using the pbkdf2 Sha1 algorithm
 *
 * @param pass - Password for generating keys
 * @param salt - Salt value for generating keys, recommended at least 8 bytes
 * @param iter - Iteration count, recommended above 1000
 * @param keyLen - Output key length
 *
 * @return Array<UInt8> - secret key
 */
public func pbkdf2HmacSha1(pass: Array<UInt8>, salt: Array<UInt8>, iter: Int32, keyLen: Int32): Array<UInt8> {
    if(salt.size < 8) {
        throw CryptoException("Salt at least 8 bytes long")
    }
    if(Int64(iter) <= 0) {
        throw CryptoException("Iter greater than 0")
    }
    let passptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(pass) }
    let saltptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(salt) }
    let outPut: Array<UInt8> = Array<UInt8>(Int64(keyLen), repeat: 0)
    let outptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outPut) }
    let ret: Int32 = unsafe { PKCS5_PBKDF2_HMAC_SHA1(passptr.pointer, Int32(pass.size), saltptr.pointer, Int32(salt.size), iter, keyLen, outptr.pointer)}
    if(ret != 1) {
        unsafe {
            releaseArrayRawData(passptr)
            releaseArrayRawData(saltptr)
            releaseArrayRawData(outptr)
        }
        throw CryptoException("Pbkdf2 execution failed")
    }
    unsafe {
        releaseArrayRawData(passptr)
        releaseArrayRawData(saltptr)
        releaseArrayRawData(outptr)
    }
    return outPut
}

/*
 * Generate a specified length key using the pbkdf2 specified digest algorithm
 *
 * @param pass - Password for generating keys
 * @param salt - Salt value for generating keys, recommended at least 8 bytes
 * @param iter - Iteration count, recommended above 1000
 * @param digest - Summary algorithms (except for shake128, shake256, whitepool, md4, mdnull)
 * @param keyLen - Output key length
 *
 * @return Array<UInt8> - secret key
 */
public func pbkdf2Hmac(pass: Array<UInt8>, salt: Array<UInt8>, iter: Int32, digest: DigestType, keyLen: Int32): Array<UInt8> {
    if(salt.size < 8) {
        throw CryptoException("Salt at least 8 bytes long")
    }
    if(Int64(iter) <= 0) {
        throw CryptoException("Iter greater than 0")
    }
    let passptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(pass) }
    let saltptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(salt) }
    let outPut: Array<UInt8> = Array<UInt8>(Int64(keyLen), repeat: 0)
    let outptr: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outPut) }
    let ret: Int32 = unsafe { PKCS5_PBKDF2_HMAC(passptr.pointer, Int32(pass.size), saltptr.pointer, Int32(salt.size), iter, digest.getEvpMd(), keyLen, outptr.pointer)}
    if(ret != 1) {
        unsafe {
            releaseArrayRawData(passptr)
            releaseArrayRawData(saltptr)
            releaseArrayRawData(outptr)
        }
        throw CryptoException("Pbkdf2 execution failed")
    }
    unsafe {
        releaseArrayRawData(passptr)
        releaseArrayRawData(saltptr)
        releaseArrayRawData(outptr)
    }
    return outPut
}