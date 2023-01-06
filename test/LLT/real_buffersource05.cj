// DEPENDENCE: test1.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from okio import nio.ByteBuffer
from std import os.posix.*
from std import io.*
from std import fs.*

main () {
    let path: String = "${getcwd()}/test1.txt"
    var file = File(path, Open(true, false))
    var real0s = Okio.buffer(Okio.source(file))
    real0s.read(ByteBuffer.allocate(0))

     let sink1: Sink = Buffer()
    let bu1: Buffer = Buffer()
    let ss: String = "test readAll"
    bu1.writeUtf8(ss)
    //sink1.write(bu1 , 12)
    let str5 = real0s.readAll(sink1)
    
}