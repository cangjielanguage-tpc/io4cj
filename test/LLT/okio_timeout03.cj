// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import sync.*
main () {
    let strr = Buffer()
    let str1 = strr.timeout()
    str1.timeout(1)
    str1.deadlineNanoTime(2)
    str1.throwIfReached()
    let str = Timeout()
    let str2 = str.deadlineNanoTime(1)
    let str3 = str.clearTimeout()
    var es: String = ""
    try {
        let str4 = str.waitUntilNotified(Monitor())
    } catch(e: Exception) {
        es = e.toString()
    }
    if (es != "Exception: interrupted") {
        return 1
    }
    return 0
}
