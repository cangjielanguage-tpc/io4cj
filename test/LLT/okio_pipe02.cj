// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

main () {
    let pi: Pipe = Pipe(128)

    let pipeSink: BufferedSink = Okio.buffer(pi.sink())
    pipeSink.writeUtf8("hello")
    pipeSink.emit()

    let pipeSource: BufferedSource = Okio.buffer(pi.source())
    if("hello" != pipeSource.readUtf8(5).getOrThrow()) {
        return 1
    }

    let fsBuffer: Buffer = Buffer()
    
    pi.fold(fsBuffer)
    pipeSink.writeUtf8("world")

    pipeSink.emit()
    if("world" != fsBuffer.readUtf8(5).getOrThrow()) {
        return 1
    }

    try {
      pipeSource.readUtf8()
    } catch (expected: IllegalStateException) {
    }
    pipeSink.close()

    return 0
}