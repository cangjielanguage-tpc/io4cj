// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto_ffi

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_getByte_131 {

    @TestCase
    func okio_getByte_131(): Unit {
        var exc = ""
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.getByte(11)}")
        } catch (e:IndexOutOfBoundsException) {
            // e.printStackTrace()
            println("e.message = \"IndexOutOfBoundsException\"")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc,"IndexOutOfBoundsException")
    }   
}