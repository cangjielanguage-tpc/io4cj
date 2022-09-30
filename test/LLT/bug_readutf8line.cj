// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

main () {
    try {
        let bug = okio.Buffer ()
        bug.writeUtf8("华为\n中国")
        println(bug.readUtf8LineStrict())
    } catch (e: OverflowException) {
        return 1
    }
    return 0
}