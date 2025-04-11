/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */
package crypto4cj.rsacj
import crypto4cj.bignumcj.*

foreign func malloc(size: UIntNative): CPointer<Unit>
foreign func free(p: CPointer<UInt64>): Unit

foreign func BN_bn2bin(a: CPointer<BIGNUM>, to: CString): Int32
foreign func BN_bin2bn(s: CString, len: Int32, ret: CPointer<BIGNUM>): CPointer<BIGNUM> 


foreign func RSA_new(): UInt64
foreign func RSA_free(rsa: UInt64): Unit
foreign func RSA_size(rsa: UInt64): Int32
foreign func RSA_generate_key(bits: Int32, e: UInt64, callback: CFunc<(Int32, Int32, CPointer<Unit>) -> CPointer<Unit>>, cb_arg: CPointer<Unit> ): UInt64
foreign func RSA_check_key(key: UInt64): Int32
                      
foreign func RSA_get0_n(d: UInt64): CPointer<BIGNUM>
foreign func RSA_get0_e(d: UInt64): CPointer<BIGNUM>
foreign func RSA_get0_d(d: UInt64): CPointer<BIGNUM>
foreign func RSA_get0_p(d: UInt64): CPointer<BIGNUM>
foreign func RSA_get0_q(d: UInt64): CPointer<BIGNUM>
foreign func RSA_get0_dmp1(r: UInt64): CPointer<BIGNUM>
foreign func RSA_get0_dmq1(r: UInt64): CPointer<BIGNUM>
foreign func RSA_get0_iqmp(r: UInt64): CPointer<BIGNUM>
foreign func RSAPrivateKey_dup(rsa: UInt64): UInt64
foreign func i2d_RSAPrivateKey_bio(bp: UInt64, rsa: UInt64): Int32
foreign func RSAPublicKey_dup(rsa: UInt64): UInt64
foreign func i2d_RSAPublicKey_bio(bp: UInt64, rsa: UInt64): Int32

foreign func PEM_write_bio_RSAPublicKey(bp: UInt64, x: UInt64): Int32
foreign func PEM_write_bio_RSAPrivateKey(bp: UInt64, 
                                        x: UInt64, 
                                        enc: UInt64,
                                        kstr: CString, 
                                        klen: Int32,
                                        cb: CFunc<(CString, Int32, Int32, CString) -> Int32>,
                                        u: CPointer<Unit>): Int32
foreign func PEM_read_bio_RSAPrivateKey(bp: UInt64,
                                        x: CPointer<UInt64>,
                                        cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                        u: CString): UInt64

foreign func PEM_read_bio_RSAPublicKey(bp: UInt64,
                                        x: CPointer<UInt64>,
                                        cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                        u: CPointer<Unit>): UInt64

foreign func d2i_RSAPrivateKey_bio(bp: UInt64, rsa: CPointer<UInt64>): UInt64
foreign func d2i_RSAPublicKey_bio(bp: UInt64, rsa: CPointer<UInt64>): UInt64
foreign func RSA_set0_key(r: UInt64, n: CPointer<BIGNUM>, e: CPointer<BIGNUM>, d: CPointer<BIGNUM>): Int32
foreign func RSA_set0_factors(r: UInt64, p: CPointer<BIGNUM>, q: CPointer<BIGNUM>): Int32
foreign func RSA_set0_crt_params(r: UInt64, dmp1: CPointer<BIGNUM>, dmq1: CPointer<BIGNUM>, iqmp: CPointer<BIGNUM>): Int32

foreign func RSA_public_encrypt(flen: Int32, 
                                `from`: CString,
                                to: CPointer<UInt8>, 
                                rsa: UInt64, 
                                padding: Int32): Int32

foreign func RSA_private_decrypt(flen: Int32, 
                                `from`: CPointer<UInt8>,
                                to: CPointer<UInt8>, 
                                rsa: UInt64, 
                                padding: Int32): Int32

foreign func RSA_private_encrypt(flen: Int32, 
                                `from`: CString,
                                to: CPointer<UInt8>, 
                                rsa: UInt64, 
                                padding: Int32): Int32

foreign func RSA_public_decrypt(flen: Int32, 
                                `from`: CPointer<UInt8>,
                                to: CPointer<UInt8>, 
                                rsa: UInt64, 
                                padding: Int32): Int32

foreign func RSA_sign(`type`: Int32, 
                      m: CPointer<UInt8>, 
                      m_length: UInt32,
                      sigret: CPointer<UInt8>, 
                      siglen: CPointer<UInt32>, 
                      rsa: UInt64): Int32

foreign func RSA_verify(`type`: Int32, 
                        m: CPointer<UInt8>, 
                        m_length: UInt32,
                        sigbuf: CPointer<UInt8>, 
                        siglen: UInt32, 
                        rsa: UInt64): Int32

foreign func i2d_PKCS8PrivateKeyInfo_bio(bp: UInt64, pkey: UInt64): Int32
foreign func EVP_PKEY_set1_RSA(pkey: UInt64, key: UInt64): Int32
foreign func EVP_PKEY_new(): UInt64
foreign func i2d_RSA_PUBKEY_bio(bp: UInt64, rsa: UInt64): Int32
foreign func PEM_write_bio_RSA_PUBKEY(bp: UInt64, x: UInt64): Int32
foreign func PEM_write_bio_PKCS8PrivateKey(bp: UInt64, 
                                        x: UInt64, 
                                        enc: UInt64,
                                        kstr: CString, 
                                        klen: Int32,
                                        cb: CFunc<(CString, Int32, Int32, CString) -> Int32>,
                                        u: CPointer<Unit>): Int32
foreign func PEM_read_bio_PrivateKey(bp: UInt64,
                                        x: CPointer<UInt64>,
                                        cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                        u: CString): UInt64
foreign func PEM_read_bio_RSA_PUBKEY(bp: UInt64,
                                        x: CPointer<UInt64>,
                                        cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                        u: CPointer<Unit>): UInt64
foreign func d2i_PrivateKey_bio(bp: UInt64, a: CPointer<UInt64>): UInt64
foreign func EVP_PKEY_get0_RSA(pkey: UInt64): UInt64
foreign func d2i_RSA_PUBKEY_bio(bp: UInt64, rsa: CPointer<UInt64>): UInt64