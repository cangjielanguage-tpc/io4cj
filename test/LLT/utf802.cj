// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

main () {
    let str = Utf8()
    var es: String = ""
    try {
        let str1 = Utf8.size("abcdefghijklmn",2,1)
    } catch(e: Exception) {
        println(e.toString())
        es = e.toString()
    }
    if (es != "IllegalArgumentException: endIndex < beginIndex: 1 < 2") {
        return 1
    }
    return 0
}
