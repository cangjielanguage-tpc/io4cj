/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */

package crypto4cj.hmaccj

foreign func HMAC_CTX_new(): UInt64

foreign func HMAC_CTX_free(ctx: UInt64): Unit

foreign func HMAC_Init(ctx: UInt64, key: CPointer<UInt8>, len: Int32, md: UInt64, impl: UInt64): Int32

foreign func HMAC_Update(ctx: UInt64, data: CPointer<UInt8>, len: Int32): Int32

foreign func HMAC_Final(ctx: UInt64, md: CPointer<UInt8>, len: UInt32): Int32

foreign func HMAC(evp_md: UInt64, key: CPointer<UInt8>, key_len: Int32,
                    data: CPointer<UInt8>, data_len: UIntNative,
                    md: CPointer<UInt8>, md_len: CPointer<UInt32>): CPointer<UInt8>

foreign func EVP_get_digestbyname(name: CString): UInt64