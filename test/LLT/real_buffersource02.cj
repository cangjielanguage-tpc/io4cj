// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from okio import nio.ByteBuffer
from std import os.posix.*
from std import io.*
from std import fs.*
from std import socket.*

main () {
    let path: String = "${getcwd()}/test.txt"
    var file = File(path, Open(true, false))
    var real0s = Okio.buffer(Okio.source(file))
    let str2 = real0s.readFully(Array<Byte>(5, item: 1))
    let str3 = real0s.read(ByteBuffer.allocate(10))
    try {
        let str4 = real0s.readFully(okio.Buffer(),5)
    } catch(e: Exception) {
        println("pass")
    }
    var server = Socket(TCP, "127.0.0.1", 100)
    let sin = Okio.sink(server)
    let str46 = real0s.readUtf8()
    let str6 = real0s.readString()
    let b0 = okio.Buffer()
    let b1: BufferedSink = Okio.buffer(b0)
    let c1: BufferedSource = Okio.buffer(b0)
    let b2: BufferedSink = Okio.buffer(b1)
    b2.writeUtf8("hello")
    b2.emit()
    b1.emit()
    let str7 = c1.readString(0)
    try {
       let str8 = real0s.readUtf8LineStrict()
    } catch(e: Exception) {
        println("pass")
    }
    try {
       let str9 = real0s.readUtf8LineStrict(10)
    } catch(e: Exception) {
    }
    try {
       let str10 = real0s.readUtf8CodePoint()
    } catch(e: Exception) {
    }
    try {
       let str11 = real0s.readInt16()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str11 = real0s.readInt16()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str12 = real0s.readInt16Le()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str13 = real0s.readInt32()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str14 = real0s.readInt32Le()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str15 = real0s.readInt64()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str16 = real0s.readInt64Le()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str17 = real0s.readDecimalInt64()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str18 = real0s.readHexadecimalUInt64()
    } catch(e: Exception) {
        print("ss")
    }
    try {
       let str19 = real0s.skip(10)
    } catch(e: Exception) {
        print("ss")
    }
    let str20 = real0s.indexOf(1,6)
    var es: String = ""
    try {
        let str1 = real0s.read(okio.Buffer(), -1)
    } catch(e: Exception) {
        es = e.toString()
    }
    if (es != "IllegalArgumentException: byteCount <0: -1") {
        return 1
    }
    return 0
}
