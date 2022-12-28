// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import socket.*
from net import tls.*

main () {
    var ser = AsyncTimeout()
    let ss = ser.deadlineNanoTime(10)
    var ess = ""
    try {
        let str = ser.enter()
    } catch(e: Exception) {
        ess = e.toString()
    }
    let str1 = ser.exit()
    if(ess != "IllegalSynchronizationStateException: Mutex is not locked by current thread") {
        return 1
    }
    return 0
}
