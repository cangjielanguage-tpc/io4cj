// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*

main () {
    var str = ByteString(Array<Byte>())
    var arr: Array<Byte> = Array<Byte>(1024, {i => UInt8(i % 256)})
    let str1 = str.UTF8()
    let str2 = ByteString.encodeUtf8("ssfas")
    let str3 = str.UTF8()
    let str4 = str.base64()
    let str5 = ByteString.decodeBase64("ssfas")
    var ess: String = ""
    try {
        let str6 = ByteString.decodeHex("ssfas")
        let str10 = ByteString.read(ByteArrayStream(),5)
        let str12 = ByteString.read("pip")
    } catch(e: Exception) {
        ess = e.toString()
    }
    let str7 = str.hex()
    let str11 = ByteString.read(ByteArrayStream(),0)
    if (ess != "IllegalArgumentException: Unexpected hex string: ssfas") {
        return 1
    }
    var arr112: Array<Byte> = Array<Byte>(1024, {i => UInt8(i % 256)})
    let str112 = ByteString.of(arr112)
    let str113 = ByteString.of(arr112,0,arr112.size)
    return 0
}
