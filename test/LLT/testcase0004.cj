// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import io4cj.*
import std.posix.*
import std.io.*
import std.fs.*

let a = "abcdefghijklmn "
let b = "中国 "
let c = "1234"

main () {
    let path: String = "${getcwd()}/test.txt"

    var file = File(path, OpenMode.Append)
    
    Okio.buffer(Okio.sink(file))
        .writeUtf8("${a}\n")
        .writeUtf8("${b}\n")
        .writeUtf8(c)
        .close()

    file = File(path, OpenMode.Read)
    let bufferedSource = Okio.buffer(Okio.source(file))
    if (bufferedSource.readUtf8Line() != a) {
        return 1
    }
    if (bufferedSource.readUtf8Line() != b) {
        return 1
    }
    if (bufferedSource.readUtf8Line() != c) {
        return 1
    }
    return 0
}
