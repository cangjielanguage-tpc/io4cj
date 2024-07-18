// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_read_109{

    @TestCase
    func okio_read_109(): Unit {
        var exc = ""
        try {
            var arr : Array<Byte> = "hello world".toArray()
            var bas = ByteArrayStream()
            bas.write(arr)

            let bs = ByteString.read(bas,11)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello world]")


        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message
        }
    }   
}