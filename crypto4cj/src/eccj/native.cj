/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */

package crypto4cj.eccj
import crypto4cj.bignumcj.*

foreign func EC_POINT_get_Jprojective_coordinates_GFp(group: UInt64, p: UInt64, x: CPointer<BIGNUM>, y: CPointer<BIGNUM>, z: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32
foreign func EC_GROUP_get_curve_GFp(group: UInt64, p: CPointer<BIGNUM>, a: CPointer<BIGNUM>, b: CPointer<BIGNUM>, ctx: CPointer<BN_CTX>): Int32
foreign func ECDSA_size(eckey: UInt64): Int32
foreign func EVP_PKEY_new(): UInt64
foreign func EVP_PKEY_free(pkey: UInt64): Unit
foreign func EVP_PKEY_set1_EC_KEY(pkey: UInt64, key: UInt64): Int32
foreign func EVP_PKEY_CTX_new(pkey: UInt64, e: UInt64): UInt64
foreign func EVP_PKEY_CTX_free(ctx: UInt64): Unit
foreign func EVP_PKEY_encrypt_init(ctx: UInt64): Int32
foreign func EVP_PKEY_encrypt(ctx: UInt64,
                              out: CPointer<UInt8>, 
                              outlen: CPointer<Int32>,
                              `in`: CPointer<UInt8>, 
                              inlen: Int32): Int32
foreign func EVP_PKEY_decrypt_init(ctx: UInt64): Int32
foreign func EVP_PKEY_decrypt(ctx: UInt64,
                              out: CPointer<UInt8>, 
                              outlen: CPointer<Int32>,
                              `in`: CPointer<UInt8>, 
                              inlen: Int32): Int32

foreign func PEM_write_bio_ECPrivateKey(out: UInt64, 
                                      x: UInt64, 
                                      enc: UInt64,
                                      kstr: CString, 
                                      klen: Int32,
                                      cb: CFunc<(CString, Int32, Int32, CString) -> Int32>,
                                      u: CPointer<Unit>): Int32
foreign func PEM_write_bio_EC_PUBKEY(out: UInt64, x: UInt64) :Int32
foreign func EC_GROUP_new_by_curve_name(nid: Int32): UInt64
foreign func EC_KEY_set_group(key: UInt64, group: UInt64): Int32
foreign func EC_KEY_generate_key(key: UInt64): Int32
foreign func EC_KEY_check_key(key: UInt64): Int32
foreign func EC_KEY_dup(src: UInt64): UInt64
foreign func EC_KEY_get0_private_key(key: UInt64): CPointer<BIGNUM>
foreign func EC_KEY_get0_public_key(key: UInt64): UInt64
foreign func EC_KEY_new(): UInt64

foreign func i2d_ECPrivateKey(key: UInt64, out: CPointer<CPointer<UInt8>>): Int32
foreign func i2o_ECPublicKey(key: UInt64, out: CPointer<CPointer<UInt8>>): Int32
foreign func i2d_ECParameters(key: UInt64, out: CPointer<CPointer<UInt8>>): Int32
foreign func d2i_ECPrivateKey(key: CPointer<CPointer<UInt64>>, `in`: CPointer<CPointer<UInt8>>, len: Int64): UInt64
foreign func d2i_ECParameters(key: CPointer<CPointer<UInt64>>, `in`: CPointer<CPointer<UInt8>>, len: Int64): UInt64
foreign func o2i_ECPublicKey(key: CPointer<UInt64>, `in`: CPointer<CPointer<UInt8>>, len: Int64): UInt64
foreign func EC_KEY_set_asn1_flag(eckey: UInt64, asn1_flag: Int32): Unit
foreign func EC_KEY_new_by_curve_name(nid: Int32): UInt64
foreign func PEM_read_bio_ECPrivateKey(out: UInt64,
                                        x: CPointer<UInt64>,
                                        cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                        u: CString): UInt64
foreign func PEM_read_bio_EC_PUBKEY(bp: UInt64,
                                    x: CPointer<UInt64>,
                                    cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                    u: CPointer<Unit>): UInt64
foreign func EC_KEY_free(key: UInt64): Unit
foreign func ECDSA_sign(`type`: Int32, 
                        dgst: CPointer<UInt8>,
                        dgstlen: Int32, 
                        sig: CPointer<UInt8>,
                        siglen: CPointer<Int32>, 
                        eckey: UInt64): Int32  
foreign func ECDSA_verify(`type`: Int32, 
                        dgst: CPointer<UInt8>, 
                        dgstlen: UInt32,
                        sig: CPointer<UInt8>, 
                        siglen: UInt32, 
                        eckey: UInt64): Int32
foreign func EC_KEY_get0_group(key: UInt64): UInt64
foreign func EC_GROUP_get_curve_name(group: UInt64): Int32
foreign func EC_POINT_point2oct(group: UInt64,
                                p: UInt64,
                                `from`: Int32,
                                buf: CPointer<UInt8>,
                                len: Int32,
                                ctx: UInt64): Int32
foreign func EC_KEY_get_conv_form(key: UInt64): Int32
foreign func EVP_PKEY_get0_type_name(key: UInt64): CString
foreign func EVP_PKEY_set_type(pkey: UInt64, `type`: Int32): Int32
foreign func ECDH_compute_key(out: CPointer<UInt8>,
                              outlen: Int32,
                              pub_key: UInt64,
                              ecdh: UInt64,
                              KDF: CFunc<(CPointer<Unit>, Int32, CPointer<Unit>, CPointer<Int32>) -> (CPointer<Unit>)>): Int32
