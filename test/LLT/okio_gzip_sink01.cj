// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from compress import zlib.*
from std import fs.*

main () {
    let data: Buffer = Buffer()
    let testString: String = "Test whether gzipsink can be compressed"
    data.writeUtf8(testString)
    let buffer: Buffer = Buffer()
    let gs: GzipSink = GzipSink(buffer) 
    //println(data.toString())
    let str1 = gs.write(data,data.size)
    let str3 = gs.timeout()
    //let str3 = gs.getDeflater()
    
    gs.close()
    gs.flush()
    gs.isClosed()
    gs.toString()

    let c: CRC32 = CRC32()
    c.reset()
    
}
