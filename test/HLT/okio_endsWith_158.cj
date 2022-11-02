// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_endsWith_158 {

    @TestCase
    func okio_endsWith_158 (): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteString2 = ByteString("".toUtf8Array())
            var tf = byteString.endsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("d".toUtf8Array())
            tf = byteString.endsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("rld".toUtf8Array())
            tf = byteString.endsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("hello world".toUtf8Array())
            tf = byteString.endsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteString2 = ByteString("hel".toUtf8Array())
            tf = byteString.endsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,false)

            byteString2 = ByteString(" ".toUtf8Array())
            tf = byteString.endsWith(byteString2)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}