// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_lastIndexOf_166 {

    @TestCase
    func okio_lastIndexOf_166(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray : Array<Byte> = "d".toUtf8Array()
            var idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,10)

            byteArray = "".toUtf8Array()
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            // @Assert(idx,10) // 11

            byteArray = ("h".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = ("ll".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteArray = ("oo".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = ("hello world".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}