/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/***
 * @file
 * This file is dh.
 */
package crypto4cj.dhcj

import crypto4cj.utils.*
import crypto4cj.bignumcj.*
import crypto4cj.rsacj.*

let OPENSSL_DH_MAX_MODULUS_BITS: Int32 = 10000
let DH_MIN_MODULUS_BITS: Int32 = 512

/**
 * DH structure
 *
 * @since 0.34.3
 */
public class DH {
    var dh: UInt64

    /**
     * Structure Initialization
     */
    public init() {
        let dh =  unsafe { DH_new() }

        // dh = 0, malloc failed
        if (dh == 0) {
            throw CryptoException("error: dh malloc failed.")
        }
        this.dh = dh

    }

    /**
     * Structure Initialization
     *
     * @params d
     */
    init(d: UInt64) {
        this.dh = d
    }

    /**
     * Get DH value
     *
     * @return UInt64
     */
    func getDh(): UInt64 {
        return this.dh
    }

    ~init() {
        unsafe { DH_free(dh) }
    }
}

/**
 * Allocate memory to shared keys.
 *
 * @since 0.34.3
 */
public class SHAREMALLOC {
    let str: Array<UInt8>

    /*
     * Initialize SHAREMALLOC
     */
    public init(dh: DH) {
        let len: Int64 = Int64(dhSize(dh))
        this.str = Array<UInt8>(len, repeat: 0)
    }

    /*
     * Get SHAREMALLOC value
     *
     * @return UInt64
     */
    public func getShareMalloc(): Array<UInt8> {
        this.str
    }

}

/**
 * The key params generates a generator of secure prime numbers, usually 2 or 5.
 *
 * @since 0.34.3
 */
public enum DHGENERATOR {
    | DH_GENERATOR_2
    | DH_GENERATOR_3
    | DH_GENERATOR_5

    /**
     * Get the value of the generator
     *
     * @return Int32
     */
    public func getNum(): Int32 {
        match(this) {
            case DH_GENERATOR_2 => 2
            case DH_GENERATOR_3 => 3
            case DH_GENERATOR_5 => 5
        }
    }
}
var isSetKey: Bool = false

/**
 * Generate DH data structure
 *
 * @return DH
 */
public func dhNew(): DH {
    return DH()
}

/**
 * Gets the number of bytes of DH key length.
 *
 * @params dh
 *
 * @return Int32 - Number of bytes
 */
public func dhSize(dh: DH): Int32 {
    let size = unsafe { DH_size(dh.getDh()) }
    if (size <= 0) {
        throw CryptoException("error: dh size is invalid.")
    }

    return size
}

/**
 * Generate DH key params.
 *
 * @params dh
 * @params prime_len - Length of generated safe prime
 * @params generator - generator
 *
 * @return Unit
 */
public func dhGenerateParameters(dh: DH, prime_len: Int32, generator: DHGENERATOR): Unit {
    isSetKey = true
    if(prime_len < DH_MIN_MODULUS_BITS || prime_len > OPENSSL_DH_MAX_MODULUS_BITS) {
        throw CryptoException("The prime_len Len is between 512 and 10000.")
    }
    let ret = unsafe { DH_generate_parameters_ex(dh.getDh(), prime_len, generator.getNum(), 0) }
    if(ret != 1) {
        throw CryptoException("Key parameter generation failed.")
    }
}

/**
 * Check the DH key.
 *
 * @params dh
 *
 * @return Unit
 */
public func dhCheck(dh: DH): Unit {
    let codes: CPointer<Int32> = CPointer<Int32>(LibC.malloc(count: 4))
    unsafe { codes.write(0) } 
    let ret = unsafe { DH_check(dh.getDh(), codes)}
    if(ret != 1) {
        throw CryptoException("Key check failed.")
    }
}

/**
 * Generate DH public and private keys.
 *
 * @params dh
 *
 * @return Unit
 */
