// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj
// 3rd_party_lib:io4cj/build/okio
// 3rd_party_lib:io4cj/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_indexOf_163 {

    @TestCase
    func okio_indexOf_163(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray : Array<Byte> = "l".toUtf8Array()
            var idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteArray = "".toUtf8Array()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = "h".toUtf8Array()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = "rld".toUtf8Array()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteArray = "oo".toUtf8Array()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = "hello world".toUtf8Array()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }

        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteArray : Array<Byte> = "l".toUtf8Array()
            var idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString = ByteString("hello world hello world".toUtf8Array())
            byteArray = "l".toUtf8Array()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,14)

            byteArray = "".toUtf8Array()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,11)

            byteArray = "h".toUtf8Array()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteArray = "rld".toUtf8Array()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,20)

            byteArray = "oo".toUtf8Array()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = "hello world".toUtf8Array()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteArray = "hello world".toUtf8Array()
            idx = byteString.indexOf(byteArray,-1)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }
}