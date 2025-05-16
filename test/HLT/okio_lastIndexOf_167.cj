// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_lastIndexOf_167 {

    @TestCase
    func okio_lastIndexOf_167(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteArray : Array<Byte> = "l".toArray()
            var idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,9)

            byteArray = ("".toArray())
            idx = byteString.lastIndexOf(byteArray,12)
            println("idx : ${idx}")
            // @Assert(idx,10) 11

            byteArray = ("h".toArray())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = ("rld".toArray())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteArray = ("oo".toArray())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = ("hello world".toArray())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }

        try {
            var byteString = ByteString("hello world".toArray())
            var byteArray = ("l".toArray())
            var idx = byteString.lastIndexOf(byteArray,5)
            println("idx : ${idx}")
            @Assert(idx,3)

            byteString = ByteString("hello world hello world".toArray())
            byteArray = ("l".toArray())
            idx = byteString.lastIndexOf(byteArray,20)
            println("idx : ${idx}")
            @Assert(idx,15)

            byteArray = ("".toArray())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            // @Assert(idx,11)

            byteArray = ("h".toArray())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = ("rld".toArray())
            idx = byteString.lastIndexOf(byteArray,11)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteArray = ("oo".toArray())
            idx = byteString.lastIndexOf(byteArray,22)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = ("hello world".toArray())
            idx = byteString.lastIndexOf(byteArray,15)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteArray = ("hello world".toArray())
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