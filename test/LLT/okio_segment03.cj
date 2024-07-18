// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.time.*

main () {
    let str = Segment(Array<UInt8>(8192, item: 0), 0, 8888, false, false)
    let strr = Segment(Array<UInt8>(8192, item: 0), 0, 8888, false, false)
    let strr1 = Segment(Array<UInt8>(8192, item: 0), 0, 8888, true, true)
    let strr2 = Segment(Array<UInt8>(8192, item: 0), 0, 8888, false, true)
    let strr3 = Segment(Array<UInt8>(8192, item: 0), 1000, 8192, false, true)
    var ess: String = ""
    try {
        let str1 = str.writeTo(strr,10)
    } catch(e: Exception) {
        ess = e.toString()
    }
    try {
        let str2 = str.writeTo(strr1,10)
    } catch(e: Exception) {
        println("case pass")
    }
    try {
        let str3 = str.writeTo(strr2,10)
    } catch(e: Exception) {
        println("case pass")
    }
    let str4 = str.writeTo(strr3,1)
    let str5 = str.push(strr)
    let str6 = str.pop()
    let str7 = str.push(str)
    let str8 = str.pop()
    if (ess != "IllegalArgumentException") {
        return 1
    }
    if (!(str != strr1)) {
        return 2
    }
    return 0
}
