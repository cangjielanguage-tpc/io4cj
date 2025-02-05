// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import std.time.*
import std.fs.*

main () {
    let pi: Pipe = Pipe(100)
    let bu: Buffer = Buffer()
    let abcString: String = "abc"
    let abc: Array<UInt8> = abcString.toArray()
    pi.sink().write(bu.write(abc),3)
    pi.sink().flush()
    let pipeSource: BufferedSource = Okio.buffer(pi.source())
    if("abc" != pipeSource.readUtf8(3)) {
        return 1
    }


    let pi6: Pipe = Pipe(128)
    let ps6: BufferedSink = Okio.buffer(pi6.sink())
    ps6.writeUtf8("world")
    ps6.close()
    let bu6: Buffer = Buffer()
    pi6.fold(bu6)
    if("world" != bu6.readUtf8(5)){
        return 1
    }

    return 0

}
