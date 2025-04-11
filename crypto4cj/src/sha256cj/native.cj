/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */
package crypto4cj.sha256cj
import crypto4cj.sha224cj.*

foreign func SHA256_Init(c: CPointer<SHA256_CTX>): Int32

foreign func SHA256_Update(c: CPointer<SHA256_CTX>, data: CPointer<UInt8>, len: Int32): Int32

foreign func SHA256_Final(md: CPointer<UInt8>, c: CPointer<SHA256_CTX>): Int32

foreign func SHA256(d: CPointer<UInt8>, n: Int32, md: CPointer<UInt8>): CPointer<UInt8>

foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(p: CPointer<SHA256_CTX>): Unit