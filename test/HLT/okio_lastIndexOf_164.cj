// 3rd_party_lib:okio/build/okio
// 3rd_party_lib:okio/ci_lib/cryptocj

from std import io.*
from std import time.*
from okio import okio.*

@Test
public class okio_lastIndexOf_164 {
    //返回指定 other 最后一次出现的在原ByteString内的索引
    @TestCase 
    func okio_lastIndexOf_164(): Unit {
        var exc = ""
        try {
            var byteString = ByteString("hello world".toUtf8Array())
            var byteString2 = ByteString("d".toUtf8Array())
            var idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,10)

            byteString2 = ByteString("".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            // @Assert(idx,10) // 11

            byteString2 = ByteString("h".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,0)

            byteString2 = ByteString("ll".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,2)

            byteString2 = ByteString("oo".toUtf8Array())
            idx = byteString.lastIndexOf(byteString2)
            println("idx : ${idx}")
            @Assert(idx,-1)

            byteString2 = ByteString("hello world".toUtf8Array())
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