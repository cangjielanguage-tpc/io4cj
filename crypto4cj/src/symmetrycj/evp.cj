/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.symmetrycj

import std.collection.*
import encoding.hex.*
import crypto4cj.utils.*

public let EVP_PADDING_NO: Int32 = 0
public let EVP_PADDING_PKCS7: Int32 = 1
public let EVP_PADDING_ISO7816_4: Int32 = 2
public let EVP_PADDING_ANSI923: Int32 = 3
public let EVP_PADDING_ISO10126: Int32 = 4
public let EVP_PADDING_ZERO: Int32 = 5

public class EVP {
    var evp: UInt64 = 0
    var enbuf: Array<UInt8>
    var enoutLen: Int32 = 0
    var enoutput: ArrayList<UInt8>
    var deoutLen: Int32 = 0
    var deoutput: ArrayList<UInt8>
    var debuf: Array<UInt8>
    
    init(){
        let e: UInt64 = unsafe { EVP_CIPHER_CTX_new() }
        this.evp = e
        this.enoutLen = 0
        this.enoutput = ArrayList<UInt8>()
        this.deoutLen = 0
        this.deoutput = ArrayList<UInt8>()
        this.enbuf = Array<UInt8>()
        this.debuf = Array<UInt8>()
    }
    func free() {
        unsafe { EVP_CIPHER_CTX_free(this.evp) }
    }

    func encryptInit(cipher: CIPHER, key: Array<UInt8>, iv: Array<UInt8>): Unit {
        let k: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(key) }
        let i: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(iv) }
        let ret: Int32 = unsafe { EVP_EncryptInit(this.evp, cipher.getCipher(), k.pointer, i.pointer) }
        if(ret != 1) {
            throw CryptoException("encrypt init error")
        }
        unsafe {
            releaseArrayRawData(k)
            releaseArrayRawData(i)
        }
    }

    func setPadding(pad: Int32): Unit {
        let ret: Int32 = unsafe { EVP_CIPHER_CTX_set_padding(this.evp, pad) }
        if(ret != 1) {
            throw CryptoException("Set Padding error")
        }
    }

    func encryptUpdate(input: Array<UInt8>): Unit {
        let len: Int64 = ((input.size >> 4 ) + 1) << 4
        let i: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(input) }
        this.enbuf = Array<UInt8>(len, repeat: 0)
        let o: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(this.enbuf) }
        let l: Int32 = 0
        let ptr = unsafe { malloc(4) }
        let outl = unsafe {CPointer<Int32>(ptr)}
        unsafe { outl.write(l)}
        let ret: Int32 = unsafe { EVP_EncryptUpdate(this.evp, o.pointer, outl, i.pointer, Int32(input.size)) }
        if(ret != 1) {
            throw CryptoException("encrypt update error")
        }
        this.enoutLen = unsafe { outl.read()}
        var res: ArrayList<UInt8> = ArrayList<UInt8>(Int64(this.enoutLen))
        for(i in 0..Int64(this.enoutLen)) {
            let item = unsafe { o.pointer.read(i) }
            res.add(item)
        }
        unsafe {
            releaseArrayRawData(i) 
            releaseArrayRawData(o)
            free(outl)
        }
        this.enoutput.add(all: res)
    }

    
    func encryptFinal(): Array<UInt8> {
        var e: Array<UInt8> = Array<UInt8>(this.enbuf.size + Int64(this.enoutLen), repeat: 0)
        let o: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(e) }
        let ptr = unsafe { malloc(4) }
        let outl = unsafe {CPointer<Int32>(ptr)}
        unsafe { outl.write(this.enoutLen)}
        let ret: Int32 = unsafe { EVP_EncryptFinal(this.evp, o.pointer, outl) }
        if(ret != 1) {
            throw CryptoException("encrypt final error")
        }
        var padOut: ArrayList<UInt8> = ArrayList<UInt8>()
        let len: Int32 = unsafe { outl.read()}

        for(i in 0..Int64(len)) {
            let item = unsafe { o.pointer.read(i) }
            padOut.add(item)
        }
        unsafe { 
            releaseArrayRawData(o) 
            free(outl)   
        }
        this.enoutput.add(all: padOut)
        return this.enoutput.toArray()
    }


    func decryptInit(cipher: CIPHER, key: Array<UInt8>, iv: Array<UInt8>): Unit {
        let k: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(key) }
        let i: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(iv) }
        let ret: Int32 = unsafe { EVP_DecryptInit(this.evp, cipher.getCipher(), k.pointer, i.pointer) }
        if(ret != 1) {
            throw CryptoException("decrypt init error")
        }
        unsafe {
            releaseArrayRawData(k)
            releaseArrayRawData(i)
        }
    }

    func decryptUpdate(input: Array<UInt8>): Unit {
        let len: Int64 = input.size
        let i: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(input) }
        this.debuf = Array<UInt8>(len, repeat: 0)
        let o: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(this.debuf) }
        let l: Int32 = 0
        let ptr = unsafe { malloc(4) }
        let outl = unsafe {CPointer<Int32>(ptr)}
        unsafe { outl.write(l)}
        let ret: Int32 = unsafe { EVP_DecryptUpdate(this.evp, o.pointer, outl, i.pointer, Int32(input.size)) }
        if(ret != 1) {
            throw CryptoException("decrypt update error")
        }
        this.deoutLen = unsafe { outl.read()}
        var res: ArrayList<UInt8> = ArrayList<UInt8>(Int64(this.deoutLen))
        for(i in 0..Int64(this.deoutLen)) {
            let item = unsafe { o.pointer.read(i) }
            res.add(item)
        }
        unsafe {
            releaseArrayRawData(i) 
            releaseArrayRawData(o)
            free(outl)
        }
       this.deoutput.add(all: res)
    }

    
    func decryptFinal(): Array<UInt8> {
        var d: Array<UInt8> = Array<UInt8>(this.debuf.size, repeat: 0)
        let o: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(d) }
        let ptr = unsafe { malloc(4) }
        let outl = unsafe {CPointer<Int32>(ptr)}
        unsafe { outl.write(this.deoutLen)}
        if(this.deoutput.size == this.debuf.size) {
            return this.deoutput.toArray()
        }
        let ret: Int32 = unsafe { EVP_DecryptFinal(this.evp, o.pointer, outl) }
        if(ret != 1) {
            throw CryptoException("decrypt final error")
        }
        var padOut: ArrayList<UInt8> = ArrayList<UInt8>()
        let len: Int32 = unsafe { outl.read()}

        for(i in 0..Int64(len)) {
            let item = unsafe { o.pointer.read(i) }
            padOut.add(item)
        }
        unsafe { 
            releaseArrayRawData(o)  
            free(outl)  
        }
        this.deoutput.add(all: padOut)
        return this.deoutput.toArray()
    }

}