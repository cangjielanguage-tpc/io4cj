// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*

main () {
    let b0 = okio.Buffer()
    let b1: BufferedSink = Okio.buffer(b0)
    let c1: BufferedSource = Okio.buffer(b0)
    let b2: BufferedSink = Okio.buffer(b1)
    b2.writeUtf8("hello")
    if(b2.buffer().size != 5) {
        return 1
    }
    if(b1.buffer().size != 0) {
        return 1
    }
    if(b0.buffer().size != 0) {
        return 1
    }
    b2.emit()

    if(b2.buffer().size != 0) {
        return 1
    }
    if(b1.buffer().size != 5) {
        return 1
    }
    if(b0.buffer().size != 0) {
        return 1
    }
    b1.emit()
    
    if(b2.buffer().size != 0) {
        return 1
    }
    if(b1.buffer().size != 0) {
        return 1
    }
    if(b0.buffer().size != 5) {
        return 1
    }
    c1.read(Buffer(),5)
    try {
        let str1 = c1.close()
    } catch(e: Exception) {
        println("PASS")
    }
    try {
        let str3 = c1.exhausted()
    } catch(e: Exception) {
        println("PASS")
    }
    try {
        let str4 = c1.request(10)
    } catch(e: Exception) {
        println("PASS")
    }
    var ess: String = ""
    try {
        let str2 = c1.read(Buffer(),5)
    } catch(e: Exception) {
        ess = e.toString()
    }
    if (ess != "IllegalArgumentException: closed") {
        return 2
    }
    return 0
}