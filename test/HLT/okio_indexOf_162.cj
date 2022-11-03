// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_162 {

    @TestCase
    func okio_indexOf_162(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray : Array<Byte> = "l".toUtf8Array()
            var idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteArray = "".toUtf8Array()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = "h".toUtf8Array()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = "rld".toUtf8Array()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteArray = "oo".toUtf8Array()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = "hello world".toUtf8Array()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}