// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_startsWith_156 {

    @TestCase
    func okio_startsWith_156(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteString2 = ByteString("".toArray())
            var tf = byteString.startsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("h".toArray())
            tf = byteString.startsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("hel".toArray())
            tf = byteString.startsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("hello world".toArray())
            tf = byteString.startsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("rld".toArray())
            tf = byteString.startsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,false)

            byteString2 = ByteString(" ".toArray())
            tf = byteString.startsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}