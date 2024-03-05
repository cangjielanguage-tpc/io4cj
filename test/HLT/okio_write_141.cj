// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_read_141 {

    @TestCase
    func okio_read_141(): Unit {
        var exc = ""
        try {
            var okbf = okio.Buffer()
            var byteString = ByteString("hello".toArray())
            byteString.write(okbf)
            var okbf_str = okbf.readUtf8()
            println("okbf = ${okbf_str}")
            @Assert(okbf_str,"hello")

            byteString = ByteString("hello".toArray())
            byteString.write(okbf)
            byteString = ByteString(" world".toArray())
            byteString.write(okbf)

            okbf_str = okbf.readUtf8()
            println("okbf = ${okbf_str}")
            @Assert(okbf_str,"hello world")
        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}