// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_161 {

    @TestCase
    func okio_indexOf_161(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteString2 = ByteString("l".toUtf8Array())
            var idx = byteString.indexOf(byteString2,0)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteString2 = ByteString("".toUtf8Array())
            idx = byteString.indexOf(byteString2,0)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("h".toUtf8Array())
            idx = byteString.indexOf(byteString2,0)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("rld".toUtf8Array())
            idx = byteString.indexOf(byteString2,0)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteString2 = ByteString("oo".toUtf8Array())
            idx = byteString.indexOf(byteString2,0)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toUtf8Array())
            idx = byteString.indexOf(byteString2,0)
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
            var idx = byteString.indexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString = ByteString("hello world hello world".toUtf8Array())
            byteString2 = ByteString("l".toUtf8Array())
            idx = byteString.indexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,14)

            byteString2 = ByteString("".toUtf8Array())
            idx = byteString.indexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,11)

            byteString2 = ByteString("h".toUtf8Array())
            idx = byteString.indexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteString2 = ByteString("rld".toUtf8Array())
            idx = byteString.indexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,20)

            byteString2 = ByteString("oo".toUtf8Array())
            idx = byteString.indexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toUtf8Array())
            idx = byteString.indexOf(byteString2,5)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteString2 = ByteString("hello world".toUtf8Array())
            idx = byteString.indexOf(byteString2,-1)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}