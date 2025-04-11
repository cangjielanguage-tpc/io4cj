/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */


package crypto4cj.rsacj

import crypto4cj.utils.*
import crypto4cj.digestcj.*
import crypto4cj.bignumcj.*
import crypto4cj.symmetrycj.*
import std.collection.*
import std.fs.*

let  RSA_MIN_MODULUS_BITS: Int32 = 512
let  RSA_MAX_MODULUS_BITS: Int32 = 16384

/**
 * RSA encrypt decrypt padding modes
 *
 * @since 0.34.3
 */
public enum PADDING {
| RSA_PKCS1_PADDING
| RSA_NO_PADDING
| RSA_PKCS1_OAEP_PADDING
| RSA_X931_PADDING

    /*
     * Get flen number of values
     *
     * @return Int32 - Returns values of each type
     */
    public func getFlen(rsaSize: Int32): Int32 {
        match (this) {
            case RSA_PKCS1_PADDING => rsaSize - 11
            case RSA_NO_PADDING => rsaSize
            case RSA_PKCS1_OAEP_PADDING => rsaSize - 42
            case RSA_X931_PADDING => rsaSize - 2
        }
    }
    /*
     * Get padding number of values
     *
     * @return Int32 - Returns values of each type
     */
    func getPadding(): Int32 {
        match (this) {
            case RSA_PKCS1_PADDING => 1
            case RSA_NO_PADDING => 3
            case RSA_PKCS1_OAEP_PADDING => 4
            case RSA_X931_PADDING => 5
        }
    }
}

/*
 * RSA
 */
public class RSA {
    var rsa: UInt64

    init() {
        let r: UInt64 = unsafe { RSA_new() }
        if (r == 0) {
            throw CryptoException("Rsa malloc failed")
        }
        this.rsa = r
    }

    init(d: UInt64) {
        this.rsa = d
    }

    func getRsa(): UInt64 {
        this.rsa
    }

    func free(): Unit {
        unsafe { RSA_free(this.getRsa()) }
        this.rsa = 0
    }

