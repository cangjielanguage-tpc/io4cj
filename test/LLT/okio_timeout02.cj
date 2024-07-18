// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.time.*
import std.sync.*
main () {
    let str = Timeout()
    let str2 = str.clearTimeout()
    let str3 = str.clearDeadline()
    let str5 = str.deadlineNanoTime(1)
    let str6 = str.deadlineNanoTime(123)
    var es: String = ""
    try {
        let str1 = str.deadline(Duration.nanosecond*10,-1)
        let str4 = str.waitUntilNotified(Monitor())
    } catch(e: Exception) {
        var ess: String = ""
        try {
            let str7 = str.throwIfReached()
        } catch(e: Exception) {
            return 0
        }
    }
    return 1
}
