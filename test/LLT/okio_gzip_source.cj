// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
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
    let str1 = gs.write(data,data.size)
    let result: Buffer = Buffer()
    let str = gs.deflaterSink.datas

    let gsr: GzipSource = GzipSource(str)
    gsr.read(result , 0x7fffffff)

    gsr.timeout()
    gsr.close()
    gsr.isClosed()
    gsr.toString()
    
    return 0
}

