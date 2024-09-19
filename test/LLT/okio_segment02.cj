// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.time.*

main () {
    let str = Segment(Array<UInt8>(8192, repeat: 0), 0, 8888, false, false)
    let strr = Segment()
    var ess: String = ""
    let str1 = str.split(1025)
    let str2 = str.split(102)
    try {
        let str3 = str.writeTo(strr,1)
        let str7 = str.split(-1)
    } catch(e: Exception) {
        ess = e.toString()
    }
    if (ess != "IllegalArgumentException") {
        return 1
    }
    return 0
}
