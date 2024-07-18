// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*

main () {
    let str = Utf8.size("abcdefghijklmn")
    var es: String = ""
    try {
        let str1 = Utf8.size("abcdefghijklmn",-1,1)
    } catch(e: Exception) {
        println(e.toString())
        es = e.toString()
    }
    if (es != "IllegalArgumentException: beginIndex < 0: -1.") {
        return 1
    }
    if (str != 14) {
        return 2
    }
    return 0
}
