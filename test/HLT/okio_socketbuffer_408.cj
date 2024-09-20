// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.net.*
import std.time.*
import net.tls.*
import net.http.*
import io4cj.*


var SERVER_PORT: UInt16 = 33333

@Test
public class okio_socketbuffer_408 {

    @TestCase 
    // 返回一个使用过时的MD5哈希算法生成128位哈希的接收器。
    func okio_socketbuffer_408(): Unit {
        println("---------------------------okio_socketbuffer_408-----------------------------")
        try (serverSocket = TcpServerSocket(bindAt: SERVER_PORT)) {
            serverSocket.bind()
            spawn {
                clientSocket()
            }
            try (client = serverSocket.accept()) {
                var buf = Array<UInt8>(1024*105, repeat: 0)
                var str = SocketBuffer(client)
                var str1 = str.length
                let string1 = "hello"
                var arr: Array<Byte> = string1.toArray()
                var str2 = str.write(arr)
                var arr1 = Array<Byte>(5, repeat: 1)
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
        }
    }

    func clientSocket(): Unit {
        try (socket = TcpSocket("127.0.0.1", SERVER_PORT)) {
            socket.connect()
            let resp = "Hello from /red".toArray()
            socket.write(resp)
            let str: String = "foo-20000727"
            println(str)
        }
    }
    
}
 
