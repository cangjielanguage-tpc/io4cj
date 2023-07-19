// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from std import fs.*
from io4cj import okio.*

@Test
public class okio_write_139{

    @TestCase
    func okio_write_139(): Unit {
        var exc = ""
        try {

            var str = "hello world"
            let arr:Array<Byte> = str.toUtf8Array()
            println(arr)
            let bs = ByteString(arr)
            bs.write("../abc/okio_write_139.txt")

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
        @Assert(exc.contains("does not exist"),true)
    }   
}