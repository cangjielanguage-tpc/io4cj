// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

main () {
    let pi: Pipe = Pipe(100)
    let bu: Buffer = Buffer()
    let abcString: String = "abc"
    let abc: Array<UInt8> = abcString.toUtf8Array()
    pi.sink().write(bu.write(abc),3)
    pi.sink().flush()
    let pipeSource: BufferedSource = Okio.buffer(pi.source())
    if("abc" != pipeSource.readUtf8(3).getOrThrow()) {
        return 1
    }

    return 0

}
