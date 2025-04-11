<div align="center">
<h1>crypto4cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.58.3-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-90.4%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>

## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/> 介绍

crypto4cj 是一个安全的密码库，包括摘要算法、对称加密算法、非对称加密算法、密钥生成和签名验证。 
该库是对 openSSL 封装的仓颉加密算法,当前 openssl `3.0.7`
地址：https://github.com/openssl/openssl  

**特性**：

- 🚀 支持摘要算法
   - MD4、MD5、md5_sha1、SHA1、SHA224、SHA256、SHA384、SHA512、mdc2
   - sha512_224、sha512_256、sha3_224、sha3_256、sha3_384、sha3_512
   - shake128、shake256、ripemd160、ripemd160、blake2b512、blake2s256
   - SM3
   - HMAC

- 🚀 支持对称加密算法
    - DES、2DES、3DES 
    - AES、RC2、RC4
    - SM4

- 🚀 支持非对称加密算法
    - RSA 加解密和签名验证
    - ECC 椭圆曲线算法（ECDSA、ECDH）
    - SM2 国密算法
    - DSA 签名验证
    - DH 通信双方进行密钥协商算法   

- 🚀 BIGNUM 计算类、随机数类、位运算、上下文函数

## <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 架构

### 源码目录

```shell
.
├── doc
├── include
├── lib
├── openssl_c
├── src
│   ├── aescj
│   ├── bignumcj
│   ├── dhcj
│   ├── digestcj
│   ├── dsacj
│   ├── eccj
│   ├── evpcj
│   ├── hmaccj
│   ├── md5cj
│   ├── rc2cj
│   ├── rc4cj
│   ├── rsacj
│   ├── sha1cj
│   ├── sha224cj
│   ├── sha256cj
│   ├── sha384cj
│   ├── sha512cj
│   ├── symmetrycj
│   └── utils
└── test
│   ├── HLT
│   ├── LLT
│   └── UT
├── CHANGELOG.md
├── gitee_gate.cfg
├── LICENSE.txt
├── module.json
├── README.md
├── README.OpenSource
```

- `doc` 存放库的设计文档、使用文档、LLT 用例覆盖报告
- `include` 是编译 C 的时候需要头文件依赖
- `lib` 存放 `copenssl` 的 `crypto` 源码动态库
- `src` 是库源码目录
- `test` 存放 HLT 测试用例、LLT 自测用例和 UT 单元测试用例

### 接口说明

主要核心类和全局函数说明,详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译

前提：参考 https://github.com/openssl/openssl 官网安装 `openssl`,版本为 `OpenSSL 3.0.7`。

本项目提供 `libcrypto.so` 直接获取地址 https://gitee.com/HW-PLLab/ci_lib/tree/lib_crypto4cj，若没有权限获取需自行编译，方式参考如下：

#### **openssl编译**

1. linux x86_64 编译

   进入openssl根目录，执行下面语句

   ```shell
   sed -i "s/sub shlibext.*shared_extension\}$/sub shlibext            \{ \$target\{shared_extension\} || '.so' \}/" Configurations/platform/Unix.pm && sed -i '/                               ||/,/                          $x; \}/d' Configurations/platform/Unix.pm
   ./config no-asm no-dso
   make
   ```
   
2. Windows编译

   用mysys2进入openssl根目录，执行下面语句

   ```bash
   sed -i '/sub sharedname /{n;s/,$/);/;}' Configurations/platform/mingw.pm && sed -i '/                                    "-",/,/""));/d' Configurations/platform/mingw.pm
   ./Configure mingw64 no-asm no-dso
   make
   ```


3. ohos编译

   进入openssl根目录，执行下面语句（其中`/usr1/ohos/llvm/bin/`是ohos编译器路径，`/usr1/ohos/llvm/include/aarch64-linux-ohos`是ohos的头文件，请自行设置）

   ```shell
   sed -i "s/sub shlibext.*shared_extension\}$/sub shlibext            \{ \$target\{shared_extension\} || '.so' \}/" Configurations/platform/Unix.pm && sed -i '/                               ||/,/                          $x; \}/d' Configurations/platform/Unix.pm
   
   ./Configure -fPIC no-asm no-dso shared no-async linux-aarch64 --cross-compile-prefix="/usr1/ohos/llvm/bin/llvm-" 
   make CFLAGS="-I/usr1/ohos/llvm/include/aarch64-linux-ohos --target=aarch64-linux-ohos" LDFLAGS="--target=aarch64-linux-ohos" CC="/usr1/ohos/llvm/bin/clang" 
   ```
   

#### **crypto4cj编译**


1. linux x86_64 编译

   将上面生成文件 `libcrypto.so`，放入根目录的 `lib` 文件夹下，之后执行

   ```
   ./build_linux.sh
   ```

2. windows x64 编译

   将上面生成文件 `libcrypto.dll`，放入根目录的 `lib` 文件夹下，修改`build_windows.bat`中msys2的路径，之后执行

   ```
   build_windows.bat
   ```

3. ohos编译

   将上面生成ohos版本的文件 `libcrypto.so`，放入根目录的 `lib` 文件夹下，之后执行（其中`/usr1/ohos/llvm/bin/`是ohos编译器路径，`/usr1/ohos/llvm/include/aarch64-linux-ohos`是ohos的头文件，请自行设置）

   ```shell
   ./build_ohos.sh
   ```

4. aarch64编译
    将上面生成ohos版本的文件 `libcrypto.so`，放入根目录的 `lib` 文件夹下

    ```shell
    ./build_aarch64.sh
    ```

### 功能示例

####  MD5使用样例

```
import crypto4cj.md5cj.*

main() {    
    var md: Array<UInt8> = Array<UInt8>(16, repeat: 0)
    var result: String = String(Array<Char>(33, repeat: '0'))
    var str: String = "helloworld"
    var ret = md5(str.toArray(), md)
    result = md5HexToString(md)
    if(result != "fc5e038d38a57032085441e7fe7010b0") {
        return -1
    }
    return 0
}

```

执行结果:

```
0
```

####  RC2 使用样例

```
import crypto4cj.rc2cj.*
import crypto4cj.utils.*
import encoding.hex.*
import std.collection.*

main() {    
    var rc2key = RC2KEY()
    var keys: String = "1234567896465451"
    var datas: String = "helloword"
    var iv: Array<UInt8> = "53456637".toArray()
    var res: Array<UInt8> = Array<UInt8>(8, repeat: 0)
    rc2SetKey(rc2key, keys.toArray(), 0)
    // 编码
    var inside: Array<UInt8> = datas.toArray()
    var insides2: ArrayList<Array<UInt8>> = arrayTo2Array(inside, 8)
    var a: ArrayList<UInt8> = ArrayList<UInt8>()
    for(i in 0..insides2.size) { 
        rc2CbcEncrypt(insides2[i], res, rc2key, iv, RC2_ENCRYPT)
        var b = res
        a.add(all: b)
    }
    var resultE = toHexString(a.toArray())
    if(resultE != "173e2d3a6ede8c18262920ec196a6cbd") {
        return -1
    }
    // 解码
    var deRes: Array<UInt8> = Array<UInt8>(8, repeat: 0)
    var deData = fromHexString(resultE).getOrThrow()
    var insides3: ArrayList<Array<UInt8>> = arrayTo2Array(deData, 8)
    var c: ArrayList<UInt8> = ArrayList<UInt8>() 
    iv = "53456637".toArray()
    for(i in 0..insides3.size) { 
        rc2CbcEncrypt(insides3[i], deRes, rc2key, iv, RC2_DECRYPT)
        var b = deRes
        c.add(all: b)
    }
    var decryptRes = String.fromUtf8(c.toArray())
    if(!decryptRes.contains(datas)) {
        return -1
    }
    return 0
}

```
执行结果:

```
0
```

####  RC4 使用样例

```
import crypto4cj.rc4cj.*
import encoding.base64.*
import std.collection.*

main() {    
    var keys: Array<UInt8> = "1234567891111111".toArray()
    var indata: Array<UInt8> = "helloword".toArray()
    var encodeRes = rc4Encode(indata, keys)
    var decodeRes = rc4Decode(encodeRes, keys)
    if(toBase64String(encodeRes) != "Dqd7cGrLT0a7" || String.fromUtf8(decodeRes) != "helloword") {
        return -1
    }
    return 0
}

func rc4Encode(indata: Array<UInt8>, keys: Array<UInt8>): Array<UInt8> {
    var indataLen: Int32 = Int32(indata.size)
    var keysLen: Int32 = Int32(keys.size)
    var outdata: Array<UInt8> = Array<UInt8>(Int64(indataLen) , repeat: 0)
    if(indataLen == 0 || keysLen == 0) {
        return outdata
    }
    var key = RC4KEY()
    rc4SetKey(key, keys)
    rc4(key, indata, outdata)
    return outdata
}

func rc4Decode(indata: Array<UInt8>, keys: Array<UInt8>): Array<UInt8> {
    var indataLen: Int32 = Int32(indata.size)
    var keysLen: Int32 = Int32(keys.size)
    var outdata: Array<UInt8> = Array<UInt8>(Int64(indataLen) , repeat: 0)
    if(indataLen == 0 || keysLen == 0) {
        return outdata
    }
    var key = RC4KEY()
    rc4SetKey(key, keys)
    rc4(key, indata, outdata)
    return outdata
}
```
执行结果:

```
0
```

####  SHA(SHA1、SHA224、SHA256、SHA384、SHA512) 使用样例

```
import crypto4cj.sha1cj.*
import encoding.hex.*

main() {    
    var md: Array<UInt8> = Array<UInt8>(SHA_DIGEST_LENGTH, repeat: 0)
    var result: String = String(Array<Char>(SHA_DIGEST_LENGTH * 2 + 1, repeat: '0'))
    var str: String = "helloworld"
    sha1(str.toArray(), md)
    result = toHexString(md)
    if(result != "6adfb183a4a2c94a2f92dab5ade762a47889a5a1") {
        return -1
    }
    return 0
}

```

