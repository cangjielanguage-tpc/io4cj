// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import fs.*

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

    gsr.timeout()
    gsr.close()
    gsr.isClosed()
    gsr.toString()
    
    return 0
}

