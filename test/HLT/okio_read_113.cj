// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_read_113{

    @TestCase
    func okio_read_113(): Unit {
        var exc = ""
        try {
            var arr : Array<Byte> = "hello world".toUtf8Array()
            var bas = ByteArrayStream()
            bas.write(arr)

            let bs = ByteString.read(bas,-1)

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(exc.contains("byteCount < 0"),true)
    }   
}