执行结果:

```
0
```

####  AES 使用样例

```
import crypto4cj.aescj.*
import crypto4cj.utils.*
import encoding.hex.*
import std.collection.*
import std.unicode.*

main() {    
    var keys: Array<UInt8> = "1234567812345678".toArray()
    var inside: Array<UInt8> = "skfhafahglkahglahglkahgalg".toArray()
    var encodeRes = aesEncode(inside, keys)
    if(toHexString(encodeRes) != "7da4e06948c190ecf633625517c1e7cbd40afb1fbe2dd55438c8f806c1c549d5") {
        return -1
    }
    var decodeRes = aesDecode(encodeRes, keys)
    if(!String.fromUtf8(decodeRes).contains("skfhafahglkahglahglkahgalg")) {
        return -1
    }
    return 0
}

func aesEncode(inside: Array<UInt8>, keys: Array<UInt8>): Array<UInt8> {
    var key = AESKEY()
    var outside: Array<UInt8> = Array<UInt8>(Int64(AES_BLOCK_SIZE), repeat: 0)
    var keyRet = aesSetEncryptKey(keys, 128, key)
    var data: ArrayList<Array<UInt8>> = arrayTo2Array(inside, Int64(AES_BLOCK_SIZE))
    var res: ArrayList<UInt8> = ArrayList<UInt8>()
    for( i in 0..data.size ) {
        aesEncrypt(data[i], outside, key)
        res.add(all: outside)
    }   
    return res.toArray()
}

func aesDecode(inside: Array<UInt8>, keys: Array<UInt8>): Array<UInt8> {
    var key = AESKEY()
    var outside: Array<UInt8> = Array<UInt8>(Int64(AES_BLOCK_SIZE), repeat: 0)
    var keyRet = aesSetDecryptKey(keys, 128, key)
    var data: ArrayList<Array<UInt8>> = arrayTo2Array(inside, Int64(AES_BLOCK_SIZE))
    var res: ArrayList<UInt8> = ArrayList<UInt8>()
    for( i in 0..data.size ) {
        aesDecrypt(data[i], outside, key)
        res.add(all: outside)
    }   
    return res.toArray()
}


```
执行结果:

```
0
```

####  HMAC 使用样例

```
import crypto4cj.hmaccj.*
import encoding.hex.*

main() { 
    var algorithm: AlgorithmType = AlgorithmType.Md5
    var key: Array<UInt8> = "test1280".toArray()
    var data: Array<UInt8> = "0123456789ABCDEF".toArray()
    var md: Array<UInt8> = Array<UInt8>(16, repeat: 0)
    hmac(algorithm, key, data, md)

    if(toHexString(md) != "5539dccd74dffdb0c671cc88c930bc25") {
        return -1
    }
    return 0
}
```
执行结果:

```
0
```

#### DSA 使用样例

```
import crypto4cj.dsacj.*
import std.os.posix.*

main() {  
    var path: String = getcwd()
    var ret: Int32 = 0
    var input_string: Array<UInt8> = [49,50,51,52,53,54,55,56,57,48,49,50,51,52,53,54,55,56,57,48,78,89,90]
    let dsa = dsaNew()
    dsaGenerateParameters(dsa, 1024)
    dsaGenerateKey(dsa)
    pemWriteDsaPara("${path}/dsaParams.pem", dsa)
    pemWriteDsaPri("${path}/dsaPri.pem", dsa)
    pemWriteDsaPub("${path}/dsaPub.pem", dsa)
    var sign_string: SINCALLOC = SINCALLOC(dsa)
    var res: SINSTR = dsaSign(DsaTypeId.NID_sha1, input_string, sign_string, dsa)
    var sinArray: Array<UInt8> = res.getArrayUtf8()
    ret = dsaVerify(DsaTypeId.NID_sha1, input_string, res, dsa)
    if(ret != 1) {
        return -1
    }
    return 0 
}

```
执行结果:

```
0
```

#### DH 使用样例

```
import crypto4cj.dhcj.*
import crypto4cj.bignumcj.*
import encoding.base64.*
main() {  
    let d1: DH = dhNew()
    let d2: DH = dhNew()
    var ret: Int32 = 0
    var size1: Int32 = 0
    var size2: Int32 = 0
    var p: CPointer<BIGNUM> = CPointer<BIGNUM>()
    var g: CPointer<BIGNUM> = CPointer<BIGNUM>()
    var q: CPointer<BIGNUM> = CPointer<BIGNUM>()
    var d1Pub: CPointer<BIGNUM> = CPointer<BIGNUM>()
    var d2Pub: CPointer<BIGNUM> = CPointer<BIGNUM>()
    /* 生成d1 的密钥参数*/
    dhGenerateParameters(d1, 512, DHGENERATOR.DH_GENERATOR_2)
    /* 检查密钥参数 */
    dhCheck(d1)
    /* d1 生成公私钥 */
    dhGenerateKey(d1)
    /* p和g为公开的密钥参数,因此可以拷贝 */
    p = dhGetP(d1)
    g = dhGetG(d1)
    d1Pub = dhGetPubKey(d1)
    /* d1 检查公钥 */
    dhCheckPubKey(d1, d1Pub)
    dnSetPQG(d2, p, q, g)
    /* d2 生成公私钥,用于测试生成共享密钥 */
    dhGenerateKey(d2)
    d2Pub = dhGetPubKey(d2)
    /* 密钥大小 */
    size1 = dhSize(d1)
    size2 = dhSize(d2)
    /* 计算共享密钥 */
    var sharekey1: SHAREMALLOC = SHAREMALLOC(d1)
    var sharekey2: SHAREMALLOC = SHAREMALLOC(d2)
    var (len1, sharekey11) = dhComputeKey(sharekey1, d2Pub, d1)
    var (len2, sharekey22) = dhComputeKey(sharekey2, d1Pub, d2)
    var (len3, sharekey33) = dhComputePaddeKey(sharekey1, d2Pub, d1)
    var (len4, sharekey44) = dhComputePaddeKey(sharekey2, d1Pub, d2)

    if(len1 != len2 || sharekey11 != sharekey22) {
       return -1
    }
    return 0 
}
```
执行结果:

```
0
```

#### RSA 使用样例

1. RSA 生成公私钥并将公私钥写入文件

```
import crypto4cj.rsacj.*
import crypto4cj.symmetrycj.*
import std.os.posix.*
import std.fs.*

main() {    
    var path: String = getcwd()   
    var rsa: RSAPrivateKey = RSA.generateKey(1024)
    let n: Array<UInt8> = rsa.getN()
    let e: Array<UInt8> = rsa.getE()
    let d: Array<UInt8> = rsa.getD()
    let p: Array<UInt8> = rsa.getP()
    let q: Array<UInt8> = rsa.getQ()
    let dmp: Array<UInt8> = rsa.getDmp()
    let dmq: Array<UInt8> = rsa.getDmq()
    let iqmp: Array<UInt8> = rsa.getIqmp()
    println("n: ${n}")
    println("e: ${e}")
    println("d: ${d}")
    println("p: ${p}")
    println("q: ${q}")
    println("dmp: ${dmp}")
    println("dmq: ${dmq}")
    println("iqmp: ${iqmp}")
    
    let priKey: Array<UInt8> = rsa.getPrivateKey()
    println("priKey: ${priKey}")
    let pubKey: Array<UInt8> = rsa.getPublicKey()
    println("pubKey: ${pubKey}")

    rsa.writePubKeyToFile("${path}/pub.pem")
    rsa.writePriKeyToFile("${path}/pri.pem", enc: DES.desEde3Ofb, password: "12345678")

    rsa.free()
    return 0
}
```
运行结果如下：

