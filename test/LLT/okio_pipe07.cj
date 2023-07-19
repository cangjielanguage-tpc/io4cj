// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

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