/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2022-2024. All rights reserved.
 */

package crypto4cj.digestcj

/*
 * Digest Type
 */
public class DigestType {
    public static let mdNull: DigestType = DigestType(unsafe { EVP_md_null() }) 
    public static let md4: DigestType = DigestType(unsafe { EVP_md4() })
    public static let md5: DigestType = DigestType(unsafe { EVP_md5() })
    public static let md5_sha1: DigestType = DigestType(unsafe { EVP_md5_sha1() })
    public static let blake2b512: DigestType = DigestType(unsafe { EVP_blake2b512() })
    public static let blake2s256: DigestType = DigestType(unsafe { EVP_blake2s256() })
    public static let sha1: DigestType = DigestType(unsafe { EVP_sha1() })
    public static let sha224: DigestType = DigestType(unsafe { EVP_sha224() })
    public static let sha256: DigestType = DigestType(unsafe { EVP_sha256() })
    public static let sha384: DigestType = DigestType(unsafe { EVP_sha384() })
    public static let sha512: DigestType = DigestType(unsafe { EVP_sha512() })
    public static let sha512_224: DigestType = DigestType(unsafe { EVP_sha512_224() })
    public static let sha512_256: DigestType = DigestType(unsafe { EVP_sha512_256() })
    public static let sha3_224: DigestType = DigestType(unsafe { EVP_sha3_224() })
    public static let sha3_256: DigestType = DigestType(unsafe { EVP_sha3_256() })
    public static let sha3_384: DigestType = DigestType(unsafe { EVP_sha3_384() })
    public static let sha3_512: DigestType = DigestType(unsafe { EVP_sha3_512() })
    public static let shake128: DigestType = DigestType(unsafe { EVP_shake128() })
    public static let shake256: DigestType = DigestType(unsafe { EVP_shake256() })
    public static let mdc2: DigestType = DigestType(unsafe { EVP_mdc2() })
    public static let ripemd160: DigestType = DigestType(unsafe { EVP_ripemd160() })
    public static let whirlpool: DigestType = DigestType(unsafe { EVP_whirlpool() })
    public static let sm3: DigestType = DigestType(unsafe { EVP_sm3() }) 
    var evpmd: UInt64 = 0

    init(m: UInt64){
        this.evpmd = m
    }
    /*
     * Get summary type pointer value
     * 
     * @return UInt64
     */
    public func getEvpMd(): UInt64 {
        this.evpmd
    }
    /*
     * Length after obtaining summary
     * 
     * @return Int32
     */
    public func getDigestSize(): Int32 {
        return unsafe { EVP_MD_get_size(this.evpmd) }
    }

    /*
     * Get Summary Type Long ID
     * 
     * @return Int32
     */
    public func getDigestTypeId(): Int32 {
        return unsafe { EVP_MD_get_type(this.evpmd) }
    }

    public func getName(): String {
       return unsafe { EVP_MD_get0_name(this.evpmd).toString() }
    }
    
}

