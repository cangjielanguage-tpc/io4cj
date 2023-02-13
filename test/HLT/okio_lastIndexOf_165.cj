// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_lastIndexOf_165 {

    @TestCase
    func okio_lastIndexOf_165(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteString2 = ByteString("l".toUtf8Array())
            var idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,9)

            byteString2 = ByteString("".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,12)
            println("idx : ${idx}")
            // @Assert(idx,10) 11

            byteString2 = ByteString("h".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("rld".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteString2 = ByteString("oo".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }

        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteString2 = ByteString("l".toUtf8Array())
            var idx = byteString.lastIndexOf(byteString2,5)
            println("idx : ${idx}")
            @Assert(idx,3)

            byteString = ByteString("hello world hello world".toUtf8Array())
            byteString2 = ByteString("l".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,20)
            println("idx : ${idx}")
            @Assert(idx,15)

            byteString2 = ByteString("".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            // @Assert(idx,11)

            byteString2 = ByteString("h".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("rld".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteString2 = ByteString("oo".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,22)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,15)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteString2 = ByteString("hello world".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2,-1)
            println("idx : ${idx}")
            @Assert(idx,-1)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}