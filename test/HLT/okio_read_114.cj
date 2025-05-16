// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.time.*
import io4cj.ByteString
import std.io.ByteBuffer

@Test
public class okio_read_114{

    @TestCase
    func okio_read_114(): Unit {
        var exc = ""
        try {
            var arr : Array<Byte> = "hello world".toArray()
            var bas = ByteBuffer()
            bas.write(arr)

            let bs = ByteString.read(bas,bas.length)
            println("bs = ${bs.toString()}")
            @Assert(bs.toString(),"[text=hello world]")

            var arr2 : Array<Byte> = "".toArray()
            var bas2 = ByteBuffer()
            bas2.write(arr2)

            let bs2 = ByteString.read(bas2,bas2.length)
            println("bs = ${bs2.toString()}")
            @Assert(bs2.toString(),"[size=0]")

        } catch (e:Exception) {
            // e.printStack Trace()
            println("e.message = ${e.message}")
            exc = e.message 
        }
    }   
}