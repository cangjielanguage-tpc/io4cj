// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_read_140 {

    @TestCase
    func okio_read_140(): Unit {
        var exc = ""
        try {
            var bAs = ByteArrayStream()
            var byteString = ByteString("hello world".toArray())
            byteString.write(bAs)
            var arrbyte = Array<Byte>(11, item: 0)
            bAs.read(arrbyte)
            println("bAs = ${String.fromUtf8(arrbyte)}")
            @Assert(String.fromUtf8(arrbyte),"hello world")

            var arrbyte2 = Array<Byte>(2, item: 0)
            var arr = Array<Byte>(2, item: 0)
            byteString = ByteString("".toArray())
            byteString.write(bAs)
            bAs.read(arrbyte2)
            println("bAs2 = ${arrbyte2}")
            @Assert(arrbyte2,arr)

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}