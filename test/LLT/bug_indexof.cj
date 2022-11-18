// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

main () {
    var byteString = ByteString("hello world".toUtf8Array())
    var byteString2 = ByteString("rld".toUtf8Array()) //
    var idx = byteString.indexOf(byteString2)
    if (idx != 8) {
        return 1
    }
    return 0
}