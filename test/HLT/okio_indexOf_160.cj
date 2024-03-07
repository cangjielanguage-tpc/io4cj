// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_indexOf_160 {
    //返回指定 other 第一次出现的在原字符串的起始索引
    @TestCase 
    func okio_indexOf_160(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toArray())
            var byteString2 = ByteString("l".toArray())
            var idx = byteString.indexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteString2 = ByteString("d".toArray())
            idx = byteString.indexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,10)

            byteString2 = ByteString("".toArray())
            idx = byteString.indexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("h".toArray())
            idx = byteString.indexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("rld".toArray())
            idx = byteString.indexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,8)

            byteString2 = ByteString("oo".toArray())
            idx = byteString.indexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toArray())
            idx = byteString.indexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,0)

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}