```cangjie
n: [201, 170, 87, 27, 225, 48, 127, 67, 179, 58, 250, 95, 194, 169, 229, 70, 210, 134, 108, 87, 137, 8, 189, 0, 220, 231, 125, 118, 156, 11, 171, 158, 150, 238, 146, 112, 98, 16, 191, 53, 116, 56, 163, 141, 119, 192, 236, 61, 224, 53, 50, 157, 233, 219, 217, 86, 175, 199, 74, 188, 123, 138, 146, 146, 128, 26, 239, 96, 132, 177, 121, 74, 189, 25, 171, 164, 39, 6, 86, 102, 110, 166, 132, 142, 238, 82, 247, 51, 205, 219, 168, 205, 63, 15, 21, 6, 123, 85, 114, 218, 147, 224, 44, 58, 145, 99, 149, 156, 151, 91, 7, 236, 88, 177, 99, 106, 133, 168, 116, 233, 215, 156, 216, 7, 64, 172, 65, 177]
e: [1, 0, 1]
d: [41, 255, 31, 68, 223, 16, 138, 112, 62, 210, 249, 113, 23, 200, 233, 198, 101, 241, 56, 126, 194, 58, 223, 161, 94, 95, 150, 241, 44, 110, 1, 191, 117, 15, 25, 207, 237, 156, 47, 53, 162, 142, 105, 0, 252, 255, 96, 51, 66, 141, 209, 140, 177, 54, 231, 123, 245, 255, 58, 193, 37, 185, 37, 236, 157, 52, 233, 12, 51, 52, 174, 46, 108, 183, 107, 209, 7, 193, 252, 214, 19, 173, 88, 196, 104, 70, 174, 226, 202, 147, 178, 89, 237, 82, 145, 106, 206, 152, 136, 79, 197, 96, 65, 195, 4, 201, 17, 231, 121, 164, 137, 128, 251, 206, 10, 220, 56, 254, 48, 108, 155, 151, 242, 130, 245, 192, 35, 65]
p: [252, 187, 115, 58, 42, 204, 64, 233, 116, 20, 25, 117, 231, 202, 1, 62, 48, 9, 7, 31, 53, 223, 81, 34, 218, 35, 210, 76, 171, 129, 223, 140, 4, 15, 158, 152, 11, 12, 196, 191, 160, 133, 120, 235, 41, 179, 19, 84, 197, 225, 187, 161, 3, 215, 169, 192, 166, 188, 215, 176, 68, 150, 114, 111]
q: [204, 69, 219, 144, 246, 138, 66, 57, 195, 245, 206, 11, 170, 158, 252, 43, 214, 28, 52, 198, 111, 80, 179, 100, 206, 174, 151, 133, 175, 58, 102, 114, 92, 204, 192, 152, 182, 36, 154, 35, 123, 229, 48, 125, 151, 114, 121, 189, 150, 187, 31, 87, 99, 232, 160, 87, 123, 209, 161, 153, 39, 216, 29, 223]
dmp: [247, 225, 134, 239, 219, 64, 64, 190, 121, 10, 169, 186, 58, 32, 168, 61, 109, 113, 189, 89, 128, 70, 75, 87, 42, 171, 141, 189, 131, 78, 59, 139, 34, 4, 139, 225, 198, 156, 188, 112, 211, 41, 118, 98, 248, 160, 90, 106, 128, 55, 154, 7, 32, 52, 171, 155, 120, 46, 170, 66, 137, 211, 33, 227]
dmq: [189, 94, 41, 141, 58, 176, 179, 114, 63, 178, 216, 191, 193, 253, 191, 2, 152, 107, 239, 148, 225, 206, 235, 111, 145, 151, 19, 74, 208, 70, 16, 129, 6, 124, 158, 51, 51, 239, 188, 161, 22, 147, 66, 159, 187, 77, 89, 132, 163, 126, 119, 48, 153, 163, 39, 57, 210, 196, 100, 205, 201, 189, 52, 251]
iqmp: [215, 198, 223, 87, 86, 123, 138, 11, 27, 88, 250, 111, 229, 229, 168, 255, 90, 147, 46, 45, 81, 63, 255, 163, 101, 20, 98, 73, 56, 117, 153, 168, 65, 94, 125, 70, 72, 103, 76, 30, 101, 34, 61, 245, 45, 127, 176, 132, 173, 165, 48, 118, 49, 142, 126, 81, 248, 147, 195, 234, 132, 198, 203, 138]
priKey: [48, 130, 2, 94, 2, 1, 0, 2, 129, 129, 0, 201, 170, 87, 27, 225, 48, 127, 67, 179, 58, 250, 95, 194, 169, 229, 70, 210, 134, 108, 87, 137, 8, 189, 0, 220, 231, 125, 118, 156, 11, 171, 158, 150, 238, 146, 112, 98, 16, 191, 53, 116, 56, 163, 141, 119, 192, 236, 61, 224, 53, 50, 157, 233, 219, 217, 86, 175, 199, 74, 188, 123, 138, 146, 146, 128, 26, 239, 96, 132, 177, 121, 74, 189, 25, 171, 164, 39, 6, 86, 102, 110, 166, 132, 142, 238, 82, 247, 51, 205, 219, 168, 205, 63, 15, 21, 6, 123, 85, 114, 218, 147, 224, 44, 58, 145, 99, 149, 156, 151, 91, 7, 236, 88, 177, 99, 106, 133, 168, 116, 233, 215, 156, 216, 7, 64, 172, 65, 177, 2, 3, 1, 0, 1, 2, 129, 128, 41, 255, 31, 68, 223, 16, 138, 112, 62, 210, 249, 113, 23, 200, 233, 198, 101, 241, 56, 126, 194, 58, 223, 161, 94, 95, 150, 241, 44, 110, 1, 191, 117, 15, 25, 207, 237, 156, 47, 53, 162, 142, 105, 0, 252, 255, 96, 51, 66, 141, 209, 140, 177, 54, 231, 123, 245, 255, 58, 193, 37, 185, 37, 236, 157, 52, 233, 12, 51, 52, 174, 46, 108, 183, 107, 209, 7, 193, 252, 214, 19, 173, 88, 196, 104, 70, 174, 226, 202, 147, 178, 89, 237, 82, 145, 106, 206, 152, 136, 79, 197, 96, 65, 195, 4, 201, 17, 231, 121, 164, 137, 128, 251, 206, 10, 220, 56, 254, 48, 108, 155, 151, 242, 130, 245, 192, 35, 65, 2, 65, 0, 252, 187, 115, 58, 42, 204, 64, 233, 116, 20, 25, 117, 231, 202, 1, 62, 48, 9, 7, 31, 53, 223, 81, 34, 218, 35, 210, 76, 171, 129, 223, 140, 4, 15, 158, 152, 11, 12, 196, 191, 160, 133, 120, 235, 41, 179, 19, 84, 197, 225, 187, 161, 3, 215, 169, 192, 166, 188, 215, 176, 68, 150, 114, 111, 2, 65, 0, 204, 69, 219, 144, 246, 138, 66, 57, 195, 245, 206, 11, 170, 158, 252, 43, 214, 28, 52, 198, 111, 80, 179, 100, 206, 174, 151, 133, 175, 58, 102, 114, 92, 204, 192, 152, 182, 36, 154, 35, 123, 229, 48, 125, 151, 114, 121, 189, 150, 187, 31, 87, 99, 232, 160, 87, 123, 209, 161, 153, 39, 216, 29, 223, 2, 65, 0, 247, 225, 134, 239, 219, 64, 64, 190, 121, 10, 169, 186, 58, 32, 168, 61, 109, 113, 189, 89, 128, 70, 75, 87, 42, 171, 141, 189, 131, 78, 59, 139, 34, 4, 139, 225, 198, 156, 188, 112, 211, 41, 118, 98, 248, 160, 90, 106, 128, 55, 154, 7, 32, 52, 171, 155, 120, 46, 170, 66, 137, 211, 33, 227, 2, 65, 0, 189, 94, 41, 141, 58, 176, 179, 114, 63, 178, 216, 191, 193, 253, 191, 2, 152, 107, 239, 148, 225, 206, 235, 111, 145, 151, 19, 74, 208, 70, 16, 129, 6, 124, 158, 51, 51, 239, 188, 161, 22, 147, 66, 159, 187, 77, 89, 132, 163, 126, 119, 48, 153, 163, 39, 57, 210, 196, 100, 205, 201, 189, 52, 251, 2, 65, 0, 215, 198, 223, 87, 86, 123, 138, 11, 27, 88, 250, 111, 229, 229, 168, 255, 90, 147, 46, 45, 81, 63, 255, 163, 101, 20, 98, 73, 56, 117, 153, 168, 65, 94, 125, 70, 72, 103, 76, 30, 101, 34, 61, 245, 45, 127, 176, 132, 173, 165, 48, 118, 49, 142, 126, 81, 248, 147, 195, 234, 132, 198, 203, 138]
pubKey: [48, 129, 137, 2, 129, 129, 0, 201, 170, 87, 27, 225, 48, 127, 67, 179, 58, 250, 95, 194, 169, 229, 70, 210, 134, 108, 87, 137, 8, 189, 0, 220, 231, 125, 118, 156, 11, 171, 158, 150, 238, 146, 112, 98, 16, 191, 53, 116, 56, 163, 141, 119, 192, 236, 61, 224, 53, 50, 157, 233, 219, 217, 86, 175, 199, 74, 188, 123, 138, 146, 146, 128, 26, 239, 96, 132, 177, 121, 74, 189, 25, 171, 164, 39, 6, 86, 102, 110, 166, 132, 142, 238, 82, 247, 51, 205, 219, 168, 205, 63, 15, 21, 6, 123, 85, 114, 218, 147, 224, 44, 58, 145, 99, 149, 156, 151, 91, 7, 236, 88, 177, 99, 106, 133, 168, 116, 233, 215, 156, 216, 7, 64, 172, 65, 177, 2, 3, 1, 0, 1]
```

2. RSA 公钥加密私钥解密（小数据)

私钥加密公钥解密与此类似

