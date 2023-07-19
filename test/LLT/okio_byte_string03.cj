// DEPENDENCE: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import fs.*
from std import time.*

main () {
    var str = ByteString(Array<Byte>(15, {i => UInt8(i % 256)}))
    try {
        var str2 = str.substring(1,20)
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        var str3 = str.substring(2,5)
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        var str4 = str.substring(0,15)
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        var str41 = str.substring(5,2)
    } catch(e: Exception) {
        println("case pass")
    }
    let str5 = str.substring(1,6)
    let str6 = str.getByte(1)
    let str7 = str.size
    let str8 = str.toByteArray()
    let str9 = str.write("./a.txt")
    let fs = File("./a.txt",Open(true, false))
    try {
        let str10 = str.write(fs)
    } catch(e: Exception) {
        println("case pass")
    }
    var ess: String = ""
    try {
        var str1 = str.substring(-1,1)
    } catch(e: Exception) {
        ess = e.toString()
    }
    if (ess != "IllegalArgumentException: beginIndex < 0") {
        return 1
    }
    return 0
}
