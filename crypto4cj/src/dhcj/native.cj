/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */

package crypto4cj.dhcj
import std.collection.*
import crypto4cj.bignumcj.*

foreign func DH_new(): UInt64
foreign func DH_size(dh: UInt64): Int32
foreign func DH_free(dh: UInt64): Unit
foreign func DH_generate_parameters_ex(dh: UInt64, prime_len: Int32, generator: Int32, cb: UInt64): Int32
foreign func DH_check(dh: UInt64, codes: CPointer<Int32>): Int32
foreign func DH_generate_key(dh: UInt64): Int32
foreign func DH_check_pub_key(dh: UInt64, pub_key: CPointer<BIGNUM>, codes: CPointer<Int32>): Int32
foreign func DH_compute_key(key: CPointer<UInt8>, pub_key: CPointer<BIGNUM>, dh: UInt64): Int32
foreign func DH_compute_key_padded(key: CPointer<UInt8>, pub_key: CPointer<BIGNUM>, dh: UInt64): Int32
foreign func DHparams_print(bp: UInt64, x: UInt64): Int32
foreign func DH_get0_p(dh: UInt64): CPointer<BIGNUM>
foreign func DH_get0_q(dh: UInt64): CPointer<BIGNUM>
foreign func DH_get0_g(dh: UInt64): CPointer<BIGNUM>
foreign func DH_get0_priv_key(dh: UInt64): CPointer<BIGNUM>
foreign func DH_get0_pub_key(dh: UInt64): CPointer<BIGNUM>
foreign func DH_set0_pqg(dh: UInt64, p: CPointer<BIGNUM>, q: CPointer<BIGNUM>, g: CPointer<BIGNUM>): Int32
foreign func DH_set0_key(dh: UInt64, pub_key: CPointer<BIGNUM>, priv_key: CPointer<BIGNUM>): Int32
foreign func PEM_write_bio_DHparams(bp: UInt64, x: UInt64): Int32
foreign func PEM_read_bio_DHparams(bp: UInt64,
                                    x: CPointer<UInt64>,
                                    cb: CFunc<(CPointer<UInt8>, Int32, Int32, CPointer<Unit>) -> Int32>,
                                    u: CString): UInt64
