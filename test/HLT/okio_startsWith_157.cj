// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_startsWith_157 {

    @TestCase
    func okio_startsWith_157(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray : Array<Byte> = "".toUtf8Array()
            var tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "h".toUtf8Array()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "hel".toUtf8Array()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "hello world".toUtf8Array()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "rld".toUtf8Array()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,false)

            byteArray = " ".toUtf8Array()
            tf = byteString.startsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}