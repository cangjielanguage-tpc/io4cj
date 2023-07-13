// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from std import socket.*
from net import tls.*
from net import http.*
from okio import okio.*

@Test
public class okio_socketbuffer_408 {

    @TestCase 
    // 返回一个使用过时的MD5哈希算法生成128位哈希的接收器。
    func okio_socketbuffer_408(): Unit {

        println("---------------------------okio_socketbuffer_408-----------------------------")
        var port: UInt16 = 0
        var server = SocketServer(TCP, 8086)
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
        let string1 = "hello"
        var arr: Array<Byte> = string1.toUtf8Array()
        var str2 = str.write(arr)
        var arr1 = Array<Byte>(5, item: 1)
        var str4 = str.read(arr1)
        var exc = ""
        try{
        var str3 = str.flush()
        }catch(e: Exception){
            exc = e.message
        }
        @Assert(exc , "" )

        var exc1 = ""
        try{
        var str5 = str.isClosed()
        }catch(e: Exception){
            exc1 = e.message
        }
        @Assert(exc1 , "" )

        var exc2 = ""
        try{
        var str7 = str.close()
        }catch(e: Exception){
            exc2 = e.message
        }
        @Assert(exc2 , "" )
        
        
         var str6 = str.toString()
         println(str.toString())
        @Assert(str4 , 5 )
      }

func clientSocket(): Unit {

    let hd = Route()
    hd.handle("/foo", { w, r =>
		let resp = "Hello from /red".toUtf8Array()
		w.write(resp)
		let str: String = "foo-20000727"
        println(str)
    })

    var server = Socket(TCP, "127.0.0.1", 8086)
    var buf: Array<UInt8> = Array<UInt8>(1024*106, item: 8)
    server.connect()
    server.write(buf)
    server.close()
}
    
}

 