    /*
     * Generate private key
     *
     * @param bits - Generate private key digits
     * @return RSAPrivateKey - private key
     */
    public static func generateKey(bits: Int32): RSAPrivateKey {
        if(bits < RSA_MIN_MODULUS_BITS) {
            throw CryptoException("Low security level.")
        }
        if(bits > RSA_MAX_MODULUS_BITS) {
            throw CryptoException("Bits are too long.")
        }
        var rsa: UInt64 = unsafe { RSA_generate_key(bits, 65537, CFunc<(Int32, Int32, CPointer<Unit>) -> CPointer<Unit>>(CPointer<Unit>()), CPointer<Unit>()) }
        let ret = unsafe { RSA_check_key(rsa) }
        if(ret != 1) {
            throw CryptoException("Illegal RSA key.")
        }
        RSAPrivateKey(rsa)
    }
    /*
     * Set private key based on param
     *
     * @param n - 模数
     * @param e - Public key index
     * @param d - Private key index
     * @param p - prime number
     * @param q - prime number
     * @param dmp = (e^-1) % (p - 1) Can be used bignum  bnModInverse
     * @param dmq = (e^-1) % (q - 1) Can be used bignum  bnModInverse
     * @param iqmp - = (q^-1) % p Can be used bignum  bnModInverse
     * @return RSAPrivateKey - private key
     */
    public static func setKey(n: Array<UInt8>,
                            e: Array<UInt8>,
                            d: Array<UInt8>,
                            p: Array<UInt8>,
                            q: Array<UInt8>,
                            dmp: Array<UInt8>,
                            dmq: Array<UInt8>,
                            iqmp: Array<UInt8>): RSAPrivateKey {
        let n0: CPointer<BIGNUM> = arrayToBn(n)           
        let e0: CPointer<BIGNUM> = arrayToBn(e)           
        let d0: CPointer<BIGNUM> = arrayToBn(d)           
        let p0: CPointer<BIGNUM> = arrayToBn(p)           
        let q0: CPointer<BIGNUM> = arrayToBn(q)           
        let dmp0: CPointer<BIGNUM> = arrayToBn(dmp)           
        let dmq0: CPointer<BIGNUM> = arrayToBn(dmq)           
        let iqmp0: CPointer<BIGNUM> = arrayToBn(iqmp)   
        var ret: Int32 = 0
        var key: RSA = RSA()
        ret = unsafe { RSA_set0_key(key.getRsa(), n0, e0, d0) }
        ret = unsafe { RSA_set0_factors(key.getRsa(), p0, q0) }
        ret = unsafe { RSA_set0_crt_params(key.getRsa(), dmp0, dmq0, iqmp0) }
        ret = unsafe { RSA_check_key(key.getRsa()) }
        if(ret != 1) {
            throw CryptoException("Illegal RSA key.")
        }
        RSAPrivateKey(key.getRsa())
    }
    /*
     * Setting a private key through a key array
     *
     * @param key - Private key array
     * @return RSAPrivateKey - key
     */
    public static func setPrivateKey(key: Array<UInt8>): RSAPrivateKey {
        var bio: BIO = BIO.newMemBuf(key)
        let ptr = CPointer<UInt64>(unsafe { malloc(8) })
        unsafe { ptr.write(0) }
        let t: UInt64 = unsafe { d2i_PrivateKey_bio(bio.getBio(), ptr) }
        if(t == 0) {
            bio.free()
            unsafe { free(ptr) }
            throw CryptoException("Illegal RSA private key.")
        }
        let rsa: UInt64 = unsafe { EVP_PKEY_get0_RSA(t)}
        bio.free()
        unsafe { free(ptr) }
        let ret = unsafe { RSA_check_key(rsa) }
        if(ret != 1) {
            throw CryptoException("Illegal RSA private key.")
        }
        RSAPrivateKey(rsa)
    }

    /*
     * Set public key through key array
     *
     * @param key - Public key array
     * @return RSAPublicKey - public key
     */
    public static func setPublicKey(key: Array<UInt8>): RSAPublicKey {
        var bio: BIO = BIO.newMemBuf(key)
        var pubKey: RSA = RSA()
        let ptr = CPointer<UInt64>(unsafe { malloc(8) })
        unsafe { ptr.write(pubKey.getRsa()) }
        let t: UInt64 = unsafe { d2i_RSAPublicKey_bio(bio.getBio(), ptr) }
        if(t <= 0) {
            bio.free()
            unsafe { free(ptr) } 
            throw CryptoException("Illegal RSA public key.")
        }
        bio.free()
        unsafe { free(ptr) }   
        RSAPublicKey(t)
    }

    public static func setPkcs8PublicKey(key: Array<UInt8>): RSAPublicKey {
        var bio: BIO = BIO.newMemBuf(key)
        var pubKey: RSA = RSA()
        let ptr = CPointer<UInt64>(unsafe { malloc(8) })
        unsafe { ptr.write(pubKey.getRsa()) }
        let t: UInt64 = unsafe { d2i_RSA_PUBKEY_bio(bio.getBio(), ptr) }
        if(t <= 0) {
            bio.free()
            unsafe { free(ptr) } 
            throw CryptoException("Illegal RSA PKCS8 public key.")
        }
        bio.free()
        unsafe { free(ptr) }   
        RSAPublicKey(t)
    }

