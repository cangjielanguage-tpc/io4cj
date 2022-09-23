// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import sync.*
main () {
    let str = Timeout()
    let str1 = str.clearTimeout()
    try {
        let str2 = str.waitUntilNotified(Monitor())
    } catch(e: Exception) {
        println("case pass")
    }
    var es = ""
    try {
        let str3 = str.deadlineNanoTime()
    } catch(e: Exception) {
        es = e.toString()
    }
    if (es != "IllegalArgumentException: No deadline") {
        return 1
    }
    return 0
}
