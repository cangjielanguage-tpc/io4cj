// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*

main () {
    try {
        let bug = Buffer ()
        bug.writeUtf8("华为\n中国")
        println(bug.readUtf8LineStrict())
    } catch (e: OverflowException) {
        return 1
    }
    return 0
}