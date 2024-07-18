// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_lastIndexOf_164 {
    //返回指定 other 最后一次出现的在原ByteString内的索引
    @TestCase 
    func okio_lastIndexOf_164(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteString2 = ByteString("d".toArray())
            var idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,10)

            byteString2 = ByteString("".toArray())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            // @Assert(idx,10) // 11

            byteString2 = ByteString("h".toArray())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("ll".toArray())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteString2 = ByteString("oo".toArray())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toArray())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}