// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*

main () {
    var byteString = ByteString("hello world".toArray())
    var byteString2 = ByteString("rld".toArray()) //
    var idx = byteString.indexOf(byteString2)
    if (idx != 8) {
        return 1
    }
    return 0
}