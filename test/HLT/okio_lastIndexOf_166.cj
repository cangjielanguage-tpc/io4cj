// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_lastIndexOf_166 {

    @TestCase
    func okio_lastIndexOf_166(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteArray : Array<Byte> = "d".toArray()
            var idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,10)

            byteArray = "".toArray()
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            // @Assert(idx,10) // 11

            byteArray = ("h".toArray())
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = ("ll".toArray())
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteArray = ("oo".toArray())
            idx = byteString.lastIndexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = ("hello world".toArray())
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