// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import std.time.*
import std.fs.*

main () {
    let pi: Pipe = Pipe(128)
    let pipeSink: BufferedSink = Okio.buffer(pi.sink())
    pipeSink.writeUtf8("hello")
    pipeSink.emit()

    let bu: Buffer = Buffer()
    pi.fold(bu)
    if("hello" != bu.readUtf8(5)){
        return 1
    }

    let pipe11: Pipe = Pipe(128)
    let bu22: Buffer = Buffer()
    try {
      pipe11.fold(bu22);
    } catch (expected: IllegalStateException ) {
    }

    try{
    let pi55: Pipe = Pipe(0)
    }catch(e: IllegalArgumentException){
    }

    return 0

}
