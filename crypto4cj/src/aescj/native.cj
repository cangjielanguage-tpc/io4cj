/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */

package crypto4cj.aescj

@C
public struct AES_KEY {
    var rd_key_0: UInt32 = 0
    var rd_key_1: UInt32 = 0
    var rd_key_2: UInt32 = 0
    var rd_key_3: UInt32 = 0
    var rd_key_4: UInt32 = 0
    var rd_key_5: UInt32 = 0
    var rd_key_6: UInt32 = 0
    var rd_key_7: UInt32 = 0
    var rd_key_8: UInt32 = 0
    var rd_key_9: UInt32 = 0
    var rd_key_10: UInt32 = 0
    var rd_key_11: UInt32 = 0
    var rd_key_12: UInt32 = 0
    var rd_key_13: UInt32 = 0
    var rd_key_14: UInt32 = 0
    var rd_key_15: UInt32 = 0
    var rd_key_16: UInt32 = 0
    var rd_key_17: UInt32 = 0
    var rd_key_18: UInt32 = 0
    var rd_key_19: UInt32 = 0
    var rd_key_20: UInt32 = 0
    var rd_key_21: UInt32 = 0
    var rd_key_22: UInt32 = 0
    var rd_key_23: UInt32 = 0
    var rd_key_24: UInt32 = 0
    var rd_key_25: UInt32 = 0
    var rd_key_26: UInt32 = 0
    var rd_key_27: UInt32 = 0
    var rd_key_28: UInt32 = 0
    var rd_key_29: UInt32 = 0
    var rd_key_30: UInt32 = 0
    var rd_key_31: UInt32 = 0
    var rd_key_32: UInt32 = 0
    var rd_key_33: UInt32 = 0
    var rd_key_34: UInt32 = 0
    var rd_key_35: UInt32 = 0
    var rd_key_36: UInt32 = 0
    var rd_key_37: UInt32 = 0
    var rd_key_38: UInt32 = 0
    var rd_key_39: UInt32 = 0
    var rd_key_40: UInt32 = 0
    var rd_key_41: UInt32 = 0
    var rd_key_42: UInt32 = 0
    var rd_key_43: UInt32 = 0
    var rd_key_44: UInt32 = 0
    var rd_key_45: UInt32 = 0
    var rd_key_46: UInt32 = 0
    var rd_key_47: UInt32 = 0
    var rd_key_48: UInt32 = 0
    var rd_key_49: UInt32 = 0
    var rd_key_50: UInt32 = 0
    var rd_key_51: UInt32 = 0
    var rd_key_52: UInt32 = 0
    var rd_key_53: UInt32 = 0
    var rd_key_54: UInt32 = 0
    var rd_key_55: UInt32 = 0
    var rd_key_56: UInt32 = 0
    var rd_key_57: UInt32 = 0
    var rd_key_58: UInt32 = 0
    var rd_key_59: UInt32 = 0
    var rounds: Int32 = 0
}

foreign func AES_set_encrypt_key(userKey: CPointer<UInt8>, bits: Int32, key: CPointer<AES_KEY>): Int32

foreign func AES_set_decrypt_key(userKey: CPointer<UInt8>, bits: Int32, key: CPointer<AES_KEY>): Int32

foreign func AES_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, key: CPointer<AES_KEY>): CPointer<Unit>

foreign func AES_decrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, key: CPointer<AES_KEY>): CPointer<Unit>

foreign func AES_ecb_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, key: CPointer<AES_KEY>, enc: Int32): CPointer<Unit>

foreign func AES_cbc_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int32, key: CPointer<AES_KEY>, ivec: CPointer<UInt8>, enc: Int32): CPointer<Unit>

foreign func AES_cfb128_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int32, key: CPointer<AES_KEY>, ivec: CPointer<UInt8>, num: CPointer<Int32>, enc: Int32): CPointer<Unit>

foreign func AES_cfb1_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int32, key: CPointer<AES_KEY>, ivec: CPointer<UInt8>, num: CPointer<Int32>, enc: Int32): CPointer<Unit>

foreign func AES_cfb8_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int32, key: CPointer<AES_KEY>, ivec: CPointer<UInt8>, num: CPointer<Int32>, enc: Int32): CPointer<Unit>

foreign func AES_ofb128_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int32, key: CPointer<AES_KEY>, ivec: CPointer<UInt8>, num: CPointer<Int32>): CPointer<Unit>

foreign func AES_ige_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int32, key: CPointer<AES_KEY>, ivec: CPointer<UInt8>, enc: Int32): CPointer<Unit>

foreign func AES_bi_ige_encrypt(`in`: CPointer<UInt8>, out: CPointer<UInt8>, length: Int32, key: CPointer<AES_KEY>, key2: CPointer<AES_KEY>, ivec: CPointer<UInt8>, enc: Int32): CPointer<Unit>

foreign func AES_wrap_key(key: CPointer<AES_KEY>, iv: CPointer<UInt8>, out: CPointer<UInt8>, `in`: CPointer<UInt8>, inlen: UInt32): Int32

foreign func AES_unwrap_key(key: CPointer<AES_KEY>, iv: CPointer<UInt8>, out: CPointer<UInt8>, `in`: CPointer<UInt8>, inlen: UInt32): Int32

foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(p: CPointer<Int32>): Unit

/**
 * The class is AESKEY
 * @author guo_tingtingtekla
 * @since 0.32.5
 */
public class AESKEY {
    let ptr: CPointer<AES_KEY>

    /**
     * The Function is init AESKEY
     *
     * @since 0.32.5
     */
    public init() {
        /*
         * struct AES_KEY:
         * UInt32: 4 * 60 = 240
         * Int32: 4
         * plus: 244
         */
        var point = unsafe { malloc(244) }
        var p = CPointer<AES_KEY>(point)
        this.ptr = p
    }

    ~init() {
        unsafe { free(CPointer<Int32>(ptr)) }
    }
}