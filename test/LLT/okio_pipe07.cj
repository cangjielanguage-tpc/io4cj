// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import std.time.*
import std.fs.*

main () {

let pi2: Pipe = Pipe(100)
    let bu2: Buffer = Buffer()
    let bu3: Buffer = Buffer()
    pi2.fold(bu2)
    try {
      pi2.source().read(bu3, 1)

    } catch (expected: IllegalStateException) {
    }
    return 0
}