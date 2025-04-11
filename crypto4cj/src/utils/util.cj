/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 *
 * This is a util
 */

package crypto4cj.utils

import std.collection.*
import encoding.hex.*

public func arrayTo2Array(arr: Array<UInt8>, bits: Int64): ArrayList<Array<UInt8>> {
    var arrlist: ArrayList<UInt8> = ArrayList<UInt8>.of(arr)

    var newArr: ArrayList<Array<UInt8>> = ArrayList<Array<UInt8>>()
    var i: Int64 = 0
    var n = arrlist.size % bits
    
    if(n > 0) {
        var a = Array<UInt8>((bits - n), repeat: 0 )
        arrlist.add(all: a)
    }
    var inside: Array<UInt8> = arrlist.toArray()
    for(_ in 0..inside.size) {
        if(i == inside.size) {
            return newArr
        }
        newArr.add(inside.slice(i, bits))        
        i = i + bits  
    }

    return newArr
}

/*
 * The class is Crypto exception handling
 * @since 0.32.5
 */
public class CryptoException <: Exception {
    public init() {
        super()
    }
    public init(messages: String) {
        super(messages)
    }
}

// Which version of the API is loaded 
foreign func OSSL_PROVIDER_load(libctx: UInt64, name: CString): UInt64

public func loadProvider(): Unit {
    let str: CString = unsafe {LibC.mallocCString("legacy")}  
    let r: UInt64 = unsafe { OSSL_PROVIDER_load(0, str) } 
    if (r == 0) {
        throw CryptoException("Failed to load Legacy provider")
    }
    unsafe {
        LibC.free(str)
    }
}