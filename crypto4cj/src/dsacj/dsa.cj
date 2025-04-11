/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is dsa.
 */
package crypto4cj.dsacj

import crypto4cj.utils.*
import crypto4cj.rsacj.*
import std.collection.*

/**
 * DSA signature verification type
 *
 * @since 0.34.3
 */
public enum DsaTypeId {
    | NID_md5
    | NID_sha1
    | NID_sha256
    | NID_sha384
    | NID_sha512
    | NID_md5_sha1
    | NULL

    /*
     * Get various types of values
     *
     * @return Int32 - Returns values of each type
     */
    public func getNum(): Int32 {
        match (this) {
            case NID_md5 => 4
            case NID_sha1 => 64
            case NID_sha256 => 672
            case NID_sha384 => 673
            case NID_sha512 => 674
            case NID_md5_sha1 => 114
            case NULL => 0
        }
    }
}

/**
 * Signature structure
 *
 * @since 0.34.3
 */
public class DSASIG {
    let r: UInt64

    /*
     * initialization DSASIG
     */
    public init() {
        this.r = 0
    }

    /*
     * initialization DSASIG
     *
     * @params r - DSASIG
     */
    public init(r: UInt64) {
        this.r = r
    }

    /*
     * Get DSASIG value
     *
     * @return UInt64
     */
    public func getDsaSign(): UInt64 {
        this.r
    }
}

/**
 * DSA structure
 *
 * @since 0.34.3
 */
public class DSA {
    var dsa: UInt64

    /*
     * Initialize DSA
     */
    public init() {
        this.dsa = 0
    }

    /*
     * Initialize DSA
     *
     * @params d - DSA 值
     */
    init(d: UInt64) {
        this.dsa = d
    }

    /*
     * Get DSA value
     *
     * @return UInt64
     */
    func getDsa(): UInt64 {
        this.dsa
    }

    /*
     * free DSA value
     *
     * @return Unit
     */
    func free(): Unit {
        unsafe { DSA_free(this.getDsa()) }
        this.dsa = 0
    }

}

/**
 * Allocating space for signature values
 *
 * @since 0.34.3
 */
public class SINCALLOC {
    let str: CString

    /*
     * Initialize SINCALLOC
     */
    public init(dsa: DSA) {
        let ret: CString = unsafe { LibC.mallocCString(" " * Int64(dsaSize(dsa))) } 
        this.str = ret
    }

    /*
     * Get SINCALLOC value
     *
     * @return UInt64
     */
    func getSinCalloc(): CString {
        this.str
    }
}

/**
 * Signature value of dsaSin
 *
 * @since 0.34.3
 */
public class SINSTR {
    let str: CString
    let len: Int32

    public init(s: CString, l: Int32) {
        this.str = s
        this.len = l
    }
    func getSinStr(): CString {
        this.str
    }
    public func getSinLen(): Int32 {
        this.len
    }
    public func getArrayUtf8(): Array<UInt8> {
        let size: Int64 = this.str.size()
        var res: ArrayList<UInt8> = ArrayList<UInt8>(size)
        for(i in 0..size) {
            let item = unsafe { this.str.getChars().read(i) }
            res.add(item)
        }
        return res.toArray()
    }
}

var isSetKey: Bool = false
/*
 * Generate a DSA data structure
 *
 * @return DSA
 */
public func dsaNew(): DSA {
    isSetKey = false
    let dsa = unsafe { DSA_new()}

    // dsa = 0, malloc failed
    if (dsa == 0) {
        throw CryptoException("error: dsaNew malloc failed")
    }

    return DSA(dsa) 
}

/*
 * Release DSA data structure
 *
 * @params dsa - DSA
 *
 * @return Unit
 */
func dsaFree(dsa: DSA): Unit {
    dsa.free()
}

/*
 * Generate Key Parameters
 *
 * @params dsa - DSA
 * @params bits - bits 512 ~ 1024 , bits % 64 = 0
 *
 * @return Unit
 */
public func dsaGenerateParameters(dsa: DSA, bits: Int32): Unit {
    isSetKey = true
    if(bits < 512 || bits > 1024 || (bits % 64 != 0)) {
        throw CryptoException("Bits are between 512 and 1024 and are multiples of 64.")
    }
    unsafe { DSA_generate_parameters_ex(dsa.getDsa(), bits, CPointer<UInt8>(), 0, CPointer<Int32>(), CPointer<UInt64>(), 0) }
}

/*
 * Generate public and private keys according to key parameters
 *
 * @params dsa - DSA
 *
 * @return Unit
 */
public func dsaGenerateKey(dsa: DSA): Unit {
    unsafe { DSA_generate_key(dsa.getDsa()) }
}

/*
 * DSA signature
 *
 * @params types - Dsa signature type
 * @params dgst - Signature data
 * @params sig - Signature value buffer
 * @params dsa - DSA
 *
 * @return Array<UInt8> - Actual value after signing, dsaVerify params
 *        UInt32 - Length after signature, dsaVerify params
 */
