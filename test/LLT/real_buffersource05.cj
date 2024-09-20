// DEPENDENCE: test1.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import io4cj.*
import std.posix.*
import std.io.*
import std.fs.*

main () {
    let path: String = "${getcwd()}/test1.txt"
    var file = File(path, OpenMode.Read)
    var real0s = Okio.buffer(Okio.source(file))

     let sink1: Sink = Buffer()
    let bu1: Buffer = Buffer()
    let ss: String = "test readAll"
    bu1.writeUtf8(ss)
    //sink1.write(bu1 , 12)
    0
}