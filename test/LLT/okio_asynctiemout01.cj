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
    let strr = Timeout()
    strr.timeout(10000000)
    let str = ser.enter()
    var sers = AsyncTimeout()
    let str2 = sers.enter()
    let str3 = sers.newTimeoutException(NoneValueException())
    let str4 = sers.newTimeoutException()
    var server = Socket(TCP, "127.0.0.1", 100)
    let strse = Okio.sink(server)
    let str6 = sers.sink(strse)
    let string1 = "123"
    let bu1 = Buffer()
    bu1.writeUtf8(string1)
    let str09 = sers.sink(bu1)
    let string2 = "123"
    let bu2 = Buffer()
    bu2.writeUtf8(string2)
    let str08 = sers.source(bu2)
    let str7 = sers.exit()
    try {
        let str8 = sers.awaitTimeout()
    } catch(e: Exception) {
        println("case pass")
    }
    if(!(sers != AsyncTimeout())) {
        return 1
    }
    if(sers == ser) {
        return 2
    }
    return 0
}
