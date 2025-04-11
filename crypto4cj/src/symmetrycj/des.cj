/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.symmetrycj

import std.core.*
import crypto4cj.utils.*

/*
 * DES
 */
public class DES {
    // DES
    public static let desEcb: CIPHER = CIPHER(unsafe { EVP_des_ecb() }, "desEcb")

    public static let desCbc: CIPHER = CIPHER(unsafe { EVP_des_cbc() }, "desCbc")

    public static let desCfb64: CIPHER = CIPHER(unsafe { EVP_des_cfb64() }, "desCfb64")

    public static let desCfb1: CIPHER = CIPHER(unsafe { EVP_des_cfb1() }, "desCfb1")

    public static let desCfb8: CIPHER = CIPHER(unsafe { EVP_des_cfb8() }, "desCfb8")

    public static let desOfb: CIPHER = CIPHER(unsafe { EVP_des_ofb() }, "desOfb")

    // DES algorithm using two keys
    public static let desEde: CIPHER = CIPHER(unsafe { EVP_des_ede() }, "desEde")

    public static let desEdeEcb: CIPHER = CIPHER(unsafe { EVP_des_ede_ecb() }, "desEdeEcb")

    public static let desEdeCfb64: CIPHER = CIPHER(unsafe { EVP_des_ede_cfb64() }, "desEdeCfb64")

    public static let desEdeOfb: CIPHER = CIPHER(unsafe { EVP_des_ede_ofb() }, "desEdeOfb")

    public static let desEdeCbc: CIPHER = CIPHER(unsafe { EVP_des_ede_cbc() }, "desEdeCbc")

    // DES algorithm using three keys
    public static let desEde3: CIPHER = CIPHER(unsafe { EVP_des_ede3() }, "desEde3")

    public static let desEde3Ecb: CIPHER = CIPHER(unsafe { EVP_des_ede3_ecb() }, "desEde3Ecb")

    public static let desEde3Cfb64: CIPHER = CIPHER(unsafe { EVP_des_ede3_cfb64() }, "desEde3Cfb64")

    public static let desEde3Cfb1: CIPHER = CIPHER(unsafe { EVP_des_ede3_cfb1() }, "desEde3Cfb1")

    public static let desEde3Cfb8: CIPHER = CIPHER(unsafe { EVP_des_ede3_cfb8() }, "desEde3Cfb8")

    public static let desEde3Ofb: CIPHER = CIPHER(unsafe { EVP_des_ede3_ofb() }, "desEde3Ofb")

    public static let desEde3Cbc: CIPHER = CIPHER(unsafe { EVP_des_ede3_cbc() }, "desEde3Cbc")

    // DESX
    public static let desxCbc: CIPHER = CIPHER(unsafe { EVP_desx_cbc() }, "desxCbc")

    /*
     * encrypt
     *
     * @param cipher - DES algorithm type (see static Member variable of DES)
     * @param input - Encrypted data
     * @param key - secret key
     *            DES - The key is 8 bytes
     *            2DES - The key is 16 bytes
     *            3DES - The key is 24 bytes
     * @param iv - offset
     *         Usually 8 bytes, using ECB mode, setting iv is invalid
     * @return Array<UInt8> - Encrypted data
     */ 
    public static func encrypt(cipher: CIPHER, 
                        input: Array<UInt8>,
                        key: Array<UInt8>, 
                        iv: Array<UInt8>,
                        padding!: Int32 = EVP_PADDING_PKCS7): Array<UInt8> {
        if(padding < EVP_PADDING_NO || padding > EVP_PADDING_ZERO) {
            throw CryptoException("Invalid padding setting")
        }
        loadLowApi(cipher)
        judgeKeyIvLenth(cipher, iv, key)  
        var des_encrypt: EVP = EVP()
        des_encrypt.encryptInit(cipher, key, iv)      
        des_encrypt.setPadding(padding)
        des_encrypt.encryptUpdate(input)
        var encryptData: Array<UInt8> = des_encrypt.encryptFinal()
        des_encrypt.free() 
        
        return encryptData              
    }
    /*
     * decrypt
     *
     * @param cipher - DES algorithm type (see static Member variable of DES)
     * @param input - Decrypting data
     * @param key - secret key
     *            DES - The key is 8 bytes
     *            2DES - The key is 16 bytes
     *            3DES - The key is 24 bytes
     * @param iv - offset
     *          Usually 8 bytes, using ECB mode, setting iv is invalid
     * @return Array<UInt8> - Decrypted data
     */
    public static func decrypt(cipher: CIPHER, 
                        input: Array<UInt8>, 
                        key: Array<UInt8>, 
                        iv: Array<UInt8>,
                        padding!: Int32 = EVP_PADDING_PKCS7): Array<UInt8>{
        if(padding < EVP_PADDING_NO || padding > EVP_PADDING_ZERO) {
            throw CryptoException("Invalid padding setting")
        }
        loadLowApi(cipher)
        judgeKeyIvLenth(cipher, iv, key)
        var des_decrypt: EVP = EVP()
        des_decrypt.decryptInit(cipher, key, iv)      
        des_decrypt.setPadding(padding)
        des_decrypt.decryptUpdate(input)
        var decryptData: Array<UInt8> = des_decrypt.decryptFinal()
        des_decrypt.free() 
        return decryptData              
    }

    static func judgeKeyIvLenth(cipher: CIPHER, iv: Array<UInt8>, key: Array<UInt8>): Unit {
        if(cipher.getName().contains("desEde3") || cipher.getName() == "desxCbc") {
            if(key.size != 24) {
                throw CryptoException("Please enter an 24-byte key")
            }
        } 
        if(cipher.getName().contains("desEde") && !cipher.getName().contains("desEde3")){
            if(key.size != 16) {
                throw CryptoException("Please enter an 16-byte key")
            }
        } 
        if(!cipher.getName().contains("desEde") && !cipher.getName().contains("desEde3") && !cipher.getName().contains("desxCbc")) {
            if(key.size != 8) {
                throw CryptoException("Please enter an 8-byte key")
            }
        }
        if(iv.size != 8) {
            throw CryptoException("Please enter an 8-byte iv")
        } 
    }

    // Whether to load low-level APIs
    public static func loadLowApi(cipher: CIPHER): Unit {
        let ret: Bool = match(cipher.getName()) {
            case "desEcb" | "desCbc" | "desCfb64" | "desCfb1" | "desCfb8" | "desOfb" | "desxCbc" => true
            case _ => false
        }
        if(ret) {
            loadProvider()
        }   
    }
}

