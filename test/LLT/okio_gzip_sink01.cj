// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.os.posix.*
import std.io.*
import compress.zlib.*
import std.fs.*

main () {
    let data: Buffer = Buffer()
    let testString: String = "Test whether gzipsink can be compressed"
    data.writeUtf8(testString)
    let buffer: Buffer = Buffer()
    let gs: GzipSink = GzipSink(buffer) 
    let str1 = gs.write(data,data.size)
    let str3 = gs.timeout()
    gs.flush()
    gs.close()
    gs.isClosed()
    println(gs.toString())
    gs.toString()
    return 0
}
