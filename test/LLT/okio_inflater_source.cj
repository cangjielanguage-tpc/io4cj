// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import compress.zlib.*
import std.fs.*

main () {
    let data: Buffer = Buffer()
    let testString: String = "Test whether gzipsink can be compressed"
    data.writeUtf8(testString)
    let inflaterSource: InflaterSource = InflaterSource(data)
    inflaterSource.toString()
    try{
        let is1 = inflaterSource.isClosed()
    }catch(e: Exception){
        println(e.toString())
    }
    inflaterSource.timeout()
    return 0
}