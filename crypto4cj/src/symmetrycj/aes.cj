/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.symmetrycj

import std.core.*
import crypto4cj.utils.*

/*
 * DES
 */
public class AES {
    
    public static let aes128Ecb: CIPHER = CIPHER(unsafe { EVP_aes_128_ecb() }, "aes128Ecb")
    public static let aes128Cbc: CIPHER = CIPHER(unsafe { EVP_aes_128_cbc() }, "aes128Cbc")
    public static let aes128Cfb1: CIPHER = CIPHER(unsafe { EVP_aes_128_cfb1() }, "aes128Cfb1")
    public static let aes128Cfb8: CIPHER = CIPHER(unsafe { EVP_aes_128_cfb8() }, "aes128Cfb8")
    public static let aes128Cfb128: CIPHER = CIPHER(unsafe { EVP_aes_128_cfb128() }, "aes128Cfb128")
    public static let aes128ofb: CIPHER = CIPHER(unsafe { EVP_aes_128_ofb() }, "aes128ofb")
    public static let aes128ctr: CIPHER = CIPHER(unsafe { EVP_aes_128_ctr() }, "aes128ctr")
    public static let aes128ccm: CIPHER = CIPHER(unsafe { EVP_aes_128_ccm() }, "aes128ccm")
    public static let aes128gcm: CIPHER = CIPHER(unsafe { EVP_aes_128_gcm() }, "aes128gcm")
    public static let aes128xts: CIPHER = CIPHER(unsafe { EVP_aes_128_xts() }, "aes128xts")
    public static let aes128wrap: CIPHER = CIPHER(unsafe { EVP_aes_128_wrap() }, "aes128wrap")
    public static let aes128wrapPad: CIPHER = CIPHER(unsafe { EVP_aes_128_wrap_pad() }, "aes128wrapPad")

    public static let aes192Ecb: CIPHER = CIPHER(unsafe { EVP_aes_192_ecb() }, "aes192Ecb")
    public static let aes192Cbc: CIPHER = CIPHER(unsafe { EVP_aes_192_cbc() }, "aes192Cbc")
    public static let aes192Cfb1: CIPHER = CIPHER(unsafe { EVP_aes_192_cfb1() }, "aes192Cfb1")
    public static let aes192Cfb8: CIPHER = CIPHER(unsafe { EVP_aes_192_cfb8() }, "aes192Cfb8")
    public static let aes192Cfb128: CIPHER = CIPHER(unsafe { EVP_aes_192_cfb128() }, "aes192Cfb128")
    public static let aes192ofb: CIPHER = CIPHER(unsafe { EVP_aes_192_ofb() }, "aes192ofb")
    public static let aes192ctr: CIPHER = CIPHER(unsafe { EVP_aes_192_ctr() }, "aes192ctr")
    public static let aes192ccm: CIPHER = CIPHER(unsafe { EVP_aes_192_ccm() }, "aes192ccm")
    public static let aes192gcm: CIPHER = CIPHER(unsafe { EVP_aes_192_gcm() }, "aes192gcm")
    public static let aes192wrap: CIPHER = CIPHER(unsafe { EVP_aes_192_wrap() }, "aes192wrap")
    public static let aes192wrapPad: CIPHER = CIPHER(unsafe { EVP_aes_192_wrap_pad() }, "aes192wrapPad")