public func dsaSign(types: DsaTypeId, dgst: Array<UInt8>, sig: SINCALLOC, dsa: DSA): SINSTR {
    if(dgst.size <= 0) {
        throw CryptoException("The dgst cannot be empty!")
    }
    let (ret, sinStr, siglen) = cjDsaSign(types.getNum(), dgst, sig.getSinCalloc(), 0, dsa.getDsa())
    if(ret != 1) {
        throw CryptoException("Sign error!")
    }
    return SINSTR(sinStr, Int32(siglen))
}

/*
 * DSA validation
 *
 * @params types - The dsa verification type is consistent with the signature type
 * @params dgst - Signature data
 * @params sigbuf - Value after signing --> dsaSign return
 * @params siglen - Signature value length --> dsaSign return
 * @params dsa - DSA
 *
 * @return Int32
 */
public func dsaVerify(types: DsaTypeId, dgst: Array<UInt8>, sigbuf: SINSTR, dsa: DSA): Int32 {
    if(dgst.size <= 0) {
        throw CryptoException(" The dgst cannot be empty!")
    }
    let ret = cjDsaVerify(types.getNum(), dgst, Int32(dgst.size), sigbuf.getSinStr(), sigbuf.getSinLen(), dsa.getDsa())
    if(ret != 1) {
        throw CryptoException("Verify error!")
    }
    return ret
}

/*
 * Get the number of bytes of DSA key length
 *
 * @params dsa - DSA
 *
 * @return Int32
 */
public func dsaSize(dsa: DSA): Int32 {
    let size = unsafe { DSA_size(dsa.getDsa()) }
    if (size <= 0) {
        dsaFree(dsa)
        throw CryptoException("error: dsa size is invalid")
    }

    return size
}

/*
 * Output DSA key and related parameters
 *
 * @params dsa - DSA
*
 * @return Array<UInt8>
 */
public func dsaPrint(dsa: DSA): Array<UInt8> {
    let bio: BIO = BIO()
    let ret = unsafe { DSA_print(bio.getBio(), dsa.getDsa(), 0) }
    if(ret != 1) {
        throw CryptoException("DSA key print error")
    }
    return bio.read()
}

/*
 * Generate DSA public key pem file
 *
 * @params pub_key_fn - File Path
 * @params dsa - DSA
 *
 * @return Unit
 */
public func pemWriteDsaPub(pub_key_fn: String, dsa: DSA): Unit {
    if(!isSetKey) {
        throw CryptoException("Please set the dsa key parameters first!")
    }
    if(pub_key_fn.size <= 0) {
        throw CryptoException("Please provide the path of DSA public key file!")
    }
    let endStr: String = pub_key_fn[(pub_key_fn.size - 4)..]
    if(endStr != ".pem") {
        throw CryptoException("The end of the file name is .pem")
    }
    var bio: BIO = BIO.newFile(pub_key_fn, "w")
    let ret = unsafe { PEM_write_bio_DSA_PUBKEY(bio.getBio(), dsa.getDsa())}
    bio.free()
    if(ret != 1) {
        throw CryptoException("DSA public key file generation failed!")
    }
}

/*
 * Generate DSA private key pem file
 *
 * @params pub_key_fn - File Path
 * @params dsa - DSA
 *
 * @return Unit
 */
public func pemWriteDsaPri(pub_key_fn: String, dsa: DSA): Unit {
    if(!isSetKey) {
        throw CryptoException("Please set the dsa key parameters first!")
    }
    if(pub_key_fn.size <= 0) {
        throw CryptoException("Please provide the path of DSA private key file!")
    }
    let endStr: String = pub_key_fn[(pub_key_fn.size - 4)..]
    if(endStr != ".pem") {
        throw CryptoException("The end of the file name is .pem")
    }
    var bio: BIO = BIO.newFile(pub_key_fn, "w")
    let ret = unsafe { PEM_write_bio_DSAPrivateKey(bio.getBio(), dsa.getDsa(), 0, LibC.mallocCString(""), 0, CFunc<(CString, Int32, Int32, CString) -> Int32>(CPointer<Int32>()), CPointer<Unit>())}
    bio.free()
    if(ret != 1) {
        throw CryptoException("DSA private key file generation failed!")
    }
}

/*
 * Generate DSA key parameter pem file
 *
 * @params pub_key_fn - File Path
 * @params dsa - DSA
 *
 * @return Unit
 */
public func pemWriteDsaPara(pub_key_fn: String, dsa: DSA): Unit {
    if(!isSetKey) {
        throw CryptoException("Please set the dsa key parameters first!")
    }
    if(pub_key_fn.size <= 0) {
        throw CryptoException("Please provide the path of DSA key parameter file!")
    }
    let endStr: String = pub_key_fn[(pub_key_fn.size - 4)..]
    if(endStr != ".pem") {
        throw CryptoException("The end of the file name is .pem")
    }
    var bio: BIO = BIO.newFile(pub_key_fn, "w")
    let ret = unsafe { PEM_write_bio_DSAparams(bio.getBio(), dsa.getDsa())}
    bio.free()
    if(ret != 1) {
        throw CryptoException("DSA key parameter file generation failed!")
    }
}

