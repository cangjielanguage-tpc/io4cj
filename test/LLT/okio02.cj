// DEPENDENCE: root_rsa.cer
// DEPENDENCE: private_key.pem
// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from io4cj import okio.*
from std import os.posix.*
from std import io.*
from std import time.*
from std import socket.*
from net import tls.*

main () {
    var cfg = TlsClientConfig("./root_rsa.cer")
    var client = TlsSocket(TCP, "www.baidu.com", 443, cfg)
    let str1 = Okio.sink(client)
    let str2 = Okio.source(client)
    var server = Socket(TCP, "127.0.0.1", 100)
    let str11 = Okio.sink(server)
    let str5 = str11.isClosed()
    //let str6 = str11.toString()
    let str7 = str11.flush()
    if(str5) {
        return 1
    }
    return 0
}
