/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 *
 * This is a class that provides md5
 */

package crypto4cj.rc4cj
import crypto4cj.utils.*

var setKeyFlag: Int32 = 0

/**
 * The Function is rc4SetKey
 *
 * @param key of RC4KEY
 * @param len of Int32
 * @param data of Array<UInt8>
 *
 * @return Type of Unit
 * @since 0.32.5
 */
public func rc4SetKey(key: RC4KEY, data: Array<UInt8>): Unit {
    setKeyFlag = 1
    if(data.size <= 0) {
        throw CryptoException("Key length is greater than 0.")
    }
    cjRc4SetKey(key, Int32(data.size), data)
}

/**
 * The Function is rc4
 *
 * @param key of RC4KEY
 * @param len of Int32
 * @param indata of Array<UInt8>
 * @param outdata of Array<UInt8>
 *
 * @return Type of Unit
 * @since 0.32.5
 */
public func rc4(key: RC4KEY, indata: Array<UInt8>, outdata: Array<UInt8>): Unit {
    if(indata.size <= 0 || outdata.size <= 0) {
        throw CryptoException("The indata or outdata cannot be empty.")
    }
    if(setKeyFlag != 1) {
        throw CryptoException("Please set the key first.")
    }
    cjRc4(key, Int32(indata.size), indata, outdata)
}

func cjRc4SetKey(key: RC4KEY, len: Int32, data: Array<UInt8>): Unit {
    let keys: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
    unsafe { 
        RC4_set_key(key.rcptr, len, keys.pointer) 
        releaseArrayRawData(keys)
    }
}

func cjRc4(key: RC4KEY, len: Int32, indata: Array<UInt8>, outdata: Array<UInt8>): Unit {
    let rIndata: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(indata) }
    let rOutdata: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outdata) }
    unsafe { 
        RC4( key.rcptr, len, rIndata.pointer, rOutdata.pointer) 
        releaseArrayRawData(rIndata) 
        releaseArrayRawData(rOutdata)
    }
}