/*
 * Read DSA private key from private key file
 *
 * @params pri_key_fn - File Path
 *
 * @return DSA
 */
public func pemReadDsaPri(pri_key_fn: String): DSA {
    if(pri_key_fn.size <= 0) {
        throw CryptoException("Please provide the path of DSA private key file!")
    }
    var bio: BIO = BIO.newFile(pri_key_fn, "rb")
    let ret = unsafe { PEM_read_bio_DSAPrivateKey(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), CString(CPointer<UInt8>()))}
    if(ret == 0) {
        throw CryptoException("Invalid dsa private key file!")
    }
    bio.free() 
    return DSA(ret)
}

/*
 * Read DSA public key from public key file
 *
 * @params pub_key_fn - File Path
 *
 * @return DSA
 */
public func pemReadDsaPub(pub_key_fn: String): DSA {
    if(pub_key_fn.size <= 0) {
        throw CryptoException("Please provide the path of DSA public key file!")
    }
    var bio: BIO = BIO.newFile(pub_key_fn, "rb")
    let ret = unsafe { PEM_read_bio_DSA_PUBKEY(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), CPointer<Unit>())}
    if(ret == 0) {
        throw CryptoException("Invalid dsa public key file!")
    }
    bio.free()
    return DSA(ret)
}

/*
 * DSA DSA Digital Signature
 *
 * @params dgst - Signature data
 * @params pri_key_fn - File Path
 *
 * @return DSA
 */
public func dsaDoSign(dgst: Array<UInt8>, pri_key_fn: String): DSASIG {
    if(dgst.size <= 0) {
        throw CryptoException("The dgst cannot be empty!")
    }
    if(pri_key_fn.size <= 0) {
        throw CryptoException("Please provide the path of DSA private key file!")
    }
    let ret: UInt64 = unsafe { cjDsaDoSign(dgst, Int32(dgst.size), pri_key_fn)}
    if(ret == 0) {
        throw CryptoException("Invalid dsa private key file!")
    }
    return DSASIG(ret)
}

/*
 * DSA digital signature verification
 *
 * @params dgst - Signature data
 * @params sig - Signature structure (taken from the returned value of dsaDoSign)
 * @params pub_key_fn - File Path
 *
 * @return DSA
 */
public func dsaDoVerify(dgst: Array<UInt8>, sig: DSASIG, pub_key_fn: String): Int32 {
    if(dgst.size <= 0) {
        throw CryptoException("The dgst cannot be empty!")
    }
    if(pub_key_fn.size <= 0) {
        throw CryptoException("Please provide the path of DSA public key file!")
    }
    let ret = unsafe { cjDsaDoVerify(dgst, Int32(dgst.size), sig.getDsaSign(), pub_key_fn)}
    if(ret != 1) {
        throw CryptoException("Verify error!")
    }
    return ret
}

func cjDsaSign(types: Int32, dgst: Array<UInt8>, sig: CString, siglen: Int32, dsa: UInt64): (Int32, CString, UInt32) {
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(dgst) }
    let p2 = unsafe {CPointer<UInt32>(LibC.malloc(count: 4))}
    unsafe { p2.write(UInt32(siglen))}
    var ret = unsafe { DSA_sign(types, p1.pointer, Int32(dgst.size), sig, p2, dsa) }
    var len = unsafe {p2.read()}
    unsafe {
        releaseArrayRawData(p1)
        LibC.free(p2)
    }
    return (ret, sig, len)
}

func cjDsaVerify(types: Int32, dgst: Array<UInt8>, dgst_len: Int32, sigbuf: CString, siglen: Int32, dsa: UInt64): Int32 {
    let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(dgst) }
    var ret = unsafe { DSA_verify(types, p1.pointer, dgst_len,  sigbuf, siglen, dsa) }
    unsafe { releaseArrayRawData(p1) }
    return ret
}

func cjDsaDoSign(dgst: Array<UInt8>, dlen: Int32, pri_key_fn: String): UInt64 {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(dgst) }
    let dsa: UInt64 = pemReadDsaPri(pri_key_fn).getDsa()
    println(dsa)
    var ret = unsafe { DSA_do_sign(p.pointer, dlen, dsa) }
    unsafe { releaseArrayRawData(p) }
    return ret
}

func cjDsaDoVerify(dgst: Array<UInt8>, dgst_len: Int32, sig: UInt64, pub_key_fn: String): Int32 {
    let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(dgst) }
    let rsa: UInt64 = pemReadDsaPub(pub_key_fn).getDsa()
    var ret = unsafe { DSA_do_verify(p.pointer, dgst_len, sig, rsa) }
    unsafe { releaseArrayRawData(p) }
    return ret
}