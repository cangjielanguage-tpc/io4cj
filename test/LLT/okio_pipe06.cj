// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

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