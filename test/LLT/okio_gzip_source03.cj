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
    let str1 = gs.write(data,data.size)
    let result: Buffer = Buffer()

    let str = gs.deflaterSink.datas
    let inflated: Buffer = gunzip(str);
    return 0
}

public func gunzip(gzipped: Buffer):Buffer {
    let result: Buffer = Buffer()
    let source: GzipSource = GzipSource(gzipped);
    while (source.read(result, gzipped.size) != -1) {
    }
    return result
  } 