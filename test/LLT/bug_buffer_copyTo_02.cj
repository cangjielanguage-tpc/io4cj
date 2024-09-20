// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*

main () {
    var buffer = Buffer()
    buffer.write([6, 5, 4, 3, 2, 16, 7])
            .writeUtf8("华为")
            .writeUtf8("中国")
    
    var buffer2 = Buffer()
    var buffer3 = Buffer()
    let s = buffer.size
    // buffer.copyTo(buffer2, 0, buffer.size)
    
    buffer.copyTo(buffer3, 0, buffer.size)
    buffer.writeUtf8("目标")
    //
    buffer.copyTo(buffer2, 0, buffer.size)
    if  (buffer2.toString() != "[size=25] [6, 5, 4, 3, 2, 16, 7, 229, 141, 142, 228, 184, 186, 228, 184, 173, 229, 155, 189, 231, 155, 174, 230, 160, 135]") {
        return 1
    }
    return 0
}