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
    let str1 = gs.write(data,data.size)
    let str3 = gs.timeout()
    
    var es: String = ""
    try{
    gs.close()
    }catch(e: Exception){
        es = e.toString()
    }
    let bu3: Buffer = Buffer()
    let ds: DeflaterSink = DeflaterSink(bu3)
    try{
        let ds1 = ds.isClosed()
    }catch(e: Exception){
        println(e.toString())
    }
    return 0

}
