/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.digestcj
import std.collection.*
import crypto4cj.utils.*

public class Digest {
    var ctx: UInt64 = 0
    var types: DigestType = DigestType.mdNull
    /*
     * Initialization Summary
     *
     * @param types - Summary Type
     */
    public init(types: DigestType) {
        loadLowApi(types)
        this.ctx = unsafe { EVP_MD_CTX_new() }
        this.types = types
        let ret: Int32 = unsafe { EVP_DigestInit(this.ctx, types.getEvpMd()) }
        if(ret != 1) {
            throw CryptoException("digest init error")
        }
    }
    /*
     * Summary Calculation
     *
     * @param data - Data that needs to be summarized
     * @return Unit
     */
    public func update(data: Array<UInt8>): Unit {
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
        let ret: Int32 = unsafe { EVP_DigestUpdate(this.ctx, p1.pointer, Int32(data.size)) }
        unsafe {
            releaseArrayRawData(p1)
        }
        if(ret != 1) {
            throw CryptoException("digest update error")
        } 
    }
    /*
     * Summary Results
     *
     * @return Array<UInt8>
     */
    public func final(): Array<UInt8> {
        let outLen: Int32 = this.types.getDigestSize()
        let outside: Array<UInt8> = Array<UInt8>(Int64(outLen), repeat: 0)
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
        var len: UInt32 = 0
        let p2 = CPointer<UInt32>(unsafe { malloc(4) })
        unsafe { p2.write(len)}
        let ret: Int32 = unsafe { EVP_DigestFinal(this.ctx, p1.pointer, p2) }
        if(ret != 1) {
            unsafe {
                releaseArrayRawData(p1)
                free(p2)
                EVP_MD_CTX_free(this.ctx)
            }
            throw CryptoException("digest final error")
        }
        var res: ArrayList<UInt8> = ArrayList<UInt8>(Int64(outLen))
        for(i in 0..Int64(outLen)) {
            let item = unsafe { p1.pointer.read(i) }
            res.add(item)
        }
        unsafe {
            releaseArrayRawData(p1)
            free(p2)
            EVP_MD_CTX_free(this.ctx)
        }
        return res.toArray()
    }
    /*
     * Summary Calculation
     *
     * @param types - Summary Type
     * @param data - Data that requires a summary
     * @return Array<UInt8>
     */
    public static func digest(types: DigestType, data: Array<UInt8>): Array<UInt8> {
        loadLowApi(types)
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
        let outLen: Int32 = types.getDigestSize()
        let outside: Array<UInt8> = Array<UInt8>(Int64(outLen), repeat: 0)
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
        var len: UInt32 = 0
        let p3 = CPointer<UInt32>(unsafe { malloc(4) })
        unsafe { p3.write(len)}
        let ret: Int32 = unsafe { EVP_Digest(p1.pointer, Int32(data.size), p2.pointer, p3, types.getEvpMd(), 0) }
        if(ret != 1) {
            unsafe {
                releaseArrayRawData(p1)
                releaseArrayRawData(p2)
                free(p3)
            }
            throw CryptoException("digest error")
        }
        var res: ArrayList<UInt8> = ArrayList<UInt8>(Int64(outLen))
        for(i in 0..Int64(outLen)) {
            let item = unsafe { p2.pointer.read(i) }
            res.add(item)
        }
        unsafe {
            releaseArrayRawData(p1)
            releaseArrayRawData(p2)
            free(p3)
        }
        return res.toArray()
    }
    
    // Whether to load low-level APIs
    public static func loadLowApi(types: DigestType): Unit {
        let ret: Bool = match(types.getName()) {
            case "MD4" | "MDC2" | "whirlpool" => true
            case _ => false
        }
        if(ret) {
            loadProvider()
        }   
    }
}


