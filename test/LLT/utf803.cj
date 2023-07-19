// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*

main () {
    let str = Utf8()
    var es: String = ""
    try {
        let str1 = Utf8.size("aC",0,5)
    } catch(e: Exception) {
        println(e.toString())
        es = e.toString()
    }
    if (es != "IllegalArgumentException: endIndex > string.length: 5> 2") {
        return 1
    }
    return 0
}
