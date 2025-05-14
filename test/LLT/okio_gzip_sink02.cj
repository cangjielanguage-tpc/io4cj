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

    let data1: Buffer = Buffer()
    let testString1: String = ""
    data1.writeUtf8(testString1)
     try{
        try{
        let str2 = gs.write(data1,0)
        }catch(e2: Exception){
        }
    }catch(e3: ZlibException){
    }
    if (es2 != "IllegalArgumentException: byteCount < 0: -1") {
        return 2
    }

    let str3 = gs.timeout()
    gs.close()
    gs.flush()
    
    return 0
}