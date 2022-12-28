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
    var es:String = ""
    var es2:String = ""
    gs.closed = true
    try{

        try{
        let str1 = gs.write(data,-1)
        }catch(e: Exception){
            es2 = e.toString()
        }
    }catch(e1: ZlibException){
        es = e1.toString()
    }
    if (es2 != "IllegalArgumentException: byteCount < 0: -1") {
        return 2
    }

    let str3 = gs.timeout()
    gs.close()
    gs.flush()
    
    return 0
}