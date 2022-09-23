// DEPENDENCE: test.txt
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*


main () {
    let path: String = "${getcwd()}/test.txt"
    var file = File(path, Read, Open)
    var real0s = Okio.buffer(Okio.source(file))
    real0s.readUtf8CodePoint()
    var es: String = ""
    try {
        let str0 = real0s.readDecimalInt64()
    } catch(e: Exception) {
        es = e.toString()
    }
    real0s.readHexadecimalUInt64()
    if (es != "Exception") {
        return 1
    }
    return 0
}
