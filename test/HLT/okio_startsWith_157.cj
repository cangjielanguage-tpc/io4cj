// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

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