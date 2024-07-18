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
    gs.write(data,data.size)
    gs.close()
    let result: Buffer = Buffer()
    let gsr: GzipSource = GzipSource(buffer)
    try{
    gsr.read(result , -1)
    } catch(e: IllegalArgumentException) {
    }

    let data1: Buffer = Buffer()
    let testString1: String = "Test whether gzipsink can be compressed"
    data1.writeUtf8(testString1)
    let buffer1: Buffer = Buffer()
    let gs1: GzipSink = GzipSink(buffer1) 
    gs1.write(data,data.size)
    gs1.close()
    let infla: Buffer = Buffer()
    let sou: InflaterSource = InflaterSource(buffer1)
    try{
    var sou1 = sou.read(infla , -1)
    } catch(e: IllegalArgumentException) {
    }

    //byteCount = 0
    let data2: Buffer = Buffer()
    let testString2: String = "Test whether gzipsink can be compressed"
    data2.writeUtf8(testString2)
    let buffer2: Buffer = Buffer()
    let gs2: GzipSink = GzipSink(buffer2) 
    gs2.write(data2,data2.size)
    gs2.close()
    let result2: Buffer = Buffer()
    let gsr2: GzipSource = GzipSource(buffer2)
    try{
    gsr2.read(result2 , 0)
    } catch(e: IllegalArgumentException) {
    }

    let data3: Buffer = Buffer()
    let testString3: String = "Test whether gzipsink can be compressed"
    data3.writeUtf8(testString3)
    let buffer3: Buffer = Buffer()
    let gs3: GzipSink = GzipSink(buffer3) 
    gs3.write(data3,data3.size)
    gs3.close()
    let infla3: Buffer = Buffer()
    let sou3: InflaterSource = InflaterSource(buffer3)
    try{
    var sou13 = sou3.read(infla3 , 0)
    } catch(e: IllegalArgumentException) {
    }

    //closed
    let data4: Buffer = Buffer()
    let testString4: String = "Test whether gzipsink can be compressed"
    data4.writeUtf8(testString4)
    let buffer4: Buffer = Buffer()
    let gs4: GzipSink = GzipSink(buffer4) 
    gs4.write(data4,data4.size)
    gs4.close()
    let infla4: Buffer = Buffer()
    let sou4: InflaterSource = InflaterSource(buffer4)
    try{
    var sou14 = sou4.read(infla4 , 0)
    sou4.close()
    } catch(e: IllegalStateException) {
    }
    return 0
}

    