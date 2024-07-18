// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.time.*

main () {
    let str = Timeout()
    let str1 = str.timeout(1)
    let str2 = str.timeoutNanos()
    let str3 = str.hasDeadline()
    let str5 = str.deadlineNanoTime(1)
    let str6 = str.deadlineNanoTime()
    let str7 = str.deadline(Duration.nanosecond*10,1)
    var es: String = ""
    try {
        let str22 = str.timeout(-1)
    } catch(e: Exception) {
        es = e.toString()
    }
    var es2: String = ""
    try {
        let str4 = str.deadlineNanoTime()
    } catch(e: Exception) {
        es2 = e.toString()
    }
    if (es != "IllegalArgumentException: timeout < 0: -1") {
        return 1
    }
    return 0
}
