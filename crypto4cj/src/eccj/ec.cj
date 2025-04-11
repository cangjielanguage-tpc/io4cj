/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.eccj
import crypto4cj.utils.*
import crypto4cj.bignumcj.*
import crypto4cj.symmetrycj.*
import crypto4cj.rsacj.*
import crypto4cj.digestcj.*
import std.collection.*
import std.fs.*

let OPENSSL_EC_NAMED_CURVE: Int32 = 1

public class EC {

    public static func generateKey(curveId: CurvesId): ECPrivateKey {
        var ret: Int32 = 0
        let eckey: UInt64 = unsafe { EC_KEY_new_by_curve_name(curveId.getCurveId()) }

        ret = unsafe { EC_KEY_generate_key(eckey) }
        if(ret == 0) {
            throw CryptoException("EC generate key error")
        }

        ret = unsafe { EC_KEY_check_key(eckey) }
        if(ret == 0) {
            throw CryptoException("EC check key error")
        }

        return ECPrivateKey(eckey)
    }

    public static func setPrivateKeyDER(key: Array<UInt8>): ECPrivateKey {
        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(key) }
        let pp = CPointer<CPointer<UInt8>>(LibC.malloc(count: 1))
        unsafe { pp.write(p.pointer) }
        let ret: UInt64 = unsafe { d2i_ECPrivateKey(CPointer<CPointer<UInt64>>(), pp, key.size) }
        unsafe {
            LibC.free(pp)
            releaseArrayRawData(p) 
        }
        if(ret == 0) {
            throw CryptoException("Invalid private key DER")
        } 
        return ECPrivateKey(ret)
    }

    public static func setPublicKeyDER(curveId: CurvesId, key: Array<UInt8>): ECPublicKey {
        let eckey_pub: UInt64 = unsafe { EC_KEY_new_by_curve_name(curveId.getCurveId())}    
        let cp_pub1 = CPointer<UInt64>(LibC.malloc(count: 8))
        unsafe { 
            cp_pub1.write(eckey_pub) 
            EC_KEY_set_asn1_flag(eckey_pub, OPENSSL_EC_NAMED_CURVE)
        }

        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(key) }
        let pp = CPointer<CPointer<UInt8>>(LibC.malloc(count: 1))
        unsafe { pp.write(p.pointer) }
        let pubkey: UInt64 = unsafe { o2i_ECPublicKey(cp_pub1, pp, key.size) }
        unsafe {
            LibC.free(cp_pub1)
            LibC.free(pp)
            releaseArrayRawData(p) 
        }
        if(pubkey == 0) {
            throw CryptoException("Invalid public key DER")
        }
        return ECPublicKey(pubkey)
    }

    public static func readPriKeyfromFile(f: String, password!: String = ""): ECPrivateKey {
        if(!exists(f)) {
            throw CryptoException("The file does not exist")
        }
        var bio: BIO = BIO.newFile(f, "rb")
        var t: UInt64 = 0
        if(password.size == 0) {
            t = unsafe { PEM_read_bio_ECPrivateKey(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), CString(CPointer<UInt8>())) }      
        } else {
            let pass: CString = unsafe {LibC.mallocCString(password)} 
            t = unsafe { PEM_read_bio_ECPrivateKey(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), pass) }
             unsafe {
                LibC.free(pass)
            }
        } 
        if(t == 0) {
            bio.free()
            throw CryptoException("Illegal EC Private key DER.")
        }
        bio.free() 
        return ECPrivateKey(t)
    }

    public static func readPubKeyfromFile(f: String): ECPublicKey {
        if(!exists(f)) {
            throw CryptoException("The file does not exist")
        }
        var bio: BIO = BIO.newFile(f, "rb")
        let t: UInt64 = unsafe { PEM_read_bio_EC_PUBKEY(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }
        if(t == 0) {
            bio.free()
            throw CryptoException("Illegal EC public key DER.")
        }
        bio.free() 
        return ECPublicKey(t)
    } 

    public static func sign(data: Array<UInt8>, key: ECPrivateKey): Array<UInt8> {
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
        var sigret: Array<UInt8> = Array<UInt8>(Int64(key.getSize()), repeat: 0)
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(sigret) }
        var siglen: Int32 = 0
        let p3 = CPointer<Int32>(unsafe { LibC.malloc(count: 4) })
        unsafe { p3.write(siglen)}

        let ret = unsafe { ECDSA_sign(0, p1.pointer, Int32(data.size), p2.pointer, p3, key.getNum()) }
        if(ret != 1) {
            unsafe { 
                releaseArrayRawData(p1)
                releaseArrayRawData(p2)
                LibC.free(p3)
                key.free()
            }
            throw CryptoException("ECDSA sign error")
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
            LibC.free(p3)
        }
        return res.toArray()
    }

    public static func verify(data: Array<UInt8>, sigRet: Array<UInt8>, key: ECPublicKey): Unit {
        let p1: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
        let p2: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(sigRet) }

        let ret = unsafe { ECDSA_verify(0, p1.pointer, UInt32(data.size), p2.pointer, UInt32(sigRet.size), key.getNum()) }
        if(ret != 1) {
            unsafe {
                releaseArrayRawData(p1)
                releaseArrayRawData(p2) 
            }
            key.free()
            throw CryptoException("rsa verify error")
        }

        unsafe {
            releaseArrayRawData(p1)
            releaseArrayRawData(p2) 
        }
    }

    public static func encrypt(data: Array<UInt8>, key: ECPublicKey): Array<UInt8> {
        if(key.getCurveName().toString() != "NID_sm2") {
            throw CryptoException("The elliptical curve should be NID_sm2")
        }
        let evppkey: UInt64 = unsafe { EVP_PKEY_new() }
        var ret: Int32 = unsafe { EVP_PKEY_set1_EC_KEY(evppkey, key.getNum()) }
        if(ret != 1) {
            key.free()
            unsafe { EVP_PKEY_free(evppkey) }
            throw CryptoException("EVP_PKEY_set1_EC_KEY error")
        }
        let ctx: UInt64 = unsafe { EVP_PKEY_CTX_new(evppkey, 0)}
        ret = unsafe {EVP_PKEY_encrypt_init(ctx) }
        if(ret != 1) {
            unsafe { 
                EVP_PKEY_free(evppkey)
                EVP_PKEY_CTX_free(ctx)
            }
            key.free()
            throw CryptoException("EVP_PKEY_encrypt_init error")
        }
        let outp: CPointer<UInt8> = CPointer<UInt8>()
        var outlen: CPointer<Int32> = CPointer<Int32>(LibC.malloc(count: 4))
        unsafe { outlen.write(0) }
        let inbuf: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
        ret = unsafe { EVP_PKEY_encrypt(ctx, outp, outlen, inbuf.pointer, Int32(data.size))}
        if(ret != 1) {
            unsafe { 
                EVP_PKEY_free(evppkey)
                EVP_PKEY_CTX_free(ctx)
                LibC.free(outlen)
            }
            key.free()
            throw CryptoException("EVP_PKEY_encrypt error")
        }
        let outbufLen: Int32 = unsafe { outlen.read() }
        var outbuf: Array<UInt8> = Array<UInt8>(Int64(outbufLen), repeat: 0)
        let outbufP: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outbuf) }
        ret = unsafe { EVP_PKEY_encrypt(ctx, outbufP.pointer, outlen, inbuf.pointer, Int32(data.size))}
        unsafe { 
            EVP_PKEY_free(evppkey)
            EVP_PKEY_CTX_free(ctx)
            releaseArrayRawData(outbufP)
            LibC.free(outlen)
        }
        if(ret != 1) {
            key.free()
            throw CryptoException("EVP_PKEY_encrypt error")
        }
        return outbuf.slice(0, Int64(outbufLen))
    }
    
    public static func decrypt(data: Array<UInt8>, key: ECPrivateKey): Array<UInt8> {
        if(key.getCurveName().toString() != "NID_sm2") {
            throw CryptoException("The elliptical curve should be NID_sm2")
        }
        let evppkey: UInt64 = unsafe { EVP_PKEY_new() }
        var ret: Int32 = unsafe { EVP_PKEY_set1_EC_KEY(evppkey, key.getNum()) }
        if(ret != 1) {
            unsafe { EVP_PKEY_free(evppkey) }
            key.free()
            throw CryptoException("EVP_PKEY_set1_EC_KEY error")
        }

        let ctx: UInt64 = unsafe { EVP_PKEY_CTX_new(evppkey, 0)}
        ret = unsafe {EVP_PKEY_decrypt_init(ctx) }
        if(ret != 1) {
            unsafe { 
                EVP_PKEY_free(evppkey)
                EVP_PKEY_CTX_free(ctx)
            }
            key.free()
            throw CryptoException("EVP_PKEY_decrypt_init error")
        }
        let outp: CPointer<UInt8> = CPointer<UInt8>()
        var outlen: CPointer<Int32> = CPointer<Int32>(LibC.malloc(count: 1))
        unsafe { outlen.write(0) }
        let inbuf: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(data) }
        ret = unsafe { EVP_PKEY_decrypt(ctx, outp, outlen, inbuf.pointer, Int32(data.size))}
        if(ret != 1) {
            unsafe { 
                EVP_PKEY_free(evppkey)
                EVP_PKEY_CTX_free(ctx)
                LibC.free(outlen)
                releaseArrayRawData(inbuf)
            }
            key.free()
            throw CryptoException("EVP_PKEY_decrypt error")
        }
        let outbufLen: Int32 = unsafe { outlen.read() }
        var outbuf: Array<UInt8> = Array<UInt8>(Int64(outbufLen), repeat: 0)
        let outbufP: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(outbuf) }
        ret = unsafe { EVP_PKEY_decrypt(ctx, outbufP.pointer, outlen, inbuf.pointer, Int32(data.size))}
        unsafe { 
            EVP_PKEY_free(evppkey)
            EVP_PKEY_CTX_free(ctx)
            LibC.free(outlen)
            releaseArrayRawData(inbuf)
            releaseArrayRawData(outbufP)
        } 
        if(ret != 1) {
            key.free()
            throw CryptoException("EVP_PKEY_decrypt error")
        }
        return outbuf.slice(0, Int64(outbufLen))
    }

    public static func dhComputeKey(privateKey: ECPrivateKey, publicKey: ECPublicKey): Array<UInt8> {
        let len: Int32 = privateKey.getSize()
        let buf: Array<UInt8> = Array<UInt8>(Int64(len), repeat: 0)
        let bufp: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(buf)}
        let ret: Int32 = unsafe { ECDH_compute_key(bufp.pointer, len, publicKey.getPublicKeyPoint(), privateKey.getNum(), CFunc<(CPointer<Unit>, Int32, CPointer<Unit>, CPointer<Int32>) -> (CPointer<Unit>)>(CPointer<Unit>())) }
        unsafe { releaseArrayRawData(bufp) }
        return buf.slice(0, Int64(ret))
    }
}

