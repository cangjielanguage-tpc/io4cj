// DEPENDENCE: root_rsa.cer
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import socket.*
from net import tls.*

var port: UInt16 = 0
func clientSocket(): Unit {
    var server = Socket(TCP, "127.0.0.1", port)
    var buf: Array<UInt8> = Array<UInt8>(1024*106, item: 8)
    server.connect()
    server.write(buf)
    server.close()
}

main () {
    var server = SocketServer(TCP, port)
    port = server.port
    spawn {
        clientSocket()
    }
    var client = server.accept()
    var buf = Array<UInt8>(1024*105, item: 0)
    var cfg = TlsClientConfig("./root_rsa.cer")
    try {
        var client = TlsSocket(TCP, "127.0.0.1", 100, cfg)
        var ser = SocketBuffer(client)
    } catch(e: Exception) {
        println("case pass")
    }
    var str = SocketBuffer(client)
    var str1 = str.length
    var str2 = str.write(Array<Byte>(5, item: 1))
    var str3 = str.flush()
    var str4 = str.read(Array<Byte>(5, item: 1))
    var str5 = str.isClosed()
    var str6 = str.toString()
    var str7 = str.close()

    return 0
}
