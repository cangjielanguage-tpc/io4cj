// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*

main () {
    var byteString = ByteString("hello world".toArray())
    if (byteString.hashCode() != 1923188771) {
        return 1
    }
    return 0
}