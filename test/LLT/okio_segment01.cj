// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import std.time.*

main () {
    let str = Segment()
    let str1 = Segment()
    str.push(str1)
    var ess: String = ""
    try {
        let str7 = str.split(10)
    } catch(e: Exception) {
        ess = e.toString()
        println(ess)
    }

    str.compact()
    str.writeTo(str1,5)
    if (str == str1) {
        return 1
    }
    if (ess != "IllegalArgumentException") {
        return 2
    }
    return 0
}
