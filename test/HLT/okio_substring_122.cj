// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_substring_122 {

    @TestCase
    func okio_substring_122(): Unit {
        var exc = ""
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.substring(-1)}")
            @Assert(bs.substring(-1).toString(),"[text=hello world]")

        } catch (e:Exception) {
            //e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message
        }
        @Assert(exc.contains("beginIndex < 0"),true)
    }   
}