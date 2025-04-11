/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */
package crypto4cj.rc2cj

@C
struct RC2_KEY {
    var rc2_data_0: UInt32 = 0
    var rc2_data_1: UInt32 = 0
    var rc2_data_2: UInt32 = 0
    var rc2_data_3: UInt32 = 0
    var rc2_data_4: UInt32 = 0
    var rc2_data_5: UInt32 = 0
    var rc2_data_6: UInt32 = 0
    var rc2_data_7: UInt32 = 0
    var rc2_data_8: UInt32 = 0
    var rc2_data_9: UInt32 = 0
    var rc2_data_10: UInt32 = 0
    var rc2_data_11: UInt32 = 0
    var rc2_data_12: UInt32 = 0
    var rc2_data_13: UInt32 = 0
    var rc2_data_14: UInt32 = 0
    var rc2_data_15: UInt32 = 0
    var rc2_data_16: UInt32 = 0
    var rc2_data_17: UInt32 = 0
    var rc2_data_18: UInt32 = 0
    var rc2_data_19: UInt32 = 0
    var rc2_data_20: UInt32 = 0
    var rc2_data_21: UInt32 = 0
    var rc2_data_22: UInt32 = 0
    var rc2_data_23: UInt32 = 0
    var rc2_data_24: UInt32 = 0
    var rc2_data_25: UInt32 = 0
    var rc2_data_26: UInt32 = 0
    var rc2_data_27: UInt32 = 0
    var rc2_data_28: UInt32 = 0
    var rc2_data_29: UInt32 = 0
    var rc2_data_30: UInt32 = 0
    var rc2_data_31: UInt32 = 0
    var rc2_data_32: UInt32 = 0
    var rc2_data_33: UInt32 = 0
    var rc2_data_34: UInt32 = 0
    var rc2_data_35: UInt32 = 0
    var rc2_data_36: UInt32 = 0
    var rc2_data_37: UInt32 = 0
    var rc2_data_38: UInt32 = 0
    var rc2_data_39: UInt32 = 0
    var rc2_data_40: UInt32 = 0
    var rc2_data_41: UInt32 = 0
    var rc2_data_42: UInt32 = 0
    var rc2_data_43: UInt32 = 0
    var rc2_data_44: UInt32 = 0
    var rc2_data_45: UInt32 = 0
    var rc2_data_46: UInt32 = 0
    var rc2_data_47: UInt32 = 0
    var rc2_data_48: UInt32 = 0
    var rc2_data_49: UInt32 = 0
    var rc2_data_50: UInt32 = 0
    var rc2_data_51: UInt32 = 0
    var rc2_data_52: UInt32 = 0
    var rc2_data_53: UInt32 = 0
    var rc2_data_54: UInt32 = 0
    var rc2_data_55: UInt32 = 0
    var rc2_data_56: UInt32 = 0
    var rc2_data_57: UInt32 = 0
    var rc2_data_58: UInt32 = 0
    var rc2_data_59: UInt32 = 0
    var rc2_data_60: UInt32 = 0
    var rc2_data_61: UInt32 = 0
    var rc2_data_62: UInt32 = 0
    var rc2_data_63: UInt32 = 0
}

foreign func RC2_set_key(key: CPointer<RC2_KEY>, len: Int32, data: CPointer<UInt8>, bits: Int32): CPointer<Unit>

foreign func RC2_ecb_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, key: CPointer<RC2_KEY>, enc: Int32): CPointer<Unit>

foreign func RC2_encrypt(data: UInt64, key: CPointer<RC2_KEY>): CPointer<Unit>

foreign func RC2_decrypt(data: UInt64, key: CPointer<RC2_KEY>): CPointer<Unit>

foreign func RC2_cbc_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int64, ks: CPointer<RC2_KEY>, iv: CPointer<UInt8>, enc: Int32): CPointer<Unit>

foreign func RC2_cfb64_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int64, schedule: CPointer<RC2_KEY>, ivec: CPointer<UInt8>, num: CPointer<Int32>, enc: Int32): CPointer<Unit>

foreign func RC2_ofb64_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int64, schedule: CPointer<RC2_KEY>, ivec: CPointer<UInt8>, num: CPointer<Int32>): CPointer<Unit>

foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(p: CPointer<Int32>): Unit

/**
 * The class is RC2KEY
 * @author guo_tingtingtekla
 * @since 0.32.5
 */
public class RC2KEY {
    let rc2ptr: CPointer<RC2_KEY>

    /**
     * The Function is init RC2KEY
     *
     * @since 0.32.5
     */
    public init() {
        /*
         * struct RC2_KEY: 
         * UInt32: 4 * 64 = 256
         * plus: 256
         */
        var ptr = unsafe { malloc(256) }
        var p = CPointer<RC2_KEY>(ptr)
        this.rc2ptr = p
    }
}