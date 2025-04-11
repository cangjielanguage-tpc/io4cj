/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */
package crypto4cj.sha224cj

@C
public struct SHA256_CTX {
    var N1: UInt32 = 0
    var Nh: UInt32 = 0
    var sha224_h_0: UInt32 = 0
    var sha224_h_1: UInt32 = 0
    var sha224_h_2: UInt32 = 0
    var sha224_h_3: UInt32 = 0
    var sha224_h_4: UInt32 = 0
    var sha224_h_5: UInt32 = 0
    var sha224_h_6: UInt32 = 0
    var sha224_h_7: UInt32 = 0
    var sha224_data_0: UInt32 = 0
    var sha224_data_1: UInt32 = 0
    var sha224_data_2: UInt32 = 0
    var sha224_data_3: UInt32 = 0
    var sha224_data_4: UInt32 = 0
    var sha224_data_5: UInt32 = 0
    var sha224_data_6: UInt32 = 0
    var sha224_data_7: UInt32 = 0
    var sha224_data_8: UInt32 = 0
    var sha224_data_9: UInt32 = 0
    var sha224_data_10: UInt32 = 0
    var sha224_data_11: UInt32 = 0
    var sha224_data_12: UInt32 = 0
    var sha224_data_13: UInt32 = 0
    var sha224_data_14: UInt32 = 0
    var sha224_data_15: UInt32 = 0
    var num: UInt32 = 0
    var md_len: UInt32 = 0
}

foreign func SHA224_Init(c: CPointer<SHA256_CTX>): Int32

foreign func SHA224_Update(c: CPointer<SHA256_CTX>, data: CPointer<UInt8>, len: Int32): Int32

foreign func SHA224_Final(md: CPointer<UInt8>, c: CPointer<SHA256_CTX>): Int32

foreign func SHA224(d: CPointer<UInt8>, n: Int32, md: CPointer<UInt8>): CPointer<UInt8>

foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(p: CPointer<SHA256_CTX>): Unit