// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*

main () {
    let buf = Buffer()
    try {
        buf.clear()
    } catch (e: Exception) {
        return 1
    }
    if (buf.size != 0) {
        return 1
    }
    return 0
}