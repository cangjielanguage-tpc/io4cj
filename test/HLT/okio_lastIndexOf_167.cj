// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_lastIndexOf_167 {

    @TestCase
    func okio_lastIndexOf_167(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray : Array<Byte> = "l".toUtf8Array()
            var idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,9)

            byteArray = ("".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,12)
            println("idx : ${idx}")
            // @Assert(idx,10) 11

            byteArray = ("h".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = ("rld".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteArray = ("oo".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = ("hello world".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }

        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray = ("l".toUtf8Array())
            var idx = byteString.lastIndexOf(byteArray,5)
            println("idx : ${idx}")
            @Assert(idx,3)

            byteString = ByteString("hello world hello world".toUtf8Array())
            byteArray = ("l".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,20)
            println("idx : ${idx}")
            @Assert(idx,15)

            byteArray = ("".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            // @Assert(idx,11)

            byteArray = ("h".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = ("rld".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteArray = ("oo".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,22)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = ("hello world".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,15)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteArray = ("hello world".toUtf8Array())
            idx = byteString.lastIndexOf(byteArray,-1)
            println("idx : ${idx}")
            @Assert(idx,-1)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }
}