public func dhGenerateKey(dh: DH): Unit {
    let ret = unsafe { DH_generate_key(dh.getDh()) }
    if(ret != 1) {
        throw CryptoException("The p is too short or too long.")
    }
}

/**
 * Check the public key.
 *
 * @params dh
 * @params pub_key
 *
 * @return Unit
 */
public func dhCheckPubKey(dh: DH, pub_key: CPointer<BIGNUM>): Unit {
    if(pub_key.isNull()) {
        throw CryptoException("Pub key too small.")
    }
    let codes: CPointer<Int32> = CPointer<Int32>(LibC.malloc(count: 4))
    unsafe { codes.write(0) } 
    let ret = unsafe { DH_check_pub_key(dh.getDh(), pub_key, codes) }
    if(ret != 1) {
        throw CryptoException("Pub key too small or large.")
    }
}

/**
 * Calculate the shared key for data exchange.
 * The padding style is RFC 5246 (8.1.2) that strips leading zero bytes. It is not constant time due to the leading zero bytes being stripped.
 *
 * @params key - Key, the key length should be dhSize (dh)
 * @params pub_key - Shared Public Key
 * @params dh
 *
 * @return Int32 - Generate shared key length,Can be used to test whether the shared key generation is successful
 * @return Array<UInt8> - Generate shared key, Can be used to test whether the shared key generation is successful
 */
public func dhComputeKey(key: SHAREMALLOC, pub_key: CPointer<BIGNUM>, dh: DH): (Int32, Array<UInt8>) {
    let computeKey: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(key.getShareMalloc()) }
    var ret = unsafe { DH_compute_key(computeKey.pointer, pub_key, dh.getDh()) }
    let len: Int64 = Int64(ret)
    if(len == -1) {
        unsafe {
            releaseArrayRawData(computeKey)
        }
        throw CryptoException("Failed to generate shared key")
    }
    var shareKey: Array<UInt8> = computeKey.array.slice(0, len)
    unsafe {
        releaseArrayRawData(computeKey)
    }
    return (ret, shareKey)
}

/**
 * Calculate the shared key for data exchange.
 * The padding style is NIST SP 800-56A (C.1) that retains leading zero bytes. It is constant time due to the leading zero bytes being retained.
 *
 * @params key - Key, the key length should be dhSize (dh)
 * @params pub_key - Shared Public Key
 * @params dh
 *
 * @return Int32 - dhSize(dh)
 * @return Array<UInt8> - Generate shared key, Can be used to test whether the shared key generation is successful
 */
public func dhComputePaddeKey(key: SHAREMALLOC, pub_key: CPointer<BIGNUM>, dh: DH): (Int32, Array<UInt8>) {
    let computePaddeKey: CPointerHandle<UInt8> = unsafe { acquireArrayRawData(key.getShareMalloc()) }
    var ret = unsafe { DH_compute_key_padded(computePaddeKey.pointer, pub_key, dh.getDh()) }
    let len: Int64 = Int64(ret)
    if(len == -1) {
        unsafe {
            releaseArrayRawData(computePaddeKey)
        }
        throw CryptoException("Failed to generate shared key")
    }
    var shareKey: Array<UInt8> = computePaddeKey.array.slice(0, len)
    unsafe {
        releaseArrayRawData(computePaddeKey)
    }
    return (ret, shareKey)
}

/**
 * Print DH key params.
 *
 * @params dh
 *
 * @return Unit
 */
public func dhParamsPrint(x: DH): Array<UInt8> {
    let bio: BIO = BIO()
    let ret = unsafe { DHparams_print(bio.getBio(), x.getDh()) }
    if(ret != 1) {
        throw CryptoException("DH Params print error")
    }
    return bio.read()
}

/**
 * Get the DH key params prime number.
 *
 * @params dh
 *
 * @return CPointer<BIGNUM>
 */
public func dhGetP(dh: DH): CPointer<BIGNUM> {
    let p = unsafe { DH_get0_p(dh.getDh())}
    return p
}

