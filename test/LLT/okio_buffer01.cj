// DEPENDENCE: a.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.fs.*
import std.time.*
import io4cj.*

main () {
    var str = Buffer()
    var str1 = str.getBuffer()
    var str2 = str.write(Array<Byte>())
    var str3 = str.write(Array<Byte>(5, item: 1),1,2)
    var str5 = str.writeUtf8CodePoint(2047)
    var str6 = str.writeUtf8CodePoint(65535)
    var str7 = str.writeUtf8CodePoint(55298)
    var str8 = str.writeUtf8CodePoint(57345)
    var str9 = str.writeUtf8CodePoint(1114111)
    var str11 = str.flush()
    var str12 = str.emit()
    var str122 = str.readUtf8CodePoint()
    try {
        var str13 = str.require(111411)
    } catch(e: Exception) {
        println("case pass")
    }
    var str14 = str.request(110)
    var str15 = str.readInt16Le()
    try {
        var str16 = str.readInt32Le()
        var str17 = str.readInt64Le()
        var str18 = str.readDecimalInt64()
        var str19 = str.readHexadecimalUInt64()
        var str20 = str.readByteString(10)
    } catch(e: Exception) {
        println("case pass")
    }
    var str21 = str.read(Array<Byte>())
    var str23 = str.read(Array<Byte>(5, item: 1),1,4)
    var str24 = str.read(Buffer(),1)
    var str26 = str.read(Buffer(),111411666)
    try {
        var str25 = str.read(Buffer(),-1)
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        var str10 = str.writeUtf8CodePoint(1114116)
    } catch(e: Exception) {
        println("case pass")
    }
    let file = File("./a.txt", Open(true, false))
    let bufferedSource = Okio.source(file)
    var ess: String = ""
    try {
        var str4 = str.write(bufferedSource,3)
    } catch(e: Exception) {
        ess = e.toString()
    }
    if (ess.contains("EOFException")) {
        return 0
    }
    return 1
}
