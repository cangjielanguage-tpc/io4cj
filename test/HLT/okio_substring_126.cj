// 3rd_party_lib:io4cj/target/release/io4cj
// 3rd_party_lib:io4cj/target/release/crypto4cj

import std.io.*
import std.time.*
import io4cj.*

@Test
public class okio_substring_126 {

    @TestCase
    func okio_substring_126(): Unit {
        var exc = ""
        try {
            let str = "hello world"
            let arr:Array<Byte> = str.toArray()
            println(arr)
            let bs = ByteString(arr)
            println("bs = ${bs.substring(11,11)}")
            @Assert(bs.substring(11,11).toString(),"[size=0]")

        } catch (e:Exception) {
            e.printStackTrace()
            println("e.message = ${e.message}")
            exc = e.message
        }
    }   
}