    /*
     * Set the private key by reading the Keyfile
     *
     * @param f - Private key file path
     * @param password - Private key file password (optional)
     * @return RSAPrivateKey - Private key
     */
    public static func readPriKeyfromFile(f: String, password!: String = ""): RSAPrivateKey {
        if(!exists(f)) {
            throw CryptoException("The file does not exist")
        }
        var bio: BIO = BIO.newFile(f, "rb")
        var t: UInt64 = 0
        if(password.size == 0) {
            t = unsafe { PEM_read_bio_PrivateKey(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), CString(CPointer<UInt8>())) }      
        } else {
            let pass: CString = unsafe {LibC.mallocCString(password)} 
            t = unsafe { PEM_read_bio_PrivateKey(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), pass) }
             unsafe {
                LibC.free(pass)
            }
        }
        bio.free()
        if(t == 0) {       
            throw CryptoException("Illegal RSA Private key.")
        }
        let rsa: UInt64 = unsafe { EVP_PKEY_get0_RSA(t)}
        if(rsa == 0) {
            throw CryptoException("Illegal RSA Private key.")
        }
        return RSAPrivateKey(rsa)
    }

    /*
     * Set public key by reading public key file
     *
     * @param f - Public key file path
     * @return RSAPublicKey - public key
     */
    public static func readPubKeyfromFile(f: String): RSAPublicKey {
        if(!exists(f)) {
            throw CryptoException("The file does not exist")
        }
        var bio: BIO = BIO.newFile(f, "rb")
        let t: UInt64 = unsafe { PEM_read_bio_RSAPublicKey(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }
        bio.free()
        if(t == 0) {
            throw CryptoException("Illegal RSA Public key.")
        }
        return RSAPublicKey(t)
    }  

    public static func readPkcs8PubKeyfromFile(f: String): RSAPublicKey {
        if(!exists(f)) {
            throw CryptoException("The file does not exist")
        }
        var bio: BIO = BIO.newFile(f, "rb")
        let t: UInt64 = unsafe { PEM_read_bio_RSA_PUBKEY(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }
        bio.free()
        if(t == 0) {
            throw CryptoException("Illegal RSA PKCS8 Public key.")
        }
        return RSAPublicKey(t)
    } 
    /*
     * Public key encryption
     *
     * @param inside - Data to be encrypted
     *       1. small data (inside.size < padding.getFlen(rsa.getSize())) Direct encryption
     *       2. Big data (inside.size > padding.getFlen(rsa.getSize())) Segmented encryption
     *          padding.getFlen(len) Maximum length of single encrypted data
     *             
     * @param padding - Fill mode,
     *      choose: RSA_PKCS1_PADDING/RSA_PKCS1_OAEP_PADDING/RSA_NO_PADDING
     * @param rsa - Public key
     * @return Array<UInt8> - Result after public key encryption
     */
    public static func publicKeyEncrypt(inside: Array<UInt8>, padding: PADDING, rsa: RSAPublicKey): Array<UInt8> {
        let p1: CString = unsafe { LibC.mallocCString(String.fromUtf8Unchecked(inside)) } 
        let flen: Int32 = padding.getFlen(rsa.getSize())
        let outside: Array<UInt8> = Array<UInt8>(Int64(rsa.getSize()), repeat: 0)
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
        let len = unsafe { RSA_public_encrypt(flen, p1, p2.pointer, rsa.getNum(), padding.getPadding()) }
        if(len <= 0) {
            unsafe {
                LibC.free(p1)
                releaseArrayRawData(p2)
            }
            throw CryptoException("RSA_public_encrypt error")
        } 
        var res: ArrayList<UInt8> = ArrayList<UInt8>(Int64(len))
        for(i in 0..Int64(len)) {
            let item = unsafe { p2.pointer.read(i) }
            res.add(item)
        }  
        unsafe {
            LibC.free(p1)
            releaseArrayRawData(p2)
        } 
        return res.toArray()
    }
    /*
     * Private key decryption
     *
     * @param inside - Data to be decrypted
     *       1. small data (inside.size < rsa.getSize()) Direct decryption
     *       2. big data (inside.size > rsa.getSize()) Segmented decryption
     *          len = rsa.getSize() Maximum length of single decrypted data
     *
     * @param padding - The filling mode needs to be consistent with the encrypted filling mode
     * @param rsa - Private key
     * @return Array<UInt8> - Result after decryption of private key
     */
    public static func privateKeyDecrypt(inside: Array<UInt8>, padding: PADDING, rsa: RSAPrivateKey): Array<UInt8> {
        if(inside.size == 0) {
            throw CryptoException("Please provide the data that needs to be decrypted")
        }
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
        let outside: Array<UInt8> = Array<UInt8>(Int64(rsa.getSize()), repeat: 0)
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
        let len = unsafe { RSA_private_decrypt(rsa.getSize(), p1.pointer, p2.pointer, rsa.getNum(), padding.getPadding()) }
        if(len <= 0) {
            unsafe {
                releaseArrayRawData(p1)
                releaseArrayRawData(p2)
            }
            throw CryptoException("RSA_private_decrypt error")
        }
        let decryptLen: Int64 = unsafe { CString(p2.pointer).size() }
        var res: ArrayList<UInt8> = ArrayList<UInt8>(decryptLen)
        for(i in 0..decryptLen) {
            let item = unsafe { p2.pointer.read(i) }
            res.add(item)
        }
        unsafe {
            releaseArrayRawData(p1)
            releaseArrayRawData(p2)
        }
        return res.toArray()
    }

    /*
     * private-key encryption
     *       1. small data (inside.size < padding.getFlen(rsa.getSize())) Direct encryption
     *       2. big data (inside.size > padding.getFlen(rsa.getSize())) Segmented encryption
     *          padding.getFlen(len) Maximum length of single encrypted data
     *
     * @param inside - Data to be encrypted
     * @param padding - Fill mode, optional RSA_PKCS1_PADDING/RSA_X931_PADDING/RSA_NO_PADDING
     * @param rsa - private-key
     * @return Array<UInt8> - Result after private key encryption
     */
    public static func privateKeyEncrypt(inside: Array<UInt8>, padding: PADDING, rsa: RSAPrivateKey): Array<UInt8> {
        let p1: CString = unsafe { LibC.mallocCString(String.fromUtf8Unchecked(inside)) } 
        let flen: Int32 = padding.getFlen(rsa.getSize())
        let outside: Array<UInt8> = Array<UInt8>(Int64(rsa.getSize()), repeat: 0)
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
        let len = unsafe { RSA_private_encrypt(flen, p1, p2.pointer, rsa.getNum(), padding.getPadding()) }
        if(len <= 0) {
            unsafe {
                LibC.free(p1)
                releaseArrayRawData(p2)
            }
            throw CryptoException("RSA_private_encrypt error")
        }
        var res: ArrayList<UInt8> = ArrayList<UInt8>(Int64(len))
        for(i in 0..Int64(len)) {
            let item = unsafe { p2.pointer.read(i) }
            res.add(item)
        }
        unsafe {
            LibC.free(p1)
            releaseArrayRawData(p2)
        }
        return res.toArray()
    }
    /*
     * Public key decryption
     *       1. small data (inside.size < rsa.getSize()) Direct decryption
     *       2. big data (inside.size > rsa.getSize()) Segmented decryption
     *          len = rsa.getSize() Maximum length of single decrypted data
     *
     * @param inside - Data to be decrypted
     * @param padding - The filling mode needs to be consistent with the encrypted filling mode
     * @param rsa - Public Key
     * @return Array<UInt8> - Result after public key decryption
     */
    public static func publicKeyDecrypt(inside: Array<UInt8>, padding: PADDING, rsa: RSAPublicKey): Array<UInt8> {
        if(inside.size == 0) {
            throw CryptoException("Please provide the data that needs to be decrypted")
        }
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(inside) }
        let outside: Array<UInt8> = Array<UInt8>(Int64(rsa.getSize()), repeat: 0)
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outside) }
        let len = unsafe { RSA_public_decrypt(rsa.getSize(), p1.pointer, p2.pointer, rsa.getNum(), padding.getPadding()) }
        if(len <= 0) {
            unsafe {
                releaseArrayRawData(p1)
                releaseArrayRawData(p2)
            }
            throw CryptoException("RSA_public_decrypt error")
        }
        let decryptLen: Int64 = unsafe { CString(p2.pointer).size() }
        var res: ArrayList<UInt8> = ArrayList<UInt8>(decryptLen)
        for(i in 0..decryptLen) {
            let item = unsafe { p2.pointer.read(i) }
            res.add(item)
        }
        unsafe {
            releaseArrayRawData(p1)
            releaseArrayRawData(p2)
        }
        return res.toArray()
    }

    /*
     * Private Key Signature
     *
     * @param types - Signature type
     * @param data - Summary data to be signed
     * @param rsa - key
     * @return Array<UInt8> - Signed data
     */
    public static func sign(types: DigestType, data: Array<UInt8>, rsa: RSAPrivateKey): Array<UInt8> {
        Digest.loadLowApi(types)
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
        var sigret: Array<UInt8> = Array<UInt8>(Int64(rsa.getSize()), repeat: 0)
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(sigret) }
        var siglen: UInt32 = 0
        let p3 = CPointer<UInt32>(unsafe { malloc(4) })
        unsafe { p3.write(siglen)}
        let ret = unsafe { RSA_sign(types.getDigestTypeId(), p1.pointer, UInt32(data.size), p2.pointer, p3, rsa.getNum()) }
        if(ret != 1) {
            unsafe { 
                releaseArrayRawData(p1)
                releaseArrayRawData(p2)
            }
            throw CryptoException("rsa sign error")
        }
        var sigretlen = unsafe {p3.read()}
        var res: ArrayList<UInt8> = ArrayList<UInt8>(Int64(sigretlen))
        for(i in 0..Int64(sigretlen)) {
            let item = unsafe { p2.pointer.read(i) }
            res.add(item)
        }
        unsafe { 
            releaseArrayRawData(p1)
            releaseArrayRawData(p2)
        }
        return res.toArray()
    }
    /*
     * Public key verification
     *
     * @param types - Signature type
     * @param data - Summary data to be signed
     * @param sigRet - Signed data
     * @param rsa - Public Key
     * @return Unit - Signature successfully returned Unit 
     *              error: rsa verify error
     */
    public static func verify(types: DigestType, data: Array<UInt8>, sigRet: Array<UInt8>, rsa: RSAPublicKey): Unit {
        Digest.loadLowApi(types)
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(sigRet) }

        let ret = unsafe { RSA_verify(types.getDigestTypeId(), p1.pointer, UInt32(data.size), p2.pointer, UInt32(sigRet.size), rsa.getNum()) }
        if(ret != 1) {
            unsafe { 
                releaseArrayRawData(p1)
                releaseArrayRawData(p2) 
            }
            throw CryptoException("rsa verify error")
        }
        unsafe { 
            releaseArrayRawData(p1)
            releaseArrayRawData(p2) 
        }
    }
}

