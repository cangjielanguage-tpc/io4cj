/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.digestcj

foreign func malloc(size: UIntNative): CPointer<Unit>
foreign func free(p: CPointer<UInt32>): Unit

foreign func EVP_MD_CTX_new(): UInt64
foreign func EVP_MD_CTX_free(ctx: UInt64): Unit

foreign func EVP_DigestInit(ctx: UInt64, `type`: UInt64): Int32
foreign func EVP_DigestUpdate(ctx: UInt64, 
                             d: CPointer<UInt8>,
                             cnt: Int32): Int32
foreign func EVP_DigestFinal(ctx: UInt64, 
                            md: CPointer<UInt8>,
                            s: CPointer<UInt32>): Int32
foreign func EVP_Digest(data: CPointer<UInt8>, 
                        count: Int32,
                        md: CPointer<UInt8>, 
                        size: CPointer<UInt32>,
                        `type`: UInt64, 
                        impl: UInt64): Int32  

// EVP_MD  
foreign func EVP_MD_CTX_md(ctx: UInt64): UInt64
foreign func EVP_md_null(): UInt64
//foreign func EVP_md2(): UInt64
foreign func EVP_md4(): UInt64
foreign func EVP_md5(): UInt64
foreign func EVP_md5_sha1(): UInt64
foreign func EVP_blake2b512(): UInt64
foreign func EVP_blake2s256(): UInt64
foreign func EVP_sha1(): UInt64
foreign func EVP_sha224(): UInt64
foreign func EVP_sha256(): UInt64
foreign func EVP_sha384(): UInt64
foreign func EVP_sha512(): UInt64
foreign func EVP_sha512_224(): UInt64
foreign func EVP_sha512_256(): UInt64
foreign func EVP_sha3_224(): UInt64
foreign func EVP_sha3_256(): UInt64
foreign func EVP_sha3_384(): UInt64
foreign func EVP_sha3_512(): UInt64
foreign func EVP_shake128(): UInt64
foreign func EVP_shake256(): UInt64
foreign func EVP_mdc2(): UInt64
foreign func EVP_ripemd160(): UInt64
foreign func EVP_whirlpool(): UInt64
foreign func EVP_sm3(): UInt64  

foreign func EVP_MD_block_size(md: UInt64): Int32

// Which version of the API is loade
foreign func EVP_MD_get_size(md: UInt64): Int32
foreign func EVP_MD_get_type(md: UInt64): Int32
foreign func EVP_MD_get0_name(md: UInt64): CString