// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.time.*
import io4cj.ByteString
import std.io.ByteBuffer

@Test
public class okio_read_112{

    @TestCase
    func okio_read_112(): Unit {
        var exc = ""
        try {
            var arr : Array<Byte> = "hello world".toArray()
            var bas = ByteBuffer()
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