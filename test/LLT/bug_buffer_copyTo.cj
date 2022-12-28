// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

main () {
    var buffer = Buffer()
    buffer.write([6, 5, 4, 3, 2, 16, 7])
            .writeUtf8("华为")
            .writeUtf8("中国")
    
    var buffer2 = Buffer()
    let s = buffer.size
    println(buffer)
    buffer.copyTo(buffer2, 0, buffer.size)
    println(buffer)
    println(buffer2)
    if (s != buffer2.size) {
        return 1
    }
    return 0
}