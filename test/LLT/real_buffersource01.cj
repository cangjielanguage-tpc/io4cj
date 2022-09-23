// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*


main () {
    let path: String = "${getcwd()}/test.txt"
    var file = File(path, Read, Open)
    var real0s = Okio.buffer(Okio.source(file))
    let str2 = real0s.getBuffer()
    try {
        let str3 = real0s.exhausted()
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str4 = real0s.request(10)
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str6 = real0s.readInt8()
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str7 = real0s.readByteString()
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str8 = real0s.readByteString(10)
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str9 = real0s.readByteArray()
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str10 = real0s.readByteArray(10)
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str11 = real0s.read(Array<Byte>(5, item: 1))
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str12 = real0s.readFully(Array<Byte>(5, item: 1))
    } catch(e: Exception) {
        println("pass")
    }
    try {
        let str5 = real0s.request(-1)
    } catch(e: Exception) {
        println("pass")
    }
    var es: String = ""
    try {
        let str1 = real0s.read(Buffer(), -1)
    } catch(e: Exception) {
        es = e.toString()
    }
    if (es != "IllegalArgumentException: byteCount <0: -1") {
        return 1
    }
    return 0
}
