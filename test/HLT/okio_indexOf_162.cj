// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

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