```
import crypto4cj.rsacj.*

main() {    
    let pri: Array<UInt8> =[
        48, 130, 2, 92, 2, 1, 0, 2, 129, 129, 0, 218, 135, 227, 194, 105, 61, 238, 229, 
        234, 42, 72, 144, 42, 250, 38, 137, 107, 132, 38, 111, 123, 19, 214, 35, 166, 15,
        82, 1, 93, 178, 157, 20, 189, 227, 165, 125, 207, 4, 88, 78, 162, 244, 165, 174,
        58, 66, 104, 218, 114, 253, 109, 148, 22, 91, 169, 128, 236, 149, 176, 92, 33, 
        156, 139, 135, 246, 245, 97, 102, 202, 77, 105, 31, 122, 116, 225, 208, 37, 178,
        3, 43, 37, 205, 18, 13, 100, 8, 174, 108, 7, 41, 199, 229, 147, 13, 178, 196, 
        8, 65, 106, 10, 183, 90, 244, 251, 220, 186, 169, 120, 28, 24, 246, 110, 142, 
        105, 46, 98, 32, 17, 129, 145, 210, 65, 249, 227, 33, 2, 27, 185, 2, 1, 3, 2, 
        129, 129, 0, 145, 175, 237, 44, 70, 41, 73, 238, 156, 28, 48, 96, 28, 166, 196,
        91, 157, 2, 196, 74, 82, 13, 57, 109, 25, 95, 140, 0, 233, 33, 190, 13, 211, 
        237, 24, 254, 138, 2, 229, 137, 193, 248, 110, 116, 38, 214, 240, 145, 161, 254, 
        73, 13, 100, 61, 27, 171, 72, 99, 202, 232, 22, 104, 93, 4, 19, 180, 157, 18, 
        228, 155, 153, 225, 246, 60, 235, 75, 187, 2, 2, 255, 115, 128, 28, 79, 78, 97, 
        199, 118, 59, 147, 156, 179, 156, 247, 100, 58, 113, 150, 54, 241, 47, 87, 167, 
        234, 125, 167, 98, 196, 209, 93, 194, 226, 158, 219, 159, 154, 222, 102, 166, 
        15, 188, 165, 153, 231, 45, 45, 87, 163, 2, 65, 0, 245, 208, 73, 78, 10, 130, 
        179, 5, 235, 9, 16, 72, 29, 166, 20, 75, 47, 253, 159, 231, 159, 246, 28, 211, 
        225, 230, 35, 170, 47, 140, 56, 61, 32, 74, 122, 254, 129, 73, 180, 45, 166, 
        58, 224, 146, 11, 234, 172, 64, 116, 30, 137, 139, 220, 147, 150, 131, 11, 55, 
        129, 90, 133, 8, 122, 127, 2, 65, 0, 227, 150, 44, 124, 104, 225, 79, 70, 158, 
        16, 112, 150, 111, 136, 234, 96, 200, 143, 71, 174, 206, 127, 230, 102, 203, 
        230, 57, 45, 248, 14, 100, 47, 61, 149, 156, 162, 111, 13, 196, 238, 122, 4, 
        180, 190, 214, 33, 165, 218, 44, 1, 53, 109, 245, 227, 241, 247, 44, 18, 17, 
        173, 216, 53, 157, 199, 2, 65, 0, 163, 224, 48, 222, 177, 172, 119, 89, 71, 
        91, 96, 48, 19, 196, 13, 135, 117, 83, 191, 239, 191, 249, 104, 141, 65, 68, 
        23, 198, 202, 93, 122, 211, 106, 220, 81, 255, 0, 219, 205, 115, 196, 39, 64, 
        97, 93, 71, 29, 128, 77, 105, 177, 7, 232, 98, 100, 87, 92, 207, 171, 145, 174, 
        5, 166, 255, 2, 65, 0, 151, 185, 114, 253, 155, 64, 223, 132, 105, 96, 75, 14, 
        245, 5, 241, 149, 219, 10, 47, 201, 222, 255, 238, 239, 50, 153, 123, 115, 250, 
        180, 66, 202, 41, 14, 104, 108, 74, 9, 45, 244, 81, 88, 120, 127, 57, 107, 195, 
        230, 200, 0, 206, 73, 78, 151, 246, 164, 200, 12, 11, 201, 58, 206, 105, 47, 2, 
        64, 32, 24, 155, 16, 110, 103, 52, 8, 123, 44, 18, 132, 54, 25, 9, 146, 15, 185, 
        184, 118, 107, 124, 196, 24, 212, 51, 32, 166, 34, 207, 174, 172, 186, 221, 2, 
        120, 97, 18, 178, 75, 8, 195, 250, 60, 252, 152, 100, 136, 131, 145, 157, 197, 
        50, 152, 241, 65, 93, 124, 235, 239, 241, 122, 91, 114]

    let pub: Array<UInt8> = [
        48, 129, 135, 2, 129, 129, 0, 218, 135, 227, 194, 105, 61, 238, 229, 234,
        42, 72, 144, 42, 250, 38, 137, 107, 132, 38, 111, 123, 19, 214, 35, 166, 
        15, 82, 1, 93, 178, 157, 20, 189, 227, 165, 125, 207, 4, 88, 78, 162, 244,
        165, 174, 58, 66, 104, 218, 114, 253, 109, 148, 22, 91, 169, 128, 236, 149, 
        176, 92, 33, 156, 139, 135, 246, 245, 97, 102, 202, 77, 105, 31, 122, 116, 
        225, 208, 37, 178, 3, 43, 37, 205, 18, 13, 100, 8, 174, 108, 7, 41, 199, 
        229, 147, 13, 178, 196, 8, 65, 106, 10, 183, 90, 244, 251, 220, 186, 169,
        120, 28, 24, 246, 110, 142, 105, 46, 98, 32, 17, 129, 145, 210, 65, 249, 
        227, 33, 2, 27, 185, 2, 1, 3
    ]
    var prik: RSAPrivateKey = RSA.setPrivateKey(pri)
    var pubk: RSAPublicKey = RSA.setPublicKey(pub)
    let datas: Array<UInt8> = "sffsaffsafscxaffsaffsaffsaffsaffsaffsafaffsaffsffsaffsffsaff".toArray()
    
    rsaPubEnc(datas, prik, pubk, RSA_PKCS1_PADDING)
    //rsaPubEnc(datas, prik, pubk, RSA_PKCS1_OAEP_PADDING)
    //rsaPubEnc(datas, prik, pubk, RSA_NO_PADDING)

    return 0
}

func rsaPubEnc(datas: Array<UInt8>, prik: RSAPrivateKey, pubk: RSAPublicKey, padding: PADDING): Int32 {
    let encryptDatas: Array<UInt8> = RSA.publicKeyEncrypt(datas, padding, pubk)
    println("原数据：${datas}")
    println("加密后数据：${encryptDatas}")
    println("加密后数据长度：${encryptDatas.size}")

    let decryptDatas: Array<UInt8> = RSA.privateKeyDecrypt(encryptDatas, padding, prik)
    println("解密后数据：${decryptDatas}")

    if(datas != decryptDatas) {
        return -1
    }
    return 0
}
```
运行结果如下：

```cangjie
原数据：[115, 102, 102, 115, 97, 102, 102, 115, 97, 102, 115, 99, 120, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 97, 102, 102, 115, 97, 102, 102, 115, 102, 102, 115, 97, 102, 102, 115, 102, 102, 115, 97, 102, 102]
加密后数据：[24, 119, 174, 170, 46, 243, 161, 26, 65, 149, 1, 19, 119, 75, 82, 56, 81, 134, 72, 241, 45, 140, 27, 238, 251, 236, 227, 208, 79, 4, 52, 176, 228, 193, 224, 168, 241, 226, 160, 124, 7, 44, 205, 111, 70, 156, 76, 148, 8, 32, 133, 230, 119, 212, 205, 213, 77, 1, 50, 62, 65, 123, 201, 34, 134, 244, 25, 18, 67, 240, 224, 20, 107, 62, 253, 98, 140, 189, 132, 173, 115, 232, 29, 162, 75, 87, 95, 151, 195, 112, 140, 115, 46, 77, 236, 122, 172, 88, 148, 88, 75, 86, 69, 93, 207, 145, 164, 219, 107, 231, 98, 193, 84, 88, 230, 223, 227, 255, 77, 211, 248, 58, 92, 154, 231, 93, 21, 92]
加密后数据长度：128
解密后数据：[115, 102, 102, 115, 97, 102, 102, 115, 97, 102, 115, 99, 120, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 102, 115, 97, 102, 97, 102, 102, 115, 97, 102, 102, 115, 102, 102, 115, 97, 102, 102, 115, 102, 102, 115, 97, 102, 102]
```

3. RSA 公钥加密私钥解密（大数据）

私钥加密公钥解密与此类似

