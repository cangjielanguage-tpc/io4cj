// DEPENDENCE: root_rsa.cer
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from okio import okio.*
from std import os.posix.*
from std import io.*
from std import fs.*
from std import time.*
from std import socket.*
from net import tls.*

let a = "abcdefghijklmn "
let b = "中国 "
let c = "1234"
main () {
    var server = Socket(TCP, "127.0.0.1", 100)
    var cfg = TlsClientConfig("./root_rsa.cer")
    try {
        var client = TlsSocket(TCP, "127.0.0.1", 100, cfg)
    } catch(e: Exception) {
        println("case pass")
    }
    let str1 = Okio.sink(server)
    let str2 = Okio.source(server)
    str2.isClosed()
    let path: String = "${getcwd()}/test.txt"
    var file = File(path, CreateOrAppend)
    Okio.buffer(Okio.sink(file))
        .writeUtf8("${a}\n")
        .writeUtf8("${b}\n")
        .writeUtf8(c)
        .close()
    file = File(path, Open(true,false))
    file = File(path, Open(true,false))
    let bufferedSource = Okio.buffer(Okio.source(file))
    
    bufferedSource.close()
    bufferedSource.timeout()
    bufferedSource.isClosed()
    str1.timeout()
    let str5 = str1.isClosed()
    if (str5) {
        return 2
    }
    return 0
}
