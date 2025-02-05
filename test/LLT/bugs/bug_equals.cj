// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*


// issues/I5Y7RC

main () {
    let bs = ByteString("hello world".toArray())
    let bs2 = ByteString("hello world1".toArray())
    if (bs == bs2) {
        return 1
    }
    if (bs != bs2) {
        return 0
    }
    return 1
}