```
import crypto4cj.rsacj.*
import std.collection.*

main() {    
    let pri: Array<UInt8> =[
        48, 130, 2, 92, 2, 1, 0, 2, 129, 129, 0, 218, 135, 227, 194, 105, 61, 238, 229, 
        234, 42, 72, 144, 42, 250, 38, 137, 107, 132, 38, 111, 123, 19, 214, 35, 166, 15,
        82, 1, 93, 178, 157, 20, 189, 227, 165, 125, 207, 4, 88, 78, 162, 244, 165, 174,
        58, 66, 104, 218, 114, 253, 109, 148, 22, 91, 169, 128, 236, 149, 176, 92, 33, 
        156, 139, 135, 246, 245, 97, 102, 202, 77, 105, 31, 122, 116, 225, 208, 37, 178,
        3, 43, 37, 205, 18, 13, 100, 8, 174, 108, 7, 41, 199, 229, 147, 13, 178, 196, 
        8, 65, 106, 10, 183, 90, 244, 251, 220, 186, 169, 120, 28, 24, 246, 110, 142, 
        105, 46, 98, 32, 17, 129, 145, 210, 65, 249, 227, 33, 2, 27, 185, 2, 1, 3, 2, 
        129, 129, 0, 145, 175, 237, 44, 70, 41, 73, 238, 156, 28, 48, 96, 28, 166, 196,
        91, 157, 2, 196, 74, 82, 13, 57, 109, 25, 95, 140, 0, 233, 33, 190, 13, 211, 
        237, 24, 254, 138, 2, 229, 137, 193, 248, 110, 116, 38, 214, 240, 145, 161, 254, 
        73, 13, 100, 61, 27, 171, 72, 99, 202, 232, 22, 104, 93, 4, 19, 180, 157, 18, 
        228, 155, 153, 225, 246, 60, 235, 75, 187, 2, 2, 255, 115, 128, 28, 79, 78, 97, 
        199, 118, 59, 147, 156, 179, 156, 247, 100, 58, 113, 150, 54, 241, 47, 87, 167, 
        234, 125, 167, 98, 196, 209, 93, 194, 226, 158, 219, 159, 154, 222, 102, 166, 
        15, 188, 165, 153, 231, 45, 45, 87, 163, 2, 65, 0, 245, 208, 73, 78, 10, 130, 
        179, 5, 235, 9, 16, 72, 29, 166, 20, 75, 47, 253, 159, 231, 159, 246, 28, 211, 
        225, 230, 35, 170, 47, 140, 56, 61, 32, 74, 122, 254, 129, 73, 180, 45, 166, 
        58, 224, 146, 11, 234, 172, 64, 116, 30, 137, 139, 220, 147, 150, 131, 11, 55, 
        129, 90, 133, 8, 122, 127, 2, 65, 0, 227, 150, 44, 124, 104, 225, 79, 70, 158, 
        16, 112, 150, 111, 136, 234, 96, 200, 143, 71, 174, 206, 127, 230, 102, 203, 
        230, 57, 45, 248, 14, 100, 47, 61, 149, 156, 162, 111, 13, 196, 238, 122, 4, 
        180, 190, 214, 33, 165, 218, 44, 1, 53, 109, 245, 227, 241, 247, 44, 18, 17, 
        173, 216, 53, 157, 199, 2, 65, 0, 163, 224, 48, 222, 177, 172, 119, 89, 71, 
        91, 96, 48, 19, 196, 13, 135, 117, 83, 191, 239, 191, 249, 104, 141, 65, 68, 
        23, 198, 202, 93, 122, 211, 106, 220, 81, 255, 0, 219, 205, 115, 196, 39, 64, 
        97, 93, 71, 29, 128, 77, 105, 177, 7, 232, 98, 100, 87, 92, 207, 171, 145, 174, 
        5, 166, 255, 2, 65, 0, 151, 185, 114, 253, 155, 64, 223, 132, 105, 96, 75, 14, 
        245, 5, 241, 149, 219, 10, 47, 201, 222, 255, 238, 239, 50, 153, 123, 115, 250, 
        180, 66, 202, 41, 14, 104, 108, 74, 9, 45, 244, 81, 88, 120, 127, 57, 107, 195, 
        230, 200, 0, 206, 73, 78, 151, 246, 164, 200, 12, 11, 201, 58, 206, 105, 47, 2, 
        64, 32, 24, 155, 16, 110, 103, 52, 8, 123, 44, 18, 132, 54, 25, 9, 146, 15, 185, 
        184, 118, 107, 124, 196, 24, 212, 51, 32, 166, 34, 207, 174, 172, 186, 221, 2, 
        120, 97, 18, 178, 75, 8, 195, 250, 60, 252, 152, 100, 136, 131, 145, 157, 197, 
        50, 152, 241, 65, 93, 124, 235, 239, 241, 122, 91, 114]

    let pub: Array<UInt8> = [
        48, 129, 135, 2, 129, 129, 0, 218, 135, 227, 194, 105, 61, 238, 229, 234,
        42, 72, 144, 42, 250, 38, 137, 107, 132, 38, 111, 123, 19, 214, 35, 166, 
        15, 82, 1, 93, 178, 157, 20, 189, 227, 165, 125, 207, 4, 88, 78, 162, 244,
        165, 174, 58, 66, 104, 218, 114, 253, 109, 148, 22, 91, 169, 128, 236, 149, 
        176, 92, 33, 156, 139, 135, 246, 245, 97, 102, 202, 77, 105, 31, 122, 116, 
        225, 208, 37, 178, 3, 43, 37, 205, 18, 13, 100, 8, 174, 108, 7, 41, 199, 
        229, 147, 13, 178, 196, 8, 65, 106, 10, 183, 90, 244, 251, 220, 186, 169,
        120, 28, 24, 246, 110, 142, 105, 46, 98, 32, 17, 129, 145, 210, 65, 249, 
        227, 33, 2, 27, 185, 2, 1, 3
    ]
    var prik: RSAPrivateKey = RSA.setPrivateKey(pri)
    var pubk: RSAPublicKey = RSA.setPublicKey(pub)
    let datas: Array<UInt8> = """
    The EVP interface supports the ability to perform authenticated encryption and decryption, 
    as well as the option to attach unencrypted, associated data to the message. 
    Such Authenticated-Encryption with Associated-Data (AEAD) schemes provide confidentiality by encrypting the data, 
    and also provide authenticity assurances by creating a MAC tag over the encrypted data. 
    The MAC tag will ensure the data is not accidentally altered or maliciously tampered during transmission and storage.
    """.toArray()

    diffPadding(datas, prik, pubk, RSA_PKCS1_PADDING)
    //diffPadding(datas, prik, pubk, RSA_PKCS1_OAEP_PADDING)
    //diffPadding(datas, prik, pubk, RSA_NO_PADDING)

    return 0
}

func diffPadding(datas: Array<UInt8>, prik: RSAPrivateKey, pubk: RSAPublicKey, padding: PADDING): Int32 {
    let encryptDatas: Array<UInt8> = pubKeyEncrypt(datas, pubk, padding)
    println("原数据：${datas}")
    println("加密后数据：${encryptDatas}")
    println("加密后数据长度：${encryptDatas.size}")

    let decryptDatas: Array<UInt8> = priKeyDecrypt(encryptDatas, prik, padding)
    println("解密后数据：${decryptDatas}")
    if(datas != decryptDatas) {
        return -1
    }
    return 0
}

// 数据量大，需要进行分段加解密
//公钥加密
func pubKeyEncrypt(datas: Array<UInt8>, pubk: RSAPublicKey, padding: PADDING): Array<UInt8> {
    let result: ArrayList<UInt8> = ArrayList<UInt8>()
    var pos: Int64 = 0
    let len: Int32 = pubk.getSize() // 获取RSA单次可以处理的数据的最大长度
    let block_len = padding.getFlen(len)   // 单次加密数据的最大长度   
    var sub_str: Array<UInt8>
    while(pos < datas.size) {
        if (pos + Int64(block_len) > datas.size) {
            sub_str = datas.slice(pos, datas.size - pos)
        } else {
            sub_str = datas.slice(pos, Int64(block_len))
        } 
        result.add(all: RSA.publicKeyEncrypt(sub_str, padding, pubk))
        pos += Int64(block_len)
    }

    return result.toArray()
}

func priKeyDecrypt(datas: Array<UInt8>, prik: RSAPrivateKey, padding: PADDING): Array<UInt8> {
    let result: ArrayList<UInt8> = ArrayList<UInt8>()
    var pos: Int64 = 0
    let len: Int32 = prik.getSize() // 获取RSA单次可以处理的数据的最大长度,由于加密后长度始终为len的倍数
    var sub_str: Array<UInt8>
    while(pos < datas.size) {
        sub_str = datas.slice(pos, Int64(len))
        result.add(all: RSA.privateKeyDecrypt(sub_str, padding, prik))
        pos += Int64(len)
    }
      
    return result.toArray()
}
```

运行结果如下：

