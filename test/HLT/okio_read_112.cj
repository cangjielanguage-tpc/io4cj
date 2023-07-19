// 3rd_party_lib:io4cj/build/io4cj
// 3rd_party_lib:io4cj/ci_lib/crypto4cj

from std import io.*
from std import time.*
from io4cj import okio.*

@Test
public class okio_read_112{

    @TestCase
    func okio_read_112(): Unit {
        var exc = ""
        try {
            var arr : Array<Byte> = "hello world".toUtf8Array()
            var bas = ByteArrayStream()
            bas.write(arr)

            let bs = ByteString.read(bas,10)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello worl]")


        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message
        }
    }   
}