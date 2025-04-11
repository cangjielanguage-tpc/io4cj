/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */
package crypto4cj.sha1cj

@C
struct SHA_CTX {
    var h0: UInt32 = 0
    var h1: UInt32 = 0
    var h2: UInt32 = 0
    var h3: UInt32 = 0
    var h4: UInt32 = 0
    var N1: UInt32 = 0
    var Nh: UInt32 = 0
    var sha_data_0: UInt32 = 0
    var sha_data_1: UInt32 = 0
    var sha_data_2: UInt32 = 0
    var sha_data_3: UInt32 = 0
    var sha_data_4: UInt32 = 0
    var sha_data_5: UInt32 = 0
    var sha_data_6: UInt32 = 0
    var sha_data_7: UInt32 = 0
    var sha_data_8: UInt32 = 0
    var sha_data_9: UInt32 = 0
    var sha_data_10: UInt32 = 0
    var sha_data_11: UInt32 = 0
    var sha_data_12: UInt32 = 0
    var sha_data_13: UInt32 = 0
    var sha_data_14: UInt32 = 0
    var sha_data_15: UInt32 = 0
    var num: UInt32 = 0
}

foreign func SHA1_Init(c: CPointer<SHA_CTX>): Int32

foreign func SHA1_Update(c: CPointer<SHA_CTX>, data: CPointer<UInt8>, len: Int32): Int32

foreign func SHA1_Final(md: CPointer<UInt8>, c: CPointer<SHA_CTX>): Int32

foreign func SHA1(d: CPointer<UInt8>, n: Int32, md: CPointer<UInt8>): CPointer<UInt8>

foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(p: CPointer<Int32>): Unit

/**
 * The class is SHACTX
 * @author guo_tingtingtekla
 * @since 0.32.5
 */
public class SHACTX {
    let ptr: CPointer<SHA_CTX>

    /**
     * The Function is init SHACTX
     *
     * @since 0.32.5
     */
    public init() {
        /*
         * struct SHA_CTX: 
         * UInt32: 4 * 24 = 96
         * plus: 96
         */
        var ptr = unsafe { malloc(96) }
        var p = CPointer<SHA_CTX>(ptr)
        this.ptr = p
        unsafe { SHA1_Init(p) }
    }
}