    public static let aes256Ecb: CIPHER = CIPHER(unsafe { EVP_aes_256_ecb() }, "aes256Ecb")
    public static let aes256Cbc: CIPHER = CIPHER(unsafe { EVP_aes_256_cbc() }, "aes256Cbc")
    public static let aes256Cfb1: CIPHER = CIPHER(unsafe { EVP_aes_256_cfb1() }, "aes256Cfb1")
    public static let aes256Cfb8: CIPHER = CIPHER(unsafe { EVP_aes_256_cfb8() }, "aes256Cfb8")
    public static let aes256Cfb128: CIPHER = CIPHER(unsafe { EVP_aes_256_cfb128() }, "aes256Cfb128")
    public static let aes256ofb: CIPHER = CIPHER(unsafe { EVP_aes_256_ofb() }, "aes256ofb")
    public static let aes256ctr: CIPHER = CIPHER(unsafe { EVP_aes_256_ctr() }, "aes256ctr")
    public static let aes256ccm: CIPHER = CIPHER(unsafe { EVP_aes_256_ccm() }, "aes256ccm")
    public static let aes256gcm: CIPHER = CIPHER(unsafe { EVP_aes_256_gcm() }, "aes256gcm")
    public static let aes256xts: CIPHER = CIPHER(unsafe { EVP_aes_256_xts() }, "aes256xts")
    public static let aes256wrap: CIPHER = CIPHER(unsafe { EVP_aes_256_wrap() }, "aes256wrap")
    public static let aes256wrapPad: CIPHER = CIPHER(unsafe { EVP_aes_256_wrap_pad() }, "aes256wrapPad")

    public static let aes128CbcHmacSha1: CIPHER = CIPHER(unsafe { EVP_aes_128_cbc_hmac_sha1() }, "aes128CbcHmacSha1")
    public static let aes256CbcHmacSha1: CIPHER = CIPHER(unsafe { EVP_aes_256_cbc_hmac_sha1() }, "aes256CbcHmacSha1")
    public static let aes128CbcHmacSha256: CIPHER = CIPHER(unsafe { EVP_aes_128_cbc_hmac_sha256() }, "aes128CbcHmacSha256")
    public static let aes256CbcHmacSha256: CIPHER = CIPHER(unsafe { EVP_aes_256_cbc_hmac_sha256() }, "aes256CbcHmacSha256")
    
    public static func encrypt(cipher: CIPHER, 
                        input: Array<UInt8>,
                        key: Array<UInt8>, 
                        iv!: Array<UInt8>=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                        padding!: Int32 = EVP_PADDING_PKCS7): Array<UInt8> {
        if(padding < EVP_PADDING_NO || padding > EVP_PADDING_ZERO) {
            throw CryptoException("Invalid padding setting")
        }
        if(padding == EVP_PADDING_NO && input.size % 16 != 0) {
            throw CryptoException("Please enter data in multiples of 16")
        }
        judgeKeyIvLenth(cipher, iv, key)  
        var aes_encrypt: EVP = EVP()
        aes_encrypt.encryptInit(cipher, key, iv)      
        aes_encrypt.setPadding(padding)
        aes_encrypt.encryptUpdate(input)
        var encryptData: Array<UInt8> = aes_encrypt.encryptFinal()
        aes_encrypt.free() 
        
        return encryptData              
    }
   
    public static func decrypt(cipher: CIPHER, 
                        input: Array<UInt8>, 
                        key: Array<UInt8>, 
                        iv!: Array<UInt8>=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                        padding!: Int32 = EVP_PADDING_PKCS7): Array<UInt8>{
        if(padding < EVP_PADDING_NO || padding > EVP_PADDING_ZERO) {
            throw CryptoException("Invalid padding setting")
        }
        judgeKeyIvLenth(cipher, iv, key)
        var aes_decrypt: EVP = EVP()
        aes_decrypt.decryptInit(cipher, key, iv)      
        aes_decrypt.setPadding(padding)
        aes_decrypt.decryptUpdate(input)
        var decryptData: Array<UInt8> = aes_decrypt.decryptFinal()
        aes_decrypt.free() 
        return decryptData              
    }

    static func judgeKeyIvLenth(cipher: CIPHER, iv: Array<UInt8>, key: Array<UInt8>): Unit {
        if(cipher.getName().contains("aes256") ) {
            if(key.size != 32) {
                throw CryptoException("Please enter an 32-byte key")
            }
        } 
        if(cipher.getName().contains("aes192") ){
            if(key.size != 24) {
                throw CryptoException("Please enter an 24-byte key")
            }
        } 
        if(cipher.getName().contains("aes128")) {
            if(key.size != 16) {
                throw CryptoException("Please enter an 16-byte key")
            }
        }
        if(iv.size != 16) {
            throw CryptoException("Please enter an 16-byte iv")
        } 
    }


}

