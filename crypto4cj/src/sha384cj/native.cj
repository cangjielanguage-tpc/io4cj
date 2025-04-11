/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

/**
 * @file
 * This file is about Interoperate with c language
 */
package crypto4cj.sha384cj
@C
public struct SHA512_CTX {
    var sha384_h_0: UInt64 = 0
    var sha384_h_1: UInt64 = 0
    var sha384_h_2: UInt64 = 0
    var sha384_h_3: UInt64 = 0
    var sha384_h_4: UInt64 = 0
    var sha384_h_5: UInt64 = 0
    var sha384_h_6: UInt64 = 0
    var sha384_h_7: UInt64 = 0
    var N1: UInt64 = 0
    var Nh: UInt64 = 0
    var sha384_d_0: UInt64 = 0
    var sha384_d_1: UInt64 = 0
    var sha384_d_2: UInt64 = 0
    var sha384_d_3: UInt64 = 0
    var sha384_d_4: UInt64 = 0
    var sha384_d_5: UInt64 = 0
    var sha384_d_6: UInt64 = 0
    var sha384_d_7: UInt64 = 0
    var sha384_d_8: UInt64 = 0
    var sha384_d_9: UInt64 = 0
    var sha384_d_10: UInt64 = 0
    var sha384_d_11: UInt64 = 0
    var sha384_d_12: UInt64 = 0
    var sha384_d_13: UInt64 = 0
    var sha384_d_14: UInt64 = 0
    var sha384_d_15: UInt64 = 0
    var sha384_p_0: UInt8 = 0
    var sha384_p_1: UInt8 = 0
    var sha384_p_2: UInt8 = 0
    var sha384_p_3: UInt8 = 0
    var sha384_p_4: UInt8 = 0
    var sha384_p_5: UInt8 = 0
    var sha384_p_6: UInt8 = 0
    var sha384_p_7: UInt8 = 0
    var sha384_p_8: UInt8 = 0
    var sha384_p_9: UInt8 = 0
    var sha384_p_10: UInt8 = 0
    var sha384_p_11: UInt8 = 0
    var sha384_p_12: UInt8 = 0
    var sha384_p_13: UInt8 = 0
    var sha384_p_14: UInt8 = 0
    var sha384_p_15: UInt8 = 0
    var sha384_p_16: UInt8 = 0
    var sha384_p_17: UInt8 = 0
    var sha384_p_18: UInt8 = 0
    var sha384_p_19: UInt8 = 0
    var sha384_p_20: UInt8 = 0
    var sha384_p_21: UInt8 = 0
    var sha384_p_22: UInt8 = 0
    var sha384_p_23: UInt8 = 0
    var sha384_p_24: UInt8 = 0
    var sha384_p_25: UInt8 = 0
    var sha384_p_26: UInt8 = 0
    var sha384_p_27: UInt8 = 0
    var sha384_p_28: UInt8 = 0
    var sha384_p_29: UInt8 = 0
    var sha384_p_30: UInt8 = 0
    var sha384_p_31: UInt8 = 0
    var sha384_p_32: UInt8 = 0
    var sha384_p_33: UInt8 = 0
    var sha384_p_34: UInt8 = 0
    var sha384_p_35: UInt8 = 0
    var sha384_p_36: UInt8 = 0
    var sha384_p_37: UInt8 = 0
    var sha384_p_38: UInt8 = 0
    var sha384_p_39: UInt8 = 0
    var sha384_p_40: UInt8 = 0
    var sha384_p_41: UInt8 = 0
    var sha384_p_42: UInt8 = 0
    var sha384_p_43: UInt8 = 0
    var sha384_p_44: UInt8 = 0
    var sha384_p_45: UInt8 = 0
    var sha384_p_46: UInt8 = 0
    var sha384_p_47: UInt8 = 0
    var sha384_p_48: UInt8 = 0
    var sha384_p_49: UInt8 = 0
    var sha384_p_50: UInt8 = 0
    var sha384_p_51: UInt8 = 0
    var sha384_p_52: UInt8 = 0
    var sha384_p_53: UInt8 = 0
    var sha384_p_54: UInt8 = 0
    var sha384_p_55: UInt8 = 0
    var sha384_p_56: UInt8 = 0
    var sha384_p_57: UInt8 = 0
    var sha384_p_58: UInt8 = 0
    var sha384_p_59: UInt8 = 0
    var sha384_p_60: UInt8 = 0
    var sha384_p_61: UInt8 = 0
    var sha384_p_62: UInt8 = 0
    var sha384_p_63: UInt8 = 0
    var sha384_p_64: UInt8 = 0
    var sha384_p_65: UInt8 = 0
    var sha384_p_66: UInt8 = 0
    var sha384_p_67: UInt8 = 0
    var sha384_p_68: UInt8 = 0
    var sha384_p_69: UInt8 = 0
    var sha384_p_70: UInt8 = 0
    var sha384_p_71: UInt8 = 0
    var sha384_p_72: UInt8 = 0
    var sha384_p_73: UInt8 = 0
    var sha384_p_74: UInt8 = 0
    var sha384_p_75: UInt8 = 0
    var sha384_p_76: UInt8 = 0
    var sha384_p_77: UInt8 = 0
    var sha384_p_78: UInt8 = 0
    var sha384_p_79: UInt8 = 0
    var sha384_p_80: UInt8 = 0
    var sha384_p_81: UInt8 = 0
    var sha384_p_82: UInt8 = 0
    var sha384_p_83: UInt8 = 0
    var sha384_p_84: UInt8 = 0
    var sha384_p_85: UInt8 = 0
    var sha384_p_86: UInt8 = 0
    var sha384_p_87: UInt8 = 0
    var sha384_p_88: UInt8 = 0
    var sha384_p_89: UInt8 = 0
    var sha384_p_90: UInt8 = 0
    var sha384_p_91: UInt8 = 0
    var sha384_p_92: UInt8 = 0
    var sha384_p_93: UInt8 = 0
    var sha384_p_94: UInt8 = 0
    var sha384_p_95: UInt8 = 0
    var sha384_p_96: UInt8 = 0
    var sha384_p_97: UInt8 = 0
    var sha384_p_98: UInt8 = 0
    var sha384_p_99: UInt8 = 0
    var sha384_p_100: UInt8 = 0
    var sha384_p_101: UInt8 = 0
    var sha384_p_102: UInt8 = 0
    var sha384_p_103: UInt8 = 0
    var sha384_p_104: UInt8 = 0
    var sha384_p_105: UInt8 = 0
    var sha384_p_106: UInt8 = 0
    var sha384_p_107: UInt8 = 0
    var sha384_p_108: UInt8 = 0
    var sha384_p_109: UInt8 = 0
    var sha384_p_110: UInt8 = 0
    var sha384_p_111: UInt8 = 0
    var sha384_p_112: UInt8 = 0
    var sha384_p_113: UInt8 = 0
    var sha384_p_114: UInt8 = 0
    var sha384_p_115: UInt8 = 0
    var sha384_p_116: UInt8 = 0
    var sha384_p_117: UInt8 = 0
    var sha384_p_118: UInt8 = 0
    var sha384_p_119: UInt8 = 0
    var sha384_p_120: UInt8 = 0
    var sha384_p_121: UInt8 = 0
    var sha384_p_122: UInt8 = 0
    var sha384_p_123: UInt8 = 0
    var sha384_p_124: UInt8 = 0
    var sha384_p_125: UInt8 = 0
    var sha384_p_126: UInt8 = 0
    var sha384_p_127: UInt8 = 0
    var num: UInt32 = 0
    var md_len: UInt32 = 0
}

foreign func SHA384_Init(c: CPointer<SHA512_CTX>): Int32

foreign func SHA384_Update(c: CPointer<SHA512_CTX>, data: CPointer<UInt8>, len: Int32): Int32

foreign func SHA384_Final(md: CPointer<UInt8>, c: CPointer<SHA512_CTX>): Int32

foreign func SHA384(d: CPointer<UInt8>, n: Int32, md: CPointer<UInt8>): CPointer<UInt8>

foreign func malloc(size: UIntNative): CPointer<Unit>

foreign func free(p: CPointer<SHA512_CTX>): Unit