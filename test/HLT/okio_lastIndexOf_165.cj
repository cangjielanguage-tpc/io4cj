// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_lastIndexOf_165 {

    @TestCase
    func okio_lastIndexOf_165(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteString2 = ByteString("l".toArray())
            var idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,9)

            byteString2 = ByteString("".toArray())
            idx = byteString.lastIndexOf(byteString2,12)
            println("idx : ${idx}")
            // @Assert(idx,10) 11

            byteString2 = ByteString("h".toArray())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("rld".toArray())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteString2 = ByteString("oo".toArray())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toArray())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }

        try {
            var byteString = ByteString("hello world".toArray())
            var byteString2 = ByteString("l".toArray())
            var idx = byteString.lastIndexOf(byteString2,5)
            println("idx : ${idx}")
            @Assert(idx,3)

            byteString = ByteString("hello world hello world".toArray())
            byteString2 = ByteString("l".toArray())
            idx = byteString.lastIndexOf(byteString2,20)
            println("idx : ${idx}")
            @Assert(idx,15)

            byteString2 = ByteString("".toArray())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            // @Assert(idx,11)

            byteString2 = ByteString("h".toArray())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("rld".toArray())
            idx = byteString.lastIndexOf(byteString2,11)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteString2 = ByteString("oo".toArray())
            idx = byteString.lastIndexOf(byteString2,22)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toArray())
            idx = byteString.lastIndexOf(byteString2,15)
            println("idx : ${idx}")
            @Assert(idx,12)

            byteString2 = ByteString("hello world".toArray())
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