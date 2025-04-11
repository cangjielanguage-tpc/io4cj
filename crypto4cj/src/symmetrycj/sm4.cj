/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.symmetrycj

import crypto4cj.utils.*

/*
 * SM4
 */
public class SM4 {

    public static let sm4Ecb: CIPHER = CIPHER(unsafe { EVP_sm4_ecb() })

    public static let sm4Cbc: CIPHER = CIPHER(unsafe { EVP_sm4_cbc() })

    public static let sm4Cfb128: CIPHER = CIPHER(unsafe { EVP_sm4_cfb128() })

    public static let sm4Ofb: CIPHER = CIPHER(unsafe { EVP_sm4_ofb() })

    public static let sm4Ctr: CIPHER = CIPHER(unsafe { EVP_sm4_ctr() })

    /*
     * encrypt
     *
     * @param cipher - SM4 algorithm type (see static Member variable of SM4)
     * @param input - Encrypted data
     * @param key - secret key
     *             The key is 16 bytes
     * @param iv - offset
     *         Usually 16 bytes, using ECB mode, setting iv is invalid
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
        judgeKeyIvLenth(iv, key)
        var sm4_encrypt: EVP = EVP()
        sm4_encrypt.encryptInit(cipher, key, iv)      
        sm4_encrypt.setPadding(padding)
        sm4_encrypt.encryptUpdate(input)
        var encryptData: Array<UInt8> = sm4_encrypt.encryptFinal()
        sm4_encrypt.free() 
        return encryptData              
    }
    /*
     * decrypt
     *
     * @param cipher - SM4 algorithm type (see static Member variable of SM4)
     * @param input - Decrypting data
     * @param key - secret key
     *             The key is 16 bytes
     * @param iv - offset
     *          Usually 16 bytes, using ECB mode, setting iv is invalid
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
        judgeKeyIvLenth(iv, key)
        var sm4_decrypt: EVP = EVP()
        sm4_decrypt.decryptInit(cipher, key, iv)      
        sm4_decrypt.setPadding(padding)
        sm4_decrypt.decryptUpdate(input)
        var decryptData: Array<UInt8> = sm4_decrypt.decryptFinal()
        sm4_decrypt.free()  
        return decryptData              
    }
    
    static func judgeKeyIvLenth(iv: Array<UInt8>, key: Array<UInt8>): Unit {
        if(key.size != 16 || iv.size != 16) {
            throw CryptoException("Please enter an 16-byte key or iv")
        }
    }
}