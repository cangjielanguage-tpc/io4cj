/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */
package crypto4cj.sha512cj
import crypto4cj.sha384cj.*

foreign func SHA512_Init(c: CPointer<SHA512_CTX>): Int32

foreign func SHA512_Update(c: CPointer<SHA512_CTX>, data: CPointer<UInt8>, len: Int32): Int32

foreign func SHA512_Final(md: CPointer<UInt8>, c: CPointer<SHA512_CTX>): Int32

foreign func SHA512(d: CPointer<UInt8>, n: Int32, md: CPointer<UInt8>): CPointer<UInt8>

foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(p: CPointer<SHA512_CTX>): Unit
