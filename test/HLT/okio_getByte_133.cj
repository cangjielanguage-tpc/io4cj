// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_getByte_133 {

    @TestCase
    func okio_getByte_133(): Unit {
        var exc = ""
        try {
            let str = ""
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.getByte(0)}")
        } catch (e:Exception) {
            // e.printStackTrace()
            // println("e.message = ${e.message}")
            exc = "IndexOutOfBoundsException"
        }
        @Assert(exc.contains("IndexOutOfBoundsException"),true)
    }   
}