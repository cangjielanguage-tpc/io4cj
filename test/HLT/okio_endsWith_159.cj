// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_endsWith_159 {

    @TestCase
    func okio_endsWith_159(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray : Array<Byte> = "".toUtf8Array()
            var tf = byteString.endsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "d".toUtf8Array()
            tf = byteString.endsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "rld".toUtf8Array()
            tf = byteString.endsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "hello world".toUtf8Array()
            tf = byteString.endsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,true)

            byteArray = "hel".toUtf8Array()
            tf = byteString.endsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,false)

            byteArray = " ".toUtf8Array()
            tf = byteString.endsWith(byteArray)
            println("true or false : ${tf}")
            @Assert(tf,false)
        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}