public class ECPrivateKey {
    var eckey: UInt64 = 0
    
    init() {
        this.eckey = 0
    }
    init(k: UInt64) {
        this.eckey = k
    }

    func free(): Unit {
        unsafe { EC_KEY_free(this.eckey) }
    }

    func getNum(): UInt64 {
        return this.eckey
    }
    public func getSize(): Int32 {
        return unsafe {ECDSA_size(this.eckey) }
    }

    public func getPrivateKeyDER(): Array<UInt8> {
        var ret: Int32 = unsafe { i2d_ECPrivateKey(this.eckey, CPointer<CPointer<UInt8>>())}
        let out: Array<UInt8> = Array<UInt8>(Int64(ret), repeat: 0)
        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(out) }
        let pp = CPointer<CPointer<UInt8>>(LibC.malloc(count: 1))
        unsafe { pp.write(p.pointer) }
        ret = unsafe { i2d_ECPrivateKey(this.eckey, pp)}
        unsafe {
            releaseArrayRawData(p)
            LibC.free(pp)
        }
        if(ret == 0) {
            free()
            throw CryptoException("EC private key acquisition failed.") 
        }

        return out
    }
    
    public func getPublicKeyDER(): Array<UInt8> {
        var ret: Int32 = unsafe { i2o_ECPublicKey(this.eckey, CPointer<CPointer<UInt8>>())}
        let out: Array<UInt8> = Array<UInt8>(Int64(ret), repeat: 0)
        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(out) }
        let pp = CPointer<CPointer<UInt8>>(LibC.malloc(count: 1))
        unsafe { pp.write(p.pointer) }
        ret = unsafe { i2o_ECPublicKey(this.eckey, pp)}
        unsafe {
            releaseArrayRawData(p)
            LibC.free(pp)
        }
        if(ret == 0) {
            free()
            throw CryptoException("EC public key acquisition failed.") 
        } 
        return out
    }

    public func getPrivateKey(): Array<UInt8> {
        let keyPair: UInt64 = unsafe { EC_KEY_dup(this.eckey)}
        if(keyPair == 0) {
            free()
            throw CryptoException("EVP_PKEY_get0_EC_KEY error")
        }
        var n: CPointer<BIGNUM> = bnNew()
        n = unsafe { EC_KEY_get0_private_key(keyPair) }
        let ret: Array<UInt8> = bnToArray(n)
        bnFree(n)
        return ret
    }

    public func getPublicKey(): Array<UInt8> {
        let keyPair: UInt64 = unsafe { EC_KEY_dup(this.eckey)}
        if(keyPair == 0) {
            free()
            throw CryptoException("EVP_PKEY_get0_EC_KEY error")
        }
        let ecpoint: UInt64 = unsafe { EC_KEY_get0_public_key(this.eckey) }
        if(ecpoint == 0 ) {
            free()
            throw CryptoException("EC_KEY_get0_public_key error") 
        }

        let pointConversion: Int32 = unsafe { EC_KEY_get_conv_form(this.eckey) }
        let ecgroup: UInt64 = unsafe { EC_KEY_get0_group(this.eckey) }
        let buf: Array<UInt8> = Array<UInt8>(1024, repeat: 0)
        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(buf) }
        let ret: Int32 = unsafe { EC_POINT_point2oct(ecgroup, ecpoint, pointConversion, p.pointer, Int32(buf.size), 0)}
        unsafe { releaseArrayRawData(p) }
        return buf.slice(0, Int64(ret))
    }
     
    public func getCurveXYZ(): (Array<UInt8>, Array<UInt8>, Array<UInt8>) {
        let ecpoint: UInt64 = unsafe { EC_KEY_get0_public_key(this.eckey) }
        if(ecpoint == 0 ) {
            free()
           throw CryptoException("EC_KEY_get0_public_key error") 
        }

        let ecgroup: UInt64 = unsafe { EC_KEY_get0_group(this.eckey) }
        if(ecgroup == 0 ) {
            free()
            throw CryptoException("EC_KEY_get0_group error") 
        }

        let ctx: CPointer<BN_CTX> = bnCtxNew()
        let x: CPointer<BIGNUM> = bnNew()
        let y: CPointer<BIGNUM> = bnNew()
        let z: CPointer<BIGNUM> = bnNew()
        let ret: Int32 = unsafe { EC_POINT_get_Jprojective_coordinates_GFp(ecgroup, ecpoint, x, y, z, ctx) }
        if(ret != 1) {
            bnFree(x)
            bnFree(y)
            bnFree(z)
            bnCtxFree(ctx)
            throw CryptoException("EC_POINT_get_affine_coordinates error") 
        }
        return (bnToArray(x), bnToArray(y), bnToArray(z))
    }

    public func getCurvePAB(): (Array<UInt8>, Array<UInt8>, Array<UInt8>) {
        let ecgroup: UInt64 = unsafe { EC_KEY_get0_group(this.eckey) }
        if(ecgroup == 0 ) {
            free()
            throw CryptoException("EC_KEY_get0_group error") 
        }

        let ctx: CPointer<BN_CTX> = bnCtxNew()
        let p: CPointer<BIGNUM> = bnNew()
        let a: CPointer<BIGNUM> = bnNew()
        let b: CPointer<BIGNUM> = bnNew()
        let ret: Int32 = unsafe { EC_GROUP_get_curve_GFp(ecgroup, p, a, b, ctx) }
        if(ret != 1) {
            bnFree(p)
            bnFree(a)
            bnFree(b)
            bnCtxFree(ctx)
            throw CryptoException("EC_GROUP_get_curve_GFp error") 
        }
        return (bnToArray(p), bnToArray(a), bnToArray(b))
    }

    public func writePriKeyToFile(f: String, enc!: CIPHER = CIPHER(0), password!: String = ""): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        var ret: Int32 = 0
        if(password.size == 0) {
            ret = unsafe { PEM_write_bio_ECPrivateKey(bio.getBio(), this.eckey, 0, CString(CPointer<UInt8>()), 0, CFunc<(CString, Int32, Int32, CString) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }
        } else {
            if(password.size < 4 ) {
                throw CryptoException("Password length must be at least 4")
            }
            let psd: CString = unsafe {LibC.mallocCString(password)} 
            ret = unsafe { PEM_write_bio_ECPrivateKey(bio.getBio(), this.eckey, enc.getCipher(), psd, Int32(password.size), CFunc<(CString, Int32, Int32, CString) -> Int32>(CPointer<Int32>()), CPointer<Unit>()) }    
            unsafe {LibC.free(psd)}
        }
        bio.free()
        if(ret != 1) {
            unsafe { EC_KEY_free(this.eckey)}
            throw CryptoException("PEM_write_bio_PrivateKey error")
        }  
        
    }

    public func writePubKeyToFile(f: String): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        let ret: Int32 = unsafe { PEM_write_bio_EC_PUBKEY(bio.getBio(), this.eckey) }
        bio.free()
        if(ret != 1) {
            unsafe {EC_KEY_free(this.eckey)}
            throw CryptoException("PEM_write_bio_PUBKEY error")
        }    
    }

    public func getCurveName(): CurvesId {
        let group: UInt64 = unsafe { EC_KEY_get0_group(this.eckey) }
        let nid: Int32 = unsafe { EC_GROUP_get_curve_name(group) }
        return getCurveName(nid)
    }

}


