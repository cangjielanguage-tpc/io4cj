/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.symmetrycj

foreign func malloc(size: UIntNative): CPointer<Unit>
foreign func free(p: CPointer<Int32>): Unit

foreign func EVP_enc_null(): UInt64 // cipher
foreign func EVP_CIPHER_CTX_new(): UInt64
foreign func EVP_CIPHER_CTX_free(c: UInt64): Unit
foreign func EVP_CIPHER_CTX_set_padding(c: UInt64, pad: Int32): Int32
foreign func EVP_EncryptInit(ctx: UInt64, 
                            cipher: UInt64,
                            key: CPointer<UInt8>, 
                            iv: CPointer<UInt8>): Int32

foreign func EVP_EncryptUpdate(ctx: UInt64,  
                              out: CPointer<UInt8>,
                              outl: CPointer<Int32>, 
                              `in`: CPointer<UInt8>, 
                              inl:Int32): Int32

foreign func EVP_EncryptFinal(ctx: UInt64,
                              out: CPointer<UInt8>,
                              outl: CPointer<Int32>): Int32

foreign func EVP_DecryptInit(ctx: UInt64, 
                            cipher: UInt64,
                            key: CPointer<UInt8>, 
                            iv: CPointer<UInt8>): Int32

foreign func EVP_DecryptUpdate(ctx: UInt64, 
                               out: CPointer<UInt8>,
                               outl: CPointer<Int32>, 
                               `in`: CPointer<UInt8>, 
                               inl: Int32): Int32

foreign func EVP_DecryptFinal(ctx: UInt64, 
                              outm: CPointer<UInt8>,
                              outl: CPointer<Int32>): Int32

// des
foreign func EVP_des_ecb(): UInt64
foreign func EVP_des_ede(): UInt64
foreign func EVP_des_ede3(): UInt64
foreign func EVP_des_ede_ecb(): UInt64
foreign func EVP_des_ede3_ecb(): UInt64
foreign func EVP_des_cfb64(): UInt64
foreign func EVP_des_cfb1(): UInt64
foreign func EVP_des_cfb8(): UInt64
foreign func EVP_des_ede_cfb64(): UInt64
foreign func EVP_des_ede3_cfb64(): UInt64
foreign func EVP_des_ede3_cfb1(): UInt64
foreign func EVP_des_ede3_cfb8(): UInt64
foreign func EVP_des_ofb(): UInt64
foreign func EVP_des_ede_ofb(): UInt64
foreign func EVP_des_ede3_ofb(): UInt64
foreign func EVP_des_cbc(): UInt64
foreign func EVP_des_ede_cbc(): UInt64
foreign func EVP_des_ede3_cbc(): UInt64
foreign func EVP_desx_cbc(): UInt64
foreign func EVP_des_ede3_wrap(): UInt64

//sm4
foreign func EVP_sm4_ecb(): UInt64
foreign func EVP_sm4_cbc(): UInt64
foreign func EVP_sm4_cfb128(): UInt64
foreign func EVP_sm4_ofb(): UInt64
foreign func EVP_sm4_ctr(): UInt64

//aes
foreign func EVP_aes_128_ecb(): UInt64
foreign func EVP_aes_128_cbc(): UInt64
foreign func EVP_aes_128_cfb1(): UInt64
foreign func EVP_aes_128_cfb8(): UInt64
foreign func EVP_aes_128_cfb128(): UInt64
foreign func EVP_aes_128_ofb(): UInt64
foreign func EVP_aes_128_ctr(): UInt64
foreign func EVP_aes_128_ccm(): UInt64
foreign func EVP_aes_128_gcm(): UInt64
foreign func EVP_aes_128_xts(): UInt64
foreign func EVP_aes_128_wrap(): UInt64
foreign func EVP_aes_128_wrap_pad(): UInt64

foreign func EVP_aes_192_ecb(): UInt64
foreign func EVP_aes_192_cbc(): UInt64
foreign func EVP_aes_192_cfb1(): UInt64
foreign func EVP_aes_192_cfb8(): UInt64
foreign func EVP_aes_192_cfb128(): UInt64
foreign func EVP_aes_192_ofb(): UInt64
foreign func EVP_aes_192_ctr(): UInt64
foreign func EVP_aes_192_ccm(): UInt64
foreign func EVP_aes_192_gcm(): UInt64
foreign func EVP_aes_192_wrap(): UInt64
foreign func EVP_aes_192_wrap_pad(): UInt64

foreign func EVP_aes_256_ecb(): UInt64
foreign func EVP_aes_256_cbc(): UInt64
foreign func EVP_aes_256_cfb1(): UInt64
foreign func EVP_aes_256_cfb8(): UInt64
foreign func EVP_aes_256_cfb128(): UInt64
foreign func EVP_aes_256_ofb(): UInt64
foreign func EVP_aes_256_ctr(): UInt64
foreign func EVP_aes_256_ccm(): UInt64
foreign func EVP_aes_256_gcm(): UInt64
foreign func EVP_aes_256_xts(): UInt64
foreign func EVP_aes_256_wrap(): UInt64
foreign func EVP_aes_256_wrap_pad(): UInt64


foreign func EVP_aes_128_cbc_hmac_sha1(): UInt64
foreign func EVP_aes_256_cbc_hmac_sha1(): UInt64
foreign func EVP_aes_128_cbc_hmac_sha256(): UInt64
foreign func EVP_aes_256_cbc_hmac_sha256(): UInt64


