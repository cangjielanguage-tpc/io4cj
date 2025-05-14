// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import stdx.compress.zlib.*
import std.fs.*

main () {
    let data: Buffer = Buffer()
    let testString: String = "Test whether gzipsink can be compressed"
    data.writeUtf8(testString)
    let buffer: Buffer = Buffer()
    let gs: GzipSink = GzipSink(buffer) 
    gs.write(data,data.size)
    gs.close()
    let result: Buffer = Buffer()
    let gsr: GzipSource = GzipSource(buffer)
    gsr.read(result , buffer.size)

    return 0
}

    