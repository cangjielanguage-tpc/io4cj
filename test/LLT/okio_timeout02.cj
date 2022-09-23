// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import sync.*
main () {
    let str = Timeout()
    let str2 = str.clearTimeout()
    let str3 = str.clearDeadline()
    let str5 = str.deadlineNanoTime(1)
    let str6 = str.deadlineNanoTime(123)
    var es: String = ""
    try {
        let str1 = str.deadline(Duration.second(10),-1)
        let str4 = str.waitUntilNotified(Monitor())
    } catch(e: Exception) {
        es = e.toString()
    }
    var ess: String = ""
    try {
        let str7 = str.throwIfReached()
    } catch(e: Exception) {
        ess = e.toString()
        println(ess)
    }
    if (es != "IllegalArgumentException: duration <= 0: 10s") {
        return 1
    }
    if (ess != "Exception: deadline reached") {
        return 2
    }
    return 0
}
