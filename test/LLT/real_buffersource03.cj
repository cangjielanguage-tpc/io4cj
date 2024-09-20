// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.fs.*


main () {
    let path: String = "${getcwd()}/test.txt"
    var file = File(path, Open(true, false))
    var real0s = Okio.buffer(Okio.source(file))
    let str2 = real0s.indexOf(ByteString(Array<Byte>(5, repeat: 1)))
    let str3 = real0s.indexOf(ByteString(Array<Byte>(5, repeat: 1)),1)
    let str4 = real0s.indexOfElement(ByteString(Array<Byte>(5, repeat: 1)))
    let str5 = real0s.indexOfElement(ByteString(Array<Byte>(5, repeat: 1)),1)
    let str6 = real0s.rangeEquals(1,ByteString(Array<Byte>(5, repeat: 1)))
    let str7 = real0s.rangeEquals(1,ByteString(Array<Byte>(5, repeat: 1)),1,5)
    let str8 = real0s.peek()
    let str9 = real0s.toString()
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
