// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*

main () {
    var byteString = ByteString("hello world".toArray())
    if (byteString.hashCode() != 1923188771) {
        return 1
    }
    return 0
}