```
原数据：[32, 32, 32, 32, 84, 104, 101, 32, 69, 86, 80, 32, 105, 110, 116, 101, 114, 102, 97, 99, 101, 32, 115, 117, 112, 112, 111, 114, 116, 115, 32, 116, 104, 101, 32, 97, 98, 105, 108, 105, 116, 121, 32, 116, 111, 32, 112, 101, 114, 102, 111, 114, 109, 32, 97, 117, 116, 104, 101, 110, 116, 105, 99, 97, 116, 101, 100, 32, 101, 110, 99, 114, 121, 112, 116, 105, 111, 110, 32, 97, 110, 100, 32, 100, 101, 99, 114, 121, 112, 116, 105, 111, 110, 44, 32, 10, 32, 32, 32, 32, 97, 115, 32, 119, 101, 108, 108, 32, 97, 115, 32, 116, 104, 101, 32, 111, 112, 116, 105, 111, 110, 32, 116, 111, 32, 97, 116, 116, 97, 99, 104, 32, 117, 110, 101, 110, 99, 114, 121, 112, 116, 101, 100, 44, 32, 97, 115, 115, 111, 99, 105, 97, 116, 101, 100, 32, 100, 97, 116, 97, 32, 116, 111, 32, 116, 104, 101, 32, 109, 101, 115, 115, 97, 103, 101, 46, 32, 10, 32, 32, 32, 32, 83, 117, 99, 104, 32, 65, 117, 116, 104, 101, 110, 116, 105, 99, 97, 116, 101, 100, 45, 69, 110, 99, 114, 121, 112, 116, 105, 111, 110, 32, 119, 105, 116, 104, 32, 65, 115, 115, 111, 99, 105, 97, 116, 101, 100, 45, 68, 97, 116, 97, 32, 40, 65, 69, 65, 68, 41, 32, 115, 99, 104, 101, 109, 101, 115, 32, 112, 114, 111, 118, 105, 100, 101, 32, 99, 111, 110, 102, 105, 100, 101, 110, 116, 105, 97, 108, 105, 116, 121, 32, 98, 121, 32, 101, 110, 99, 114, 121, 112, 116, 105, 110, 103, 32, 116, 104, 101, 32, 100, 97, 116, 97, 44, 32, 10, 32, 32, 32, 32, 97, 110, 100, 32, 97, 108, 115, 111, 32, 112, 114, 111, 118, 105, 100, 101, 32, 97, 117, 116, 104, 101, 110, 116, 105, 99, 105, 116, 121, 32, 97, 115, 115, 117, 114, 97, 110, 99, 101, 115, 32, 98, 121, 32, 99, 114, 101, 97, 116, 105, 110, 103, 32, 97, 32, 77, 65, 67, 32, 116, 97, 103, 32, 111, 118, 101, 114, 32, 116, 104, 101, 32, 101, 110, 99, 114, 121, 112, 116, 101, 100, 32, 100, 97, 116, 97, 46, 32, 10, 32, 32, 32, 32, 84, 104, 101, 32, 77, 65, 67, 32, 116, 97, 103, 32, 119, 105, 108, 108, 32, 101, 110, 115, 117, 114, 101, 32, 116, 104, 101, 32, 100, 97, 116, 97, 32, 105, 115, 32, 110, 111, 116, 32, 97, 99, 99, 105, 100, 101, 110, 116, 97, 108, 108, 121, 32, 97, 108, 116, 101, 114, 101, 100, 32, 111, 114, 32, 109, 97, 108, 105, 99, 105, 111, 117, 115, 108, 121, 32, 116, 97, 109, 112, 101, 114, 101, 100, 32, 100, 117, 114, 105, 110, 103, 32, 116, 114, 97, 110, 115, 109, 105, 115, 115, 105, 111, 110, 32, 97, 110, 100, 32, 115, 116, 111, 114, 97, 103, 101, 46, 10, 32, 32, 32, 32]
加密后数据：[12, 174, 221, 86, 192, 201, 108, 63, 97, 239, 200, 129, 36, 186, 231, 135, 60, 85, 147, 71, 5, 24, 177, 250, 48, 68, 114, 180, 142, 68, 106, 129, 178, 37, 213, 109, 75, 167, 82, 233, 76, 138, 123, 84, 48, 9, 196, 37, 154, 6, 233, 58, 123, 81, 135, 54, 243, 27, 85, 104, 201, 36, 127, 246, 23, 123, 221, 0, 220, 147, 170, 128, 170, 238, 226, 108, 225, 152, 125, 60, 16, 218, 142, 24, 161, 67, 244, 186, 169, 173, 162, 219, 155, 99, 220, 130, 237, 28, 180, 32, 178, 79, 215, 127, 232, 191, 118, 186, 48, 90, 126, 165, 189, 148, 78, 130, 203, 246, 164, 54, 35, 77, 24, 39, 219, 19, 191, 30, 53, 229, 74, 232, 93, 53, 24, 40, 168, 25, 141, 174, 32, 233, 255, 174, 25, 211, 137, 191, 51, 0, 11, 250, 20, 52, 219, 0, 247, 185, 138, 50, 227, 151, 132, 80, 251, 105, 225, 224, 30, 255, 35, 40, 192, 5, 38, 92, 18, 6, 83, 150, 70, 155, 248, 221, 213, 71, 113, 199, 9, 111, 103, 32, 42, 38, 193, 81, 158, 71, 74, 11, 183, 207, 52, 4, 220, 41, 148, 210, 126, 252, 192, 11, 2, 19, 77, 252, 220, 215, 170, 125, 146, 246, 195, 101, 82, 17, 92, 143, 243, 201, 174, 0, 141, 54, 4, 68, 175, 49, 248, 178, 81, 33, 192, 94, 244, 112, 179, 241, 175, 207, 152, 176, 122, 186, 53, 140, 79, 209, 208, 122, 97, 96, 107, 175, 140, 1, 231, 32, 241, 153, 117, 176, 173, 147, 218, 181, 128, 169, 108, 186, 164, 6, 199, 80, 44, 41, 47, 155, 239, 243, 161, 22, 70, 247, 156, 206, 107, 103, 147, 110, 87, 233, 4, 130, 198, 179, 167, 252, 145, 20, 81, 172, 179, 161, 84, 226, 139, 171, 247, 45, 9, 134, 118, 105, 9, 131, 83, 114, 54, 118, 16, 120, 130, 143, 160, 242, 130, 222, 92, 97, 185, 167, 50, 59, 59, 120, 127, 85, 137, 223, 41, 184, 229, 30, 99, 71, 41, 202, 11, 112, 115, 11, 69, 93, 148, 113, 116, 64, 42, 138, 109, 114, 60, 73, 212, 246, 124, 115, 240, 231, 146, 126, 15, 186, 108, 25, 198, 210, 38, 51, 68, 91, 160, 61, 92, 26, 174, 195, 15, 135, 70, 244, 151, 121, 3, 86, 168, 61, 162, 212, 95, 89, 182, 174, 207, 122, 30, 244, 157, 207, 198, 187, 5, 129, 58, 4, 143, 133, 199, 249, 28, 49, 89, 220, 253, 9, 250, 176, 192, 228, 168, 62, 146, 43, 249, 124, 233, 126, 7, 38, 28, 98, 151, 223, 75, 148, 116, 243, 33, 217, 48, 219, 29, 157, 53, 80, 12, 23, 245, 96, 55, 153, 47, 33, 63, 84, 231, 77, 229, 226, 104, 90, 247, 220, 116, 33, 109, 244, 165, 254, 137, 139, 217, 152, 246, 104, 101, 160, 69, 138, 129, 194, 151, 93, 203, 105, 204, 28, 224, 201, 199, 197, 148, 174, 97, 11, 84, 124, 208, 162, 249, 246, 129, 247, 146, 159, 12, 225, 5, 32, 101, 80, 181, 222, 29, 237, 7, 44, 89, 191, 159, 121, 137, 229, 51, 164, 57, 187, 132, 246, 200, 27, 163, 229, 127, 198, 211, 0, 95, 180, 205, 99, 48, 75, 79, 212, 198, 212, 157, 30, 17, 206, 202, 104, 74, 112, 86, 41, 57, 74, 82, 199, 27, 61, 61, 63, 64, 227, 6, 124, 226, 237, 61, 253, 51, 27, 179, 202, 2, 232, 221, 250, 26, 94, 42, 61, 94, 18, 52, 23, 185, 121, 16, 246, 142, 99, 57, 15, 129, 26, 161, 62, 235, 191, 135, 194, 200, 59, 169, 10, 238, 23, 189, 235, 199, 74, 236, 72, 39, 169]
加密后数据长度：640
解密后数据：[32, 32, 32, 32, 84, 104, 101, 32, 69, 86, 80, 32, 105, 110, 116, 101, 114, 102, 97, 99, 101, 32, 115, 117, 112, 112, 111, 114, 116, 115, 32, 116, 104, 101, 32, 97, 98, 105, 108, 105, 116, 121, 32, 116, 111, 32, 112, 101, 114, 102, 111, 114, 109, 32, 97, 117, 116, 104, 101, 110, 116, 105, 99, 97, 116, 101, 100, 32, 101, 110, 99, 114, 121, 112, 116, 105, 111, 110, 32, 97, 110, 100, 32, 100, 101, 99, 114, 121, 112, 116, 105, 111, 110, 44, 32, 10, 32, 32, 32, 32, 97, 115, 32, 119, 101, 108, 108, 32, 97, 115, 32, 116, 104, 101, 32, 111, 112, 116, 105, 111, 110, 32, 116, 111, 32, 97, 116, 116, 97, 99, 104, 32, 117, 110, 101, 110, 99, 114, 121, 112, 116, 101, 100, 44, 32, 97, 115, 115, 111, 99, 105, 97, 116, 101, 100, 32, 100, 97, 116, 97, 32, 116, 111, 32, 116, 104, 101, 32, 109, 101, 115, 115, 97, 103, 101, 46, 32, 10, 32, 32, 32, 32, 83, 117, 99, 104, 32, 65, 117, 116, 104, 101, 110, 116, 105, 99, 97, 116, 101, 100, 45, 69, 110, 99, 114, 121, 112, 116, 105, 111, 110, 32, 119, 105, 116, 104, 32, 65, 115, 115, 111, 99, 105, 97, 116, 101, 100, 45, 68, 97, 116, 97, 32, 40, 65, 69, 65, 68, 41, 32, 115, 99, 104, 101, 109, 101, 115, 32, 112, 114, 111, 118, 105, 100, 101, 32, 99, 111, 110, 102, 105, 100, 101, 110, 116, 105, 97, 108, 105, 116, 121, 32, 98, 121, 32, 101, 110, 99, 114, 121, 112, 116, 105, 110, 103, 32, 116, 104, 101, 32, 100, 97, 116, 97, 44, 32, 10, 32, 32, 32, 32, 97, 110, 100, 32, 97, 108, 115, 111, 32, 112, 114, 111, 118, 105, 100, 101, 32, 97, 117, 116, 104, 101, 110, 116, 105, 99, 105, 116, 121, 32, 97, 115, 115, 117, 114, 97, 110, 99, 101, 115, 32, 98, 121, 32, 99, 114, 101, 97, 116, 105, 110, 103, 32, 97, 32, 77, 65, 67, 32, 116, 97, 103, 32, 111, 118, 101, 114, 32, 116, 104, 101, 32, 101, 110, 99, 114, 121, 112, 116, 101, 100, 32, 100, 97, 116, 97, 46, 32, 10, 32, 32, 32, 32, 84, 104, 101, 32, 77, 65, 67, 32, 116, 97, 103, 32, 119, 105, 108, 108, 32, 101, 110, 115, 117, 114, 101, 32, 116, 104, 101, 32, 100, 97, 116, 97, 32, 105, 115, 32, 110, 111, 116, 32, 97, 99, 99, 105, 100, 101, 110, 116, 97, 108, 108, 121, 32, 97, 108, 116, 101, 114, 101, 100, 32, 111, 114, 32, 109, 97, 108, 105, 99, 105, 111, 117, 115, 108, 121, 32, 116, 97, 109, 112, 101, 114, 101, 100, 32, 100, 117, 114, 105, 110, 103, 32, 116, 114, 97, 110, 115, 109, 105, 115, 115, 105, 111, 110, 32, 97, 110, 100, 32, 115, 116, 111, 114, 97, 103, 101, 46, 10, 32, 32, 32, 32]
```


4. RSA 签名验证