/**
 * Get the DH key params prime number.
 *
 * @params dh
 *
 * @return CPointer<BIGNUM>
 */
public func dhGetQ(dh: DH): CPointer<BIGNUM> {
    let q = unsafe { DH_get0_q(dh.getDh())}
    return q
}

/**
 * Get the DH key params generator.
 *
 * @params dh
 *
 * @return CPointer<BIGNUM>
 */
public func dhGetG(dh: DH): CPointer<BIGNUM> {
    let g = unsafe { DH_get0_g(dh.getDh())}
    return g
}

/**
 * Get DH private key.
 *
 * @params dh
 *
 * @return CPointer<BIGNUM>
 */
public func dhGetPrivKey(dh: DH): CPointer<BIGNUM> {
    let key = unsafe { DH_get0_priv_key(dh.getDh())}
    return key
}

/**
 * Get DH public key.
 *
 * @params dh
 *
 * @return CPointer<BIGNUM>
 */
public func dhGetPubKey(dh: DH): CPointer<BIGNUM> {
    let key = unsafe { DH_get0_pub_key(dh.getDh())}
    return key
}

/**
 * Set DH key params.
 *
 * @params dh
 * @params p - Key params prime
 * @params q - Key params prime
 * @params g - Key params generator
 *
 * @return CPointer<BIGNUM>
 */
public func dnSetPQG(dh: DH, p: CPointer<BIGNUM>, q: CPointer<BIGNUM>, g: CPointer<BIGNUM>): Unit {
    let ret = unsafe { DH_set0_pqg(dh.getDh(), p, q, g) }
    if(ret != 1) {
        throw CryptoException("Key parameter setting failed.")
    }
}

/**
 * Set DH public and private keys.
 *
 * @params dh
 * @params pubKey - Public key
 * @params privKey - Private key
 *
 * @return CPointer<BIGNUM>
 */
public func dhSetKey(dh: DH, pubKey: CPointer<BIGNUM>, privKey: CPointer<BIGNUM>): Unit {
    let ret = unsafe { DH_set0_key(dh.getDh(), pubKey, privKey) }
    if(ret != 1) {
        throw CryptoException("Failed to set public and private key parameters.")
    }
}

/**
 * Output the key params to the pem file.
 *
 * @params params_fn - File Path
 * @params x - dh
 *
 * @return CPointer<BIGNUM>
 */
public func pemWriteDHparams(params_fn: String, x: DH): Unit {
    if(!isSetKey) {
        throw CryptoException("Please set the dh key parameters first!")
    }
    if(params_fn.size == 0) {
        throw CryptoException("Please set the file path.")
    }
    let endStr: String = params_fn[(params_fn.size - 4)..]
    if(endStr != ".pem") {
        throw CryptoException("The end of the file name is .pem")
    }
    var bio: BIO = BIO.newFile(params_fn, "w")
    let ret = unsafe { PEM_write_bio_DHparams(bio.getBio(), x.getDh()) }
    bio.free()
    if(ret != 1) {
        throw CryptoException("Failed to generate file.")
    }
}

/**
 * Read the key params from the file.
 *
 * @params params_fn - File Path
 * @params x - dh
 *
 * @return DH
 */
public func pemReadDHparams(params_fn: String): DH {
    if(params_fn.size == 0) {
        throw CryptoException("Please set the file path.")
    }
    let endStr: String = params_fn[(params_fn.size - 4)..]
    if(endStr != ".pem") {
        throw CryptoException("The end of the file name is .pem")
    }
    var bio: BIO = BIO.newFile(params_fn, "rb")
    let ret =  unsafe { PEM_read_bio_DHparams(bio.getBio(), CPointer<UInt64>(), CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>(CPointer<Int32>()), CString(CPointer<UInt8>()))}
    if(ret == 0) {
        throw CryptoException("Invalid dh file")
    }
    bio.free()
    return DH(ret)
}