// DEPENDENCE: root_rsa.cer
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*

main () {
    var str = ByteString(Array<Byte>(1024, {i => UInt8(i % 256)}))
    let str1 = str.UTF8()
    let str2 = ByteString.encodeUtf8("ssfas")
    let str3 = str.UTF8()
    let str4 = str.hex()
    var srr = ByteArrayStream()
    srr.write(Array<Byte>(5, item: 0))
    let str8 = ByteString.read("./root_rsa.cer")
    let str9 = str.toAsciiLowercase()
    let str10 = str.toAsciiUppercase()
    let str11 = str.substring(1)
    try {
        let str7 = ByteString.read(srr,10)
        return 1
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        let str6 = ByteString.read(ByteArrayStream(),-1)
        return 1
    } catch(e: Exception) {
        println("case pass")
    }
    return 0
}