```
import crypto4cj.rsacj.*
import crypto4cj.digestcj.*

main() {    
    let pri: Array<UInt8> =[
        48, 130, 2, 92, 2, 1, 0, 2, 129, 129, 0, 218, 135, 227, 194, 105, 61, 238, 229, 
        234, 42, 72, 144, 42, 250, 38, 137, 107, 132, 38, 111, 123, 19, 214, 35, 166, 15,
        82, 1, 93, 178, 157, 20, 189, 227, 165, 125, 207, 4, 88, 78, 162, 244, 165, 174,
        58, 66, 104, 218, 114, 253, 109, 148, 22, 91, 169, 128, 236, 149, 176, 92, 33, 
        156, 139, 135, 246, 245, 97, 102, 202, 77, 105, 31, 122, 116, 225, 208, 37, 178,
        3, 43, 37, 205, 18, 13, 100, 8, 174, 108, 7, 41, 199, 229, 147, 13, 178, 196, 
        8, 65, 106, 10, 183, 90, 244, 251, 220, 186, 169, 120, 28, 24, 246, 110, 142, 
        105, 46, 98, 32, 17, 129, 145, 210, 65, 249, 227, 33, 2, 27, 185, 2, 1, 3, 2, 
        129, 129, 0, 145, 175, 237, 44, 70, 41, 73, 238, 156, 28, 48, 96, 28, 166, 196,
        91, 157, 2, 196, 74, 82, 13, 57, 109, 25, 95, 140, 0, 233, 33, 190, 13, 211, 
        237, 24, 254, 138, 2, 229, 137, 193, 248, 110, 116, 38, 214, 240, 145, 161, 254, 
        73, 13, 100, 61, 27, 171, 72, 99, 202, 232, 22, 104, 93, 4, 19, 180, 157, 18, 
        228, 155, 153, 225, 246, 60, 235, 75, 187, 2, 2, 255, 115, 128, 28, 79, 78, 97, 
        199, 118, 59, 147, 156, 179, 156, 247, 100, 58, 113, 150, 54, 241, 47, 87, 167, 
        234, 125, 167, 98, 196, 209, 93, 194, 226, 158, 219, 159, 154, 222, 102, 166, 
        15, 188, 165, 153, 231, 45, 45, 87, 163, 2, 65, 0, 245, 208, 73, 78, 10, 130, 
        179, 5, 235, 9, 16, 72, 29, 166, 20, 75, 47, 253, 159, 231, 159, 246, 28, 211, 
        225, 230, 35, 170, 47, 140, 56, 61, 32, 74, 122, 254, 129, 73, 180, 45, 166, 
        58, 224, 146, 11, 234, 172, 64, 116, 30, 137, 139, 220, 147, 150, 131, 11, 55, 
        129, 90, 133, 8, 122, 127, 2, 65, 0, 227, 150, 44, 124, 104, 225, 79, 70, 158, 
        16, 112, 150, 111, 136, 234, 96, 200, 143, 71, 174, 206, 127, 230, 102, 203, 
        230, 57, 45, 248, 14, 100, 47, 61, 149, 156, 162, 111, 13, 196, 238, 122, 4, 
        180, 190, 214, 33, 165, 218, 44, 1, 53, 109, 245, 227, 241, 247, 44, 18, 17, 
        173, 216, 53, 157, 199, 2, 65, 0, 163, 224, 48, 222, 177, 172, 119, 89, 71, 
        91, 96, 48, 19, 196, 13, 135, 117, 83, 191, 239, 191, 249, 104, 141, 65, 68, 
        23, 198, 202, 93, 122, 211, 106, 220, 81, 255, 0, 219, 205, 115, 196, 39, 64, 
        97, 93, 71, 29, 128, 77, 105, 177, 7, 232, 98, 100, 87, 92, 207, 171, 145, 174, 
        5, 166, 255, 2, 65, 0, 151, 185, 114, 253, 155, 64, 223, 132, 105, 96, 75, 14, 
        245, 5, 241, 149, 219, 10, 47, 201, 222, 255, 238, 239, 50, 153, 123, 115, 250, 
        180, 66, 202, 41, 14, 104, 108, 74, 9, 45, 244, 81, 88, 120, 127, 57, 107, 195, 
        230, 200, 0, 206, 73, 78, 151, 246, 164, 200, 12, 11, 201, 58, 206, 105, 47, 2, 
        64, 32, 24, 155, 16, 110, 103, 52, 8, 123, 44, 18, 132, 54, 25, 9, 146, 15, 185, 
        184, 118, 107, 124, 196, 24, 212, 51, 32, 166, 34, 207, 174, 172, 186, 221, 2, 
        120, 97, 18, 178, 75, 8, 195, 250, 60, 252, 152, 100, 136, 131, 145, 157, 197, 
        50, 152, 241, 65, 93, 124, 235, 239, 241, 122, 91, 114]

    let pub: Array<UInt8> = [
        48, 129, 135, 2, 129, 129, 0, 218, 135, 227, 194, 105, 61, 238, 229, 234,
        42, 72, 144, 42, 250, 38, 137, 107, 132, 38, 111, 123, 19, 214, 35, 166, 
        15, 82, 1, 93, 178, 157, 20, 189, 227, 165, 125, 207, 4, 88, 78, 162, 244,
        165, 174, 58, 66, 104, 218, 114, 253, 109, 148, 22, 91, 169, 128, 236, 149, 
        176, 92, 33, 156, 139, 135, 246, 245, 97, 102, 202, 77, 105, 31, 122, 116, 
        225, 208, 37, 178, 3, 43, 37, 205, 18, 13, 100, 8, 174, 108, 7, 41, 199, 
        229, 147, 13, 178, 196, 8, 65, 106, 10, 183, 90, 244, 251, 220, 186, 169,
        120, 28, 24, 246, 110, 142, 105, 46, 98, 32, 17, 129, 145, 210, 65, 249, 
        227, 33, 2, 27, 185, 2, 1, 3
    ]
    var prik: RSAPrivateKey = RSA.setPrivateKey(pri)
    var pubk: RSAPublicKey = RSA.setPublicKey(pub)
    let datas: Array<UInt8> = "1.2.0:08:00:27:2c:88:08".toArray()
    let ret: Array<UInt8> = Digest.digest(DigestType.sha224, datas)
    let sigRet: Array<UInt8> = RSA.sign(DigestType.sha224, ret, prik)
    RSA.verify(DigestType.sha224, ret, sigRet, pubk)
    return 0
}
```

运行结果如下：

```
0
```

#### ECC 使用样例

##### SM2 加解密

```
import crypto4cj.eccj.*

main() {   
    var ecpri: ECPrivateKey = EC.generateKey(CurvesId.NID_sm2)
    let ecpubder: Array<UInt8> = ecpri.getPublicKeyDER()
    let ecpub: ECPublicKey = EC.setPublicKeyDER(CurvesId.NID_sm2, ecpubder)

    let data: Array<UInt8> = "hello world nihao cangjie".toArray()
    println("data: ${data}")

    let encrypt: Array<UInt8> = EC.encrypt(data, ecpub)
    println(": ${encrypt}")

    let decrypt: Array<UInt8> = EC.decrypt(encrypt, ecpri)
    println("decrypt: ${decrypt}")

    if(data == decrypt) {
        println("解密成功！")
    }

    return 0
}
```
运行结果如下：

```cangjie
data: [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 32, 110, 105, 104, 97, 111, 32, 99, 97, 110, 103, 106, 105, 101]
加密后数据: [48, 129, 129, 2, 32, 118, 218, 55, 121, 35, 31, 206, 12, 147, 57, 53, 48, 162, 46, 24, 243, 98, 166, 35, 240, 240, 58, 138, 172, 156, 201, 18, 222, 245, 153, 7, 174, 2, 32, 48, 162, 238, 195, 90, 166, 127, 76, 108, 232, 166, 254, 89, 110, 244, 38, 158, 143, 18, 101, 225, 61, 191, 253, 177, 10, 23, 123, 129, 232, 106, 242, 4, 32, 109, 109, 173, 116, 173, 76, 48, 207, 161, 218, 53, 198, 205, 225, 31, 177, 243, 136, 54, 88, 195, 97, 239, 182, 48, 57, 103, 135, 78, 102, 44, 102, 4, 25, 33, 104, 199, 147, 161, 247, 120, 2, 75, 42, 205, 125, 115, 35, 222, 82, 119, 99, 203, 163, 247, 188, 198, 52, 139, 0, 0]
解密后数据: [104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 32, 110, 105, 104, 97, 111, 32, 99, 97, 110, 103, 106, 105, 101]
解密成功！
```

##### ECDSA

```cangjie
import crypto4cj.eccj.*
import crypto4cj.digestcj.*

main() {    
    let rs: Array<UInt8> = [48, 119, 2, 1, 1, 4, 32, 47, 34, 136, 184, 2, 4, 84, 145, 114, 176, 159, 220, 130, 227, 228, 119, 250, 214, 149, 60, 177, 111, 74, 183, 149, 73, 30, 55, 147, 144, 169, 29, 160, 10, 6, 8, 42, 129, 28, 207, 85, 1, 130, 45, 161, 68, 3, 66, 0, 4, 151, 1, 176, 187, 1, 18, 218, 105, 56, 62, 24, 58, 51, 23, 162, 95, 93, 193, 14, 135, 1, 135, 214, 154, 226, 248, 253, 209, 13, 13, 154, 30, 151, 134, 40, 180, 69, 162, 125, 20, 1, 38, 232, 231, 235, 192, 36, 191, 182, 119, 121, 99, 128, 196, 162, 33, 51, 207, 142, 108, 69, 224, 148, 18]
    let us: Array<UInt8> = [4, 151, 1, 176, 187, 1, 18, 218, 105, 56, 62, 24, 58, 51, 23, 162, 95, 93, 193, 14, 135, 1, 135, 214, 154, 226, 248, 253, 209, 13, 13, 154, 30, 151, 134, 40, 180, 69, 162, 125, 20, 1, 38, 232, 231, 235, 192, 36, 191, 182, 119, 121, 99, 128, 196, 162, 33, 51, 207, 142, 108, 69, 224, 148, 18]

    let ecprib: ECPrivateKey = EC.setPrivateKeyDER(rs)
    let ecpub: ECPublicKey = EC.setPublicKeyDER(CurvesId.NID_sm2, us)
    
    let datas: Array<UInt8> =  Digest.digest(DigestType.sha1, "1.2.0:08:00:27:2c:88:08".toArray())
    let sigRet: Array<UInt8> = EC.sign(datas, ecprib)
    println("签名后数据：${sigRet}")
    EC.verify(datas, sigRet, ecpub)
    return 0
}
```
运行结果如下：

