// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from okio import nio.ByteBuffer
from std import socket.*

main () {
    var source: Buffer = Buffer()
    var sink: Buffer = Buffer()
    let hashingSink: HashingSink = HashingSink.md5(sink)
    source.writeUtf8("helloworld")
    hashingSink.writeMD5(source, 10)
    let a: String = hashingSink.hash()
    if(a != "fc5e038d38a57032085441e7fe7010b0") {
        return -1
    }
    return 0
}