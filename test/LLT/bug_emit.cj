// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*

main () {
    let b0 = okio.Buffer()
    let b1: BufferedSink = Okio.buffer(b0)
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
    return 0
}