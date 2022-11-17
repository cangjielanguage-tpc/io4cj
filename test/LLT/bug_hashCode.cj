// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

main () {
    var byteString = ByteString("hello world".toUtf8Array())
    if (byteString.hashCode() != 1923188771) {
        return 1
    }
    return 0
}