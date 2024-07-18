// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*

main () {
    let str = Utf8()
    var es: String = ""
    try {
        let str1 = Utf8.size("aC",0,5)
    } catch(e: Exception) {
        println(e.toString())
        es = e.toString()
    }
    if (es != "IllegalArgumentException: endIndex > string.length: 5> 2") {
        return 1
    }
    return 0
}
