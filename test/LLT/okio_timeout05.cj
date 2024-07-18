// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.time.*
import std.sync.*
main () {
    let str = Timeout()
    let str1 = str.deadlineNanoTime(10)
    let str2 = str.timeout(20)
    var es = ""
    try {
        let str2 = str.waitUntilNotified(Monitor())
    } catch(e: Exception) {
        es = e.toString()
        println(es)
    }
    if (es != "Exception: interrupted") {
        return 1
    }
    return 0
}
