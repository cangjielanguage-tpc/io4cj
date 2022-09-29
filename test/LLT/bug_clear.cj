// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

main () {
    let buf = okio.Buffer()
    try {
        buf.clear()
    } catch (e: Exception) {
        return 1
    }
    if (buf.size != 0) {
        return 1
    }
    return 0
}