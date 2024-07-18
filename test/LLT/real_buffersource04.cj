// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import io4cj.*
import std.os.posix.*
import std.io.*
import std.fs.*


main () {
    let path: String = "${getcwd()}/test.txt"
    var file = File(path, Open(true, false))
    var real0s = Okio.buffer(Okio.source(file))
    real0s.readUtf8CodePoint()
    var es: String = ""
    try {
        let str0 = real0s.readDecimalInt64()
    } catch(e: Exception) {
        es = e.toString()
    }

    real0s.readHexadecimalUInt64()
    if (es.contains("NumberFormatException")) {
        return 0
    }
    let sink: Sink = Buffer()
    let str4 = real0s.readAll(sink)

    let sink1: Sink = Buffer()
    let bu1: Buffer = Buffer()
    let ss: String = "test readAll"
    bu1.writeUtf8(ss)
    sink1.write(bu1 , 12)
    let str5 = real0s.readAll(sink1)
    return 1
}
