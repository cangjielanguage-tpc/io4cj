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
    try{
    let str1 = gs.write(data,-1)
    }catch(e: Exception){
        es = e.toString()
    }
    if (es != "IllegalArgumentException: byteCount < 0: -1") {
        return 1
    }
    let str3 = gs.timeout()
    //let str3 = gs.getDeflater()
    gs.close()
    gs.flush()
    
    return 0
}