/*
 * RSAPrivateKey
 */
public class RSAPrivateKey {
    var prikey: RSA = RSA()

    init(privateKey: UInt64) {
        this.prikey = RSA(privateKey)
    }

    func getNum(): UInt64 {
        return this.prikey.getRsa()
    }
    /*
     * Get private key array
     *
     * @return Array<UInt8>
     */
    public func getPrivateKey(): Array<UInt8> {
        let pri: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var bio: BIO = BIO()
        let ret: Int32 = unsafe { i2d_RSAPrivateKey_bio(bio.getBio(), pri)}
        if(ret != 1) {
            bio.free()
            throw CryptoException("RSA private key acquisition failed.") 
        }
        let arr: Array<UInt8> = bio.read()
        bio.free()
        return arr
    }

    public func getPkcs8PrivateKey(): Array<UInt8> {
        let pri: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var bio: BIO = BIO()
        let pkey: UInt64 = unsafe { EVP_PKEY_new() }
        let ret1: Int32 = unsafe { EVP_PKEY_set1_RSA(pkey, pri) }
        if(ret1 != 1) {
            bio.free()
            throw CryptoException("RSA PKCS8 private key acquisition failed.") 
        }
        let ret: Int32 = unsafe { i2d_PKCS8PrivateKeyInfo_bio(bio.getBio(), pkey)}
        if(ret != 1) {
            bio.free()
            throw CryptoException("RSA PKCS8 private key acquisition failed.") 
        }
        let arr: Array<UInt8> = bio.read()
        bio.free()
        return arr
    }
    /*
     * Get public key array
     *
     * @return Array<UInt8>
     */
    public func getPublicKey(): Array<UInt8> {
        let pub: UInt64 = unsafe { RSAPublicKey_dup(this.prikey.getRsa()) }
        var bio: BIO = BIO()
        let ret: Int32 = unsafe { i2d_RSAPublicKey_bio(bio.getBio(), pub)}
        if(ret != 1) {
            bio.free()
            throw CryptoException("RSA public key acquisition failed.") 
        }
        let arr: Array<UInt8> = bio.read()
        bio.free()
        return arr
    }

