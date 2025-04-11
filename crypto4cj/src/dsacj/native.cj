/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */

package crypto4cj.dsacj

foreign func DSA_new(): UInt64

foreign func DSA_free(r: UInt64): Unit

foreign func DSA_generate_parameters_ex(dsa: UInt64, bits: Int32, seed: CPointer<UInt8>, seed_len: Int32, counter_ret: CPointer<Int32>, h_ret: CPointer<UInt64>, cb: UInt64): Int32

foreign func DSA_generate_key(dsa: UInt64): Int32

foreign func DSA_sign(`type`: Int32, dgst: CPointer<UInt8>, dlen: Int32, sig: CString, siglen: CPointer<UInt32>, dsa: UInt64): Int32

foreign func DSA_verify(`type`: Int32, dgst: CPointer<UInt8>, dgst_len: Int32, sigbuf: CString, siglen: Int32, dsa: UInt64): Int32

foreign func DSA_do_sign(dgst: CPointer<UInt8>, dlen: Int32, dsa: UInt64): UInt64

foreign func DSA_size(dsa: UInt64): Int32

foreign func DSA_print(bp: UInt64, x: UInt64, off: Int32): Int32

foreign func DSA_do_verify(dgst: CPointer<UInt8>, dgst_len: Int32, sig: UInt64, dsa: UInt64): Int32

foreign func PEM_write_bio_DSA_PUBKEY(bp: UInt64, x: UInt64): Int32

foreign func PEM_write_bio_DSAPrivateKey(bp: UInt64, 
                                        x: UInt64, 
                                        enc: UInt64,
                                        kstr: CString, 
                                        klen: Int32,
                                        cb: CFunc<(CString, Int32, Int32, CString) -> Int32>,
                                        u: CPointer<Unit>): Int32

foreign func PEM_write_bio_DSAparams(bp: UInt64, x: UInt64): Int32

foreign func PEM_read_bio_DSAPrivateKey(bp: UInt64,
                                        x: CPointer<UInt64>,
                                        cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                        u: CString): UInt64

foreign func PEM_read_bio_DSA_PUBKEY(bp: UInt64,
                                     x: CPointer<UInt64>,
                                     cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                     u: CPointer<Unit>): UInt64
