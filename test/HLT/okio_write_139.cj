// 3rd_party_lib:okio/build/okio

from std import io.*
from std import time.*
from std import fs.*
from okio import okio.*

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
        @Assert(exc.contains("Failed to open the file!"),true)
    }   
}