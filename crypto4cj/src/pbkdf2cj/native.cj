/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.pbkdf2cj

foreign {
    //pbkdf2
    func PKCS5_PBKDF2_HMAC(pass: CPointer<UInt8>, passlen: Int32,
                            salt: CPointer<UInt8>, saltlen: Int32, 
                            iter: Int32, digest: UInt64,
                            keylen: Int32, out: CPointer<UInt8>): Int32
    func PKCS5_PBKDF2_HMAC_SHA1(pass: CPointer<UInt8>, passlen: Int32,
                                salt: CPointer<UInt8>, saltlen: Int32, 
                                iter: Int32, keylen: Int32, out: CPointer<UInt8>): Int32
}