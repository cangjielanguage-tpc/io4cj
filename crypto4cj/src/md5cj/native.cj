/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */

package crypto4cj.md5cj

@C
struct MD5_CTX {
    var A: UInt32 = 0
    var B: UInt32 = 0
    var C: UInt32 = 0
    var D: UInt32 = 0
    var Nl: UInt32 = 0
    var Nh: UInt32 = 0

    var md5_data_0: UInt32 = 0
    var md5_data_1: UInt32 = 0
    var md5_data_2: UInt32 = 0
    var md5_data_3: UInt32 = 0
    var md5_data_4: UInt32 = 0
    var md5_data_5: UInt32 = 0
    var md5_data_6: UInt32 = 0
    var md5_data_7: UInt32 = 0
    var md5_data_8: UInt32 = 0
    var md5_data_9: UInt32 = 0
    var md5_data_10: UInt32 = 0
    var md5_data_11: UInt32 = 0
    var md5_data_12: UInt32 = 0
    var md5_data_13: UInt32 = 0
    var md5_data_14: UInt32 = 0
    var md5_data_15: UInt32 = 0
    var num: UInt32 = 0
}

foreign func MD5_Init(c: CPointer<MD5_CTX>): Int32

foreign func MD5_Update(c: CPointer<MD5_CTX>, data: CPointer<UInt8>, len: Int32): Int32

foreign func MD5_Final(md: CPointer<UInt8>, c: CPointer<MD5_CTX>): Int32

foreign func MD5(d: CPointer<UInt8>, n: Int32, md: CPointer<UInt8>): CPointer<UInt8>

foreign func malloc(size: UIntNative): CPointer<Unit>

/**
 * The class is MD5CTX
 * @author guo_tingtingtekla
 * @since 0.32.5
 */
public class MD5CTX {
    let md5ptr: CPointer<MD5_CTX>

    /**
     * The Function is init md5
     *
     * @since 0.32.5
     */
    public init() {
        /*
         * struct MD5_CTX: 
         * UInt32: 4 * 23 = 92
         * plus: 92
         */
        var ptr = unsafe { malloc(92) }
        var p = CPointer<MD5_CTX>(ptr) 
        this.md5ptr = p
        unsafe { MD5_Init(p) }
    }
}