    public func getPkcs8PublicKey(): Array<UInt8> {
        let pub: UInt64 = unsafe { RSAPublicKey_dup(this.prikey.getRsa()) }
        var bio: BIO = BIO()
        let ret: Int32 = unsafe { i2d_RSA_PUBKEY_bio(bio.getBio(), pub)}
        if(ret != 1) {
            bio.free()
            throw CryptoException("RSA PKCS8 public key acquisition failed.") 
        }
        let arr: Array<UInt8> = bio.read()
        bio.free()
        return arr
    }
    /*
     * Obtain param n
     *
     * @return Array<UInt8>
     */
    public func getN(): Array<UInt8> {
        let pk: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var n: CPointer<BIGNUM> = bnNew()
        n = unsafe { RSA_get0_n(pk) }
        let ret: Array<UInt8> = bnToArray(n)
        bnFree(n)
        return ret
    }
    /*
     * Obtain param e
     *
     * @return Array<UInt8>
     */
    public func getE(): Array<UInt8> {
        let pk: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var e: CPointer<BIGNUM> = bnNew()
        e = unsafe { RSA_get0_e(pk) }
        let ret: Array<UInt8> = bnToArray(e)
        bnFree(e)
        return ret
    }
    /*
     * Obtain param d
     *
     * @return Array<UInt8>
     */
    public func getD(): Array<UInt8> {
        let pk: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var d: CPointer<BIGNUM> = bnNew()
        d = unsafe { RSA_get0_d(pk) }
        let ret: Array<UInt8> = bnToArray(d)
        bnFree(d)
        return ret
    }
    /*
     * Obtain param p
     *
     * @return Array<UInt8>
     */
    public func getP(): Array<UInt8> {
        let pk: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var p: CPointer<BIGNUM> = bnNew()
        p = unsafe { RSA_get0_p(pk) }
        let ret: Array<UInt8> = bnToArray(p)
        bnFree(p)
        return ret
    }
    /*
     * Obtain param q
     *
     * @return Array<UInt8>
     */
    public func getQ(): Array<UInt8> {
        let pk: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var q: CPointer<BIGNUM> = bnNew()
        q = unsafe { RSA_get0_q(pk) }
        let ret: Array<UInt8> = bnToArray(q)
        bnFree(q)
        return ret
    }
    /*
     * Obtain param dmp
     *
     * @return Array<UInt8>
     */
    public func getDmp(): Array<UInt8> {
        let pk: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var dmp: CPointer<BIGNUM> = bnNew()
        dmp = unsafe { RSA_get0_dmp1(pk) }
        let ret: Array<UInt8> = bnToArray(dmp)
        bnFree(dmp)
        return ret
    }
    /*
     * Obtain param dmq
     *
     * @return Array<UInt8>
     */
    public func getDmq(): Array<UInt8> {
        let pk: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var dmq: CPointer<BIGNUM> = bnNew()
        dmq = unsafe { RSA_get0_dmq1(pk) }
        let ret: Array<UInt8> = bnToArray(dmq)
        bnFree(dmq)
        return ret
    }
    /*
     * Obtain param iqmp
     *
     * @return Array<UInt8>
     */
    public func getIqmp(): Array<UInt8> {
        let pk: UInt64 = unsafe { RSAPrivateKey_dup(this.prikey.getRsa()) }
        var iqmp: CPointer<BIGNUM> = bnNew()
        iqmp = unsafe { RSA_get0_iqmp(pk) }
        let ret: Array<UInt8> = bnToArray(iqmp)
        bnFree(iqmp)
        return ret
    }
    /*
     * Obtain private key length
     *
     * @return Int32
     */
    public func getSize(): Int32 {
        let ret: Int32 = unsafe { RSA_size(this.prikey.getRsa()) }
        if (ret <= 0) {
            free()
            throw CryptoException("Rsa size is invalid")
        }
        return ret
    }
    /*
     * Write private key to file
     *
     * @param f - File Path
     * @param enc - Encryption
     * @param password - File password
     * @return Unit
     */
    public func writePriKeyToFile(f: String, enc!: CIPHER = CIPHER(0), password!: String = ""): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        var ret: Int32 = 0
        if(password.size == 0) {
            ret = unsafe { PEM_write_bio_RSAPrivateKey(bio.getBio(), this.prikey.getRsa(), 0, CString(CPointer<UInt8>()), 0, CFunc<(CString, Int32, Int32, CString) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }
        } else {
            if(password.size < 4 ) {
                throw CryptoException("Password length must be at least 4")
            }
            let psd: CString = unsafe {LibC.mallocCString(password)} 
            DES.loadLowApi(enc)
            ret = unsafe { PEM_write_bio_RSAPrivateKey(bio.getBio(), this.prikey.getRsa(), enc.getCipher(), psd, Int32(password.size), CFunc<(CString, Int32, Int32, CString) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }    
            unsafe {
                LibC.free(psd)
            }
        }
        if(ret != 1) {
            bio.free()
            throw CryptoException("PEM_write_bio_RSAPrivateKey error")
        }  
        bio.free()
    }

    public func writePkcs8PriKeyToFile(f: String, enc!: CIPHER = CIPHER(0), password!: String = ""): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        var ret: Int32 = 0
        let pkey: UInt64 = unsafe { EVP_PKEY_new() }
        ret = unsafe { EVP_PKEY_set1_RSA(pkey, this.prikey.getRsa()) }
        if(ret == 0) {
            throw CryptoException("Illegal RSA private key.")
        }
        if(password.size == 0) {
            ret = unsafe { PEM_write_bio_PKCS8PrivateKey(bio.getBio(), pkey, 0, CString(CPointer<UInt8>()), 0, CFunc<(CString, Int32, Int32, CString) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }
        } else {
            if(password.size < 4 ) {
                throw CryptoException("Password length must be at least 4")
            }
            let psd: CString = unsafe {LibC.mallocCString(password)} 
            DES.loadLowApi(enc)
            ret = unsafe { PEM_write_bio_PKCS8PrivateKey(bio.getBio(), pkey, enc.getCipher(), psd, Int32(password.size), CFunc<(CString, Int32, Int32, CString) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }    
            unsafe {
                LibC.free(psd)
            }
        }
        if(ret != 1) {
            bio.free()
            throw CryptoException("PEM write PKCS8 RSA PrivateKey error")
        }  
        bio.free()
    }
    
    /*
     * Write public key to file
     *
     * @param f - File Path
     * @return Unit
     */
    public func writePubKeyToFile(f: String): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        let ret: Int32 = unsafe { PEM_write_bio_RSAPublicKey(bio.getBio(), this.prikey.getRsa()) }
        if(ret != 1) {
            bio.free()
            throw CryptoException("PEM_write_bio_RSAPublicKey error")
        }
        bio.free()
    }

    public func writePkcs8PubKeyToFile(f: String): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        let ret: Int32 = unsafe { PEM_write_bio_RSA_PUBKEY(bio.getBio(), this.prikey.getRsa()) }
        if(ret != 1) {
            bio.free()
            throw CryptoException("PEM write PKCS8 RSA PUBKEY error")
        }
        bio.free()
    }
    /*
     * Release private key
     *
     * @return Unit
     */
    public func free(): Unit {
        this.prikey.free()
    }
}

