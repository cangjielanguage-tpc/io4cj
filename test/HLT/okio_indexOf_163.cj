// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_indexOf_163 {

    @TestCase
    func okio_indexOf_163(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteArray : Array<Byte> = "l".toArray()
            var idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteArray = "".toArray()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = "h".toArray()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = "rld".toArray()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteArray = "oo".toArray()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = "hello world".toArray()
            idx = byteString.indexOf(byteArray,0)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }

        try {
            var byteString = ByteString("hello world".toArray())
            var byteArray : Array<Byte> = "l".toArray()
            var idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString = ByteString("hello world hello world".toArray())
            byteArray = "l".toArray()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,14)

            byteArray = "".toArray()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,11)

            byteArray = "h".toArray()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteArray = "rld".toArray()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,20)

            byteArray = "oo".toArray()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = "hello world".toArray()
            idx = byteString.indexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteArray = "hello world".toArray()
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