public class ECPublicKey {
    var pubkey: UInt64 = 0

    init(publicKey: UInt64) {
        this.pubkey = publicKey
    }

    func getNum(): UInt64 {
        return this.pubkey
    }

    func free(): Unit {
        unsafe { EC_KEY_free(this.pubkey) }
    }

    public func getSize(): Int32 {
        return unsafe {ECDSA_size(this.pubkey) }
    }

    public func writePubKeyToFile(f: String): Unit {
        var bio: BIO = BIO.newFile(f, "w")
        let ret: Int32 = unsafe { PEM_write_bio_EC_PUBKEY(bio.getBio(), this.pubkey) }
        bio.free()
        if(ret != 1) {
            unsafe {EC_KEY_free(this.pubkey)}
            throw CryptoException("PEM_write_bio_PUBKEY error")
        }     
    }

    public func getPublicKeyDER(): Array<UInt8> {
        var ret: Int32 = unsafe { i2o_ECPublicKey(this.pubkey, CPointer<CPointer<UInt8>>())}
        let out: Array<UInt8> = Array<UInt8>(Int64(ret), repeat: 0)
        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(out) }
        let pp = CPointer<CPointer<UInt8>>(LibC.malloc(count: 1))
        unsafe { pp.write(p.pointer) }
        ret = unsafe { i2o_ECPublicKey(this.pubkey, pp)}
        unsafe {
            releaseArrayRawData(p)
            LibC.free(pp)
        }
        if(ret == 0) {
            free()
            throw CryptoException("EC public key acquisition failed.") 
        }  
        return out
    }

    public func getCurveXYZ(): (Array<UInt8>, Array<UInt8>, Array<UInt8>) {
        let ecpoint: UInt64 = unsafe { EC_KEY_get0_public_key(this.pubkey) }
        if(ecpoint == 0 ) {
            free()
            throw CryptoException("EC_KEY_get0_public_key error") 
        }

        let ecgroup: UInt64 = unsafe { EC_KEY_get0_group(this.pubkey) }
        if(ecgroup == 0 ) {
            free()
            throw CryptoException("EC_KEY_get0_group error") 
        }

        let ctx: CPointer<BN_CTX> = bnCtxNew()
        let x: CPointer<BIGNUM> = bnNew()
        let y: CPointer<BIGNUM> = bnNew()
        let z: CPointer<BIGNUM> = bnNew()
        let ret: Int32 = unsafe { EC_POINT_get_Jprojective_coordinates_GFp(ecgroup, ecpoint, x, y, z, ctx) }
        if(ret != 1) {
            bnFree(x)
            bnFree(y)
            bnFree(z)
            bnCtxFree(ctx)
            throw CryptoException("EC_POINT_get_affine_coordinates error") 
        }
        return (bnToArray(x), bnToArray(y), bnToArray(z))
    }

    public func getPublicKey(): Array<UInt8> {
        let keyPair: UInt64 = unsafe { EC_KEY_dup(this.pubkey)}
        if(keyPair == 0) {
            free()
            throw CryptoException("EVP_PKEY_get0_EC_KEY error")
        }
        let ecpoint: UInt64 = unsafe { EC_KEY_get0_public_key(this.pubkey) }
        if(ecpoint == 0 ) {
            free()
            throw CryptoException("EC_KEY_get0_public_key error") 
        }
        let pointConversion: Int32 = unsafe { EC_KEY_get_conv_form(this.pubkey) }
        let ecgroup: UInt64 = unsafe { EC_KEY_get0_group(this.pubkey) }
        let buf: Array<UInt8> = Array<UInt8>(1024, repeat: 0)
        let p: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(buf) }
        let ret: Int32 = unsafe { EC_POINT_point2oct(ecgroup, ecpoint, pointConversion, p.pointer, Int32(buf.size), 0)}
        unsafe { releaseArrayRawData(p) }
        return buf.slice(0, Int64(ret))
    }

    func getPublicKeyPoint(): UInt64 {
        return unsafe { EC_KEY_get0_public_key(this.pubkey) }
    }

    public func getCurveName(): CurvesId {
        let group: UInt64 = unsafe { EC_KEY_get0_group(this.pubkey) }
        let nid: Int32 = unsafe { EC_GROUP_get_curve_name(group) }
        return getCurveName(nid)
    }
}
