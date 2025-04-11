/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.rsacj

import crypto4cj.utils.*
import std.collection.ArrayList

foreign func BIO_new(`type`: UInt64): UInt64

foreign func BIO_s_mem(): UInt64

foreign func BIO_new_mem_buf(buf: CPointer<UInt8>, len: Int32): UInt64

foreign func BIO_new_file(filename: CString, mode: CString): UInt64

foreign func BIO_read(b: UInt64, data: CPointer<UInt8>, dlen: Int32): Int32

foreign func BIO_free_all(a: UInt64): Unit

public class BIO {
    var bio: UInt64

    public init() {
        let m: UInt64 = unsafe { BIO_s_mem() }
        let b: UInt64 = unsafe { BIO_new(m) }
        if (b == 0) {
            throw CryptoException("Bio malloc failed")
        }
        this.bio = b
    }

    init(b: UInt64) {
        this.bio = b
    }

    public func getBio(): UInt64 {
        this.bio
    }

    public func free(): Unit {
        unsafe { BIO_free_all(bio) }
        this.bio = 0
    }

    ~init() {
        unsafe { BIO_free_all(bio) }
    }
    /*
     * Write data from buf to BIO
     *
     * @param buf - data
     * @return BIO
     */
    static func newMemBuf(buf: Array<UInt8>): BIO {
        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(buf) }
        let bio: UInt64 = unsafe { BIO_new_mem_buf(p.pointer, Int32(buf.size)) }
        unsafe { releaseArrayRawData(p) }
        BIO(bio)
    }
    /*
     * Write data from file to BIO
     *
     * @param filename - file path
     * @param mode 
     * @return BIO
     */
    public static func newFile(filename: String, mode: String): BIO {
        let file: CString = unsafe {LibC.mallocCString(filename) }
        let m: CString = unsafe { LibC.mallocCString(mode) }
        let ret: UInt64 = unsafe { BIO_new_file(file, m) }
        unsafe { 
            LibC.free(file)
            LibC.free(m) 
        }
        BIO(ret)
    } 

    /*
     * Reading data from BIO
     *
     * @return Array<UInt8>
     */
    public func read(): Array<UInt8> {
        let output: Array<UInt8> = Array<UInt8>(1024*1024, repeat: 0)
        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(output) }
        let ret: Int32 = unsafe { BIO_read(this.bio, p.pointer, Int32(output.size)) }
        var res: ArrayList<UInt8> = ArrayList<UInt8>(Int64(ret))
        for(i in 0..Int64(ret)) {
            let item: UInt8 = unsafe { p.pointer.read(i) }
            res.add(item)
        }
        if(ret <= 0) {
            throw CryptoException("Bio read error")
        }
        unsafe { releaseArrayRawData(p) }
        return res.toArray()
    }   
}