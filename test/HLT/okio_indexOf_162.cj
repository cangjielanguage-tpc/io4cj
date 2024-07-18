// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_indexOf_162 {

    @TestCase
    func okio_indexOf_162(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteArray : Array<Byte> = "l".toArray()
            var idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteArray = "".toArray()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = "h".toArray()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteArray = "rld".toArray()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteArray = "oo".toArray()
            idx = byteString.indexOf(byteArray)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteArray = "hello world".toArray()
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