/*
 * RSAPublicKey
 */
public class RSAPublicKey {
    var pubkey: RSA = RSA()

    init(publicKey: UInt64) {
        this.pubkey = RSA(publicKey)
    }
    func getNum(): UInt64 {
        return this.pubkey.getRsa()
    }
    /*
     * Get public key array
     *
     * @return Array<UInt8>
     */
    public func getPublicKey(): Array<UInt8> {
        let pub: UInt64 = unsafe { RSAPublicKey_dup(this.pubkey.getRsa()) }
        var bio: BIO = BIO()
        let ret: Int32 = unsafe { i2d_RSAPublicKey_bio(bio.getBio(), pub)}
        if(ret != 1) {
            bio.free()
            throw CryptoException("RSA public key acquisition failed.") 
        }
        let arr: Array<UInt8> = bio.read()
        bio.free()
        return arr
    }

    public func getPkcs8PublicKey(): Array<UInt8> {
        let pub: UInt64 = unsafe { RSAPublicKey_dup(this.pubkey.getRsa()) }
        var bio: BIO = BIO()
        let ret: Int32 = unsafe { i2d_RSA_PUBKEY_bio(bio.getBio(), pub)}
        if(ret != 1) {
            bio.free()
            throw CryptoException("RSA PKCS8 public key acquisition failed.") 
        }
        let arr: Array<UInt8> = bio.read()
        bio.free()
        return arr
    }
    /*
     * Obtain param n
     *
     * @return Array<UInt8>
     */
    public func getN(): Array<UInt8> {
        let pub: UInt64 = unsafe { RSAPublicKey_dup(this.pubkey.getRsa()) }
        var n: CPointer<BIGNUM> = bnNew()
        n = unsafe { RSA_get0_n(pub) }
        let ret: Array<UInt8> = bnToArray(n)
        bnFree(n)
        return ret
    }
    /*
     * Obtain param e
     *
     * @return Array<UInt8>
     */
    public func getE(): Array<UInt8> {
        let pub: UInt64 = unsafe { RSAPublicKey_dup(this.pubkey.getRsa()) }
        var e: CPointer<BIGNUM> = bnNew()
        e = unsafe { RSA_get0_e(pub) }
        let ret: Array<UInt8> = bnToArray(e)
        bnFree(e)
        return ret
    }
    /*
     * Obtain public key length
     *
     * @return Int32
     */
    public func getSize(): Int32 {
        let ret: Int32 = unsafe { RSA_size(this.pubkey.getRsa()) }
        if (ret <= 0) {
            free()
            throw CryptoException("Rsa size is invalid")
        }
        return ret
    }
    /*
     * Write public key to file
     *
     * @param f - file path
     * @return Unit
     */
    public func writePubKeyToFile(f: String): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        let ret: Int32 = unsafe { PEM_write_bio_RSAPublicKey(bio.getBio(), this.pubkey.getRsa()) }
        if(ret != 1) {
            bio.free()
            throw CryptoException("PEM_write_bio_RSAPublicKey error")
        }
        bio.free()
    }

    public func writePkcs8PubKeyToFile(f: String): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        let ret: Int32 = unsafe { PEM_write_bio_RSA_PUBKEY(bio.getBio(), this.pubkey.getRsa()) }
        if(ret != 1) {
            bio.free()
            throw CryptoException("PEM write PKCS8 RSA PublicKey error")
        }
        bio.free()
    }
    /*
     * Release public key
     *
     * @return Unit
     */
    public func free(): Unit {
        this.pubkey.free()
    }

}