```cangjie
签名后数据：[48, 68, 2, 32, 94, 36, 183, 150, 205, 162, 158, 33, 199, 105, 188, 251, 61, 215, 112, 97, 188, 92, 241, 194, 57, 0, 191, 93, 231, 64, 159, 6, 243, 37, 77, 75, 2, 32, 90, 111, 65, 96, 150, 102, 1, 143, 183, 193, 95, 26, 82, 242, 128, 95, 78, 142, 207, 0, 35, 124, 185, 69, 80, 155, 26, 212, 15, 27, 166, 54]
```

##### ECDH

```cangjie
import crypto4cj.eccj.*
main() {    
    let rs1: Array<UInt8> = [48, 119, 2, 1, 1, 4, 32, 47, 34, 136, 184, 2, 4, 84, 145, 114, 176, 159, 220, 130, 227, 228, 119, 250, 214, 149, 60, 177, 111, 74, 183, 149, 73, 30, 55, 147, 144, 169, 29, 160, 10, 6, 8, 42, 129, 28, 207, 85, 1, 130, 45, 161, 68, 3, 66, 0, 4, 151, 1, 176, 187, 1, 18, 218, 105, 56, 62, 24, 58, 51, 23, 162, 95, 93, 193, 14, 135, 1, 135, 214, 154, 226, 248, 253, 209, 13, 13, 154, 30, 151, 134, 40, 180, 69, 162, 125, 20, 1, 38, 232, 231, 235, 192, 36, 191, 182, 119, 121, 99, 128, 196, 162, 33, 51, 207, 142, 108, 69, 224, 148, 18]
    let us1: Array<UInt8> = [4, 151, 1, 176, 187, 1, 18, 218, 105, 56, 62, 24, 58, 51, 23, 162, 95, 93, 193, 14, 135, 1, 135, 214, 154, 226, 248, 253, 209, 13, 13, 154, 30, 151, 134, 40, 180, 69, 162, 125, 20, 1, 38, 232, 231, 235, 192, 36, 191, 182, 119, 121, 99, 128, 196, 162, 33, 51, 207, 142, 108, 69, 224, 148, 18]
    let ecpri1: ECPrivateKey = EC.setPrivateKeyDER(rs1)
    let ecpub1: ECPublicKey = EC.setPublicKeyDER(CurvesId.NID_sm2, us1)
    
    let rs2: Array<UInt8> =  [48, 119, 2, 1, 1, 4, 32, 222, 16, 175, 14, 133, 224, 218, 80, 47, 165, 180, 179, 203, 30, 58, 47, 40, 116, 156, 240, 111, 119, 125, 127, 80, 221, 127, 173, 2, 105, 232, 14, 160, 10, 6, 8, 42, 129, 28, 207, 85, 1, 130, 45, 161, 68, 3, 66, 0, 4, 207, 103, 44, 129, 216, 79, 3, 166, 96, 237, 253, 62, 134, 117, 83, 88, 164, 179, 14, 204, 63, 88, 250, 250, 43, 185, 144, 107, 21, 81, 9, 6, 250, 3, 255, 38, 130, 166, 126, 186, 92, 90, 176, 203, 31, 192, 231, 221, 153, 208, 3, 66, 173, 76, 200, 191, 55, 86, 185, 184, 191, 162, 98, 25]
    let us2: Array<UInt8> = [4, 207, 103, 44, 129, 216, 79, 3, 166, 96, 237, 253, 62, 134, 117, 83, 88, 164, 179, 14, 204, 63, 88, 250, 250, 43, 185, 144, 107, 21, 81, 9, 6, 250, 3, 255, 38, 130, 166, 126, 186, 92, 90, 176, 203, 31, 192, 231, 221, 153, 208, 3, 66, 173, 76, 200, 191, 55, 86, 185, 184, 191, 162, 98, 25]
    let ecpri2: ECPrivateKey = EC.setPrivateKeyDER(rs2)
    let ecpub2: ECPublicKey = EC.setPublicKeyDER(CurvesId.NID_sm2, us2)
    
    let dhkey1: Array<UInt8> = EC.dhComputeKey(ecpri1, ecpub2)
    let dhkey2: Array<UInt8> = EC.dhComputeKey(ecpri2, ecpub1)
    println("dhkey1：${dhkey1}")
    println("dhkey2：${dhkey2}")

    return 0
}
```
运行结果如下：

```cangjie
dhkey1：[176, 206, 118, 73, 21, 118, 19, 97, 211, 87, 42, 145, 119, 90, 47, 194, 23, 248, 140, 133, 139, 163, 69, 78, 49, 61, 190, 49, 188, 218, 145, 78]
dhkey2：[176, 206, 118, 73, 21, 118, 19, 97, 211, 87, 42, 145, 119, 90, 47, 194, 23, 248, 140, 133, 139, 163, 69, 78, 49, 61, 190, 49, 188, 218, 145, 78]
```

#### 3DES 使用样例

```
import crypto4cj.symmetrycj.*
import encoding.hex.*

main() {   
    let input: Array<UInt8> = "hellowolrtyhjhyu".toArray()    
    let encryptData: Array<UInt8> = encrypt(DES.desEde3Cbc, input)
    let decryptData: Array<UInt8> = decrypt(DES.desEde3Cbc,encryptData) 
    println("---DES.desEde3Cbc---")
    println("原数据: ${input.toString()}") 
    println("加密后数据: ${encryptData.toString()}") 
    println("解密后数据: ${decryptData.toString()}") 
    println("加密后数据 hex:${toHexString(encryptData)}")
    return 0
}

public func encrypt(c: CIPHER, input: Array<UInt8>): Array<UInt8> {
    let key: Array<UInt8> = "012345670123456701234567".toArray()
    let iv: Array<UInt8> = "12345678".toArray()
    return  DES.encrypt(c, input, key, iv)    
}

public func decrypt(c: CIPHER, input: Array<UInt8>): Array<UInt8> {
    let key: Array<UInt8> = "012345670123456701234567".toArray()
    let iv: Array<UInt8> = "12345678".toArray()
    return  DES.decrypt(c, input, key, iv)   
}
```

执行结果:

```
---DES.desEde3Cbc---
原数据: [104, 101, 108, 108, 111, 119, 111, 108, 114, 116, 121, 104, 106, 104, 121, 117]
加密后数据: [91, 68, 112, 118, 226, 212, 143, 240, 80, 163, 215, 34, 229, 128, 106, 181, 103, 96, 135, 83, 53, 247, 89, 68]
解密后数据: [104, 101, 108, 108, 111, 119, 111, 108, 114, 116, 121, 104, 106, 104, 121, 117]
加密后数据 hex:5b447076e2d48ff050a3d722e5806ab56760875335f75944
```

#### SM4 使用样例

```
import crypto4cj.symmetrycj.*
import encoding.hex.*

main() {   
    let input: Array<UInt8> = "hellowolrtyhjhyu".toArray()    
    let encryptData: Array<UInt8> = encrypt(SM4.sm4Cbc, input)
    let decryptData: Array<UInt8> = decrypt(SM4.sm4Cbc,encryptData) 
    println("---SM4.sm4Cbc---")
    println("原数据: ${input.toString()}") 
    println("加密后数据: ${encryptData.toString()}") 
    println("解密后数据: ${decryptData.toString()}") 
    println("加密后数据 hex:${toHexString(encryptData)}")
    return 0
}

public func encrypt(c: CIPHER, input: Array<UInt8>): Array<UInt8> {
    let key: Array<UInt8> = "0123456701234567".toArray()
    let iv: Array<UInt8> = "1234567812345678".toArray()
    return  SM4.encrypt(c, input, key, iv)    
}

public func decrypt(c: CIPHER, input: Array<UInt8>): Array<UInt8> {
    let key: Array<UInt8> = "0123456701234567".toArray()
    let iv: Array<UInt8> = "1234567812345678".toArray()
    return  SM4.decrypt(c, input, key, iv)   
}
```

执行结果:

```
---SM4.sm4Cbc---
原数据: [104, 101, 108, 108, 111, 119, 111, 108, 114, 116, 121, 104, 106, 104, 121, 117]
加密后数据: [168, 44, 163, 211, 249, 104, 5, 67, 99, 179, 252, 68, 168, 233, 45, 247, 215, 54, 83, 245, 236, 12, 94, 12, 218, 66, 162, 29, 128, 102, 51, 234]
解密后数据: [104, 101, 108, 108, 111, 119, 111, 108, 114, 116, 121, 104, 106, 104, 121, 117]
加密后数据 hex:a82ca3d3f968054363b3fc44a8e92df7d73653f5ec0c5e0cda42a21d806633ea
```

#### Digest(sm3) 摘要算法使用样例

```
import crypto4cj.digestcj.*
import encoding.hex.*

main() {
    var str: Array<UInt8> = "helloworld".toArray()
    let res: Array<UInt8> = Digest.digest(DigestType.sm3, str)
    println(toHexString(res))
    return 0
}
```
执行结果:
```
c70c5f73da4e8b8b73478af54241469566f6497e16c053a03a0170fa00078283
```

## 约束与限制

在下述版本验证通过：

    Cangjie Version: 0.58.3

## 开源协议

本项目基于 [Apache License 2.0](./LICENSE)，请自由的享受和参与开源。

## 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。