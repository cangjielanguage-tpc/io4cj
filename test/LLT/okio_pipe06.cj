// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import std.time.*
import std.fs.*

main () {
    //foldingTwiceThrows
    let pi: Pipe = Pipe(128)
    let bu: Buffer = Buffer()
      pi.fold(bu)
    try {
      pi.fold(bu)
    } catch (expected: IllegalStateException